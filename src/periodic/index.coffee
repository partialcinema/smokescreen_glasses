signals = require './signal'
modulators = require './modulators'

intervalIds = {}

scheduleMotion = (motion, signal) ->
  startPeriodicMotion = (seconds, item, updatesPerSecond = 30, otherArguments...) ->
    samplesPerPeriod = seconds * updatesPerSecond
    move = motion(samplesPerPeriod, item, signal, otherArguments...)
    update = () ->
      move()
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
  pulse: scheduleMotion modulators.scaleBounds, signals.SawIntegral
  sway: scheduleMotion modulators.phaseSegments, signals.Sine
