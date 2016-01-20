_ = require 'lodash'
signal = require './signal'

intervalIds = {}

# motion functions
# TODO: basically, motion functions map signals onto paper.js properties (bounds, segment.position, etc.)
# Any motion function will work equally well with any signal.
# As such, the TODO is to refactor this module so that motion functions can be composed from a signal
# and a paper.js mapping function (mapToBounds, mapToOrthogonalSegmentPoint, etc.)

scaleBounds = (samplesPerPeriod, item, Signal) ->
  nextSignalValue = new Signal(samplesPerPeriod, 0, 0.5, 1.5)
  originalBounds = item.bounds
  () ->
    newBounds = originalBounds.scale nextSignalValue()
    item.bounds = newBounds

phaseSegments = (samplesPerPeriod, pathOrCompoundPath, Signal, swayDistance = 5) ->
  defineData = (segment, phaseOffset) ->
    segment.data ?= {}
    segment.data.signal ?= new Signal(samplesPerPeriod, phaseOffset)
    segment.data.originalPoint ?= segment.point.clone()
  swaySegment = (path, segment) ->
    offset = path.getOffsetOf segment.point
    defineData segment, offset
    normal = path.getNormalAt offset
    swayMagnitude = swayDistance * segment.data.signal()
    segment.point = segment.data.originalPoint.add normal.multiply swayMagnitude
  if pathOrCompoundPath instanceof paper.CompoundPath
    () ->
      pathOrCompoundPath.children.forEach (child) ->
        child.segments.forEach (segment) ->
          swaySegment child, segment
  else
    () ->
      pathOrCompoundPath.segments.forEach (segment) ->
        swaySegment pathOrCompoundPath, segment

scheduleMotion = (motion, signal) ->
  startPeriodicMotion = (seconds, item, updatesPerSecond = 30, otherArguments...) ->
    samplesPerPeriod = seconds * updatesPerSecond
    move = motion(samplesPerPeriod, item, signal, otherArguments...)
    update = () ->
      move()
      view.update()
    schedule updatesPerSecond, item.id, update
  startPeriodicMotion

schedule = (updatesPerSecond, key, func) ->
  millisecondsBetweenUpdates = 1000 / updatesPerSecond
  intervalIds[key] ?= []
  intervalIds[key].push setInterval func, millisecondsBetweenUpdates

stop = (item) ->
  # this will only cancel the most recent animation
  # applied to an object. how do we handle multiple
  # animations on one object?
  intervalIds = intervalIds[item.id]
  clearInterval(id) for id in intervalIds

module.exports =
  stop: stop
  pulse: scheduleMotion scaleBounds, signal.SawIntegral
  sway: scheduleMotion phaseSegments, signal.Sine
