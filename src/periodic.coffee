_ = require 'lodash'
signal = require './signal'

intervalIds = {}

# motion functions
# TODO: basically, motion functions map signals onto paper.js properties (bounds, segment.position, etc.)
# Any motion function will work equally well with any signal.
# As such, the TODO is to refactor this module so that motion functions can be composed from a signal
# and a paper.js mapping function (mapToBounds, mapToOrthogonalSegmentPoint, etc.)

pulse = (samplesPerPeriod, item) ->
  nextSignalValue = new signal.Sine(samplesPerPeriod, 0, 0.5, 1.5)
  originalBounds = item.bounds
  () ->
    newBounds = originalBounds.scale nextSignalValue()
    item.bounds = newBounds
    view.update()

sway = (samplesPerPeriod, path, swayDistance = 5) ->
  defineData = (segment, phaseOffset) ->
    segment.data ?= {}
    segment.data.signal ?= new signal.Sine(samplesPerPeriod, phaseOffset)
    segment.data.originalPoint ?= segment.point.clone()
  swaySegment = (s) ->
    offset = path.getOffsetOf s.point
    defineData s, offset
    normal = path.getNormalAt offset
    swayMagnitude = swayDistance * s.data.signal()
    s.point = s.data.originalPoint.add normal.multiply swayMagnitude
  () ->
    path.segments.forEach swaySegment


scheduleMotion = (motion) ->
  (seconds, item, updatesPerSecond = 30, otherArguments...) ->
    samplesPerPeriod = seconds * updatesPerSecond
    move = motion(samplesPerPeriod, item, otherArguments...)
    schedule updatesPerSecond, item.id, move

schedule = (updatesPerSecond, key, func) ->
  millisecondsBetweenUpdates = 1000 / updatesPerSecond
  intervalIds[key] = setInterval func, millisecondsBetweenUpdates

stop = (item) ->
  # this will only cancel the most recent animation
  # applied to an object. how do we handle multiple
  # animations on one object?
  intervalId = intervalIds[item.id]
  clearInterval(intervalId)



module.exports =
  stop: stop
  pulse: scheduleMotion pulse
  sway: scheduleMotion sway
