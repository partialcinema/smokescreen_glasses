_ = require 'lodash'
signal = require './signal'

intervalIds = {}


pulse = (seconds, item, updatesPerSecond = 30) ->
  samplesPerPeriod = seconds * updatesPerSecond
  #saw = new signal.DarkSaw(sampleRate)
  #saw = new signal.Saw(sampleRate)
  signal = new signal.SawAntiderivative(samplesPerPeriod)
  originalBounds = item.bounds
  move = () ->
    # need to figure this function out
    delta = 1.5 * saw.next()
    item.bounds = item.bounds.expand delta, delta
  schedule updatesPerSecond, item.id, move

stop = (item) ->
  intervalId = intervalIds[item.id]
  clearInterval(intervalId)

schedule = (updatesPerSecond, key, func) ->
  millisecondsBetweenUpdates = 1000 / updatesPerSecond
  intervalIds[key] = setInterval func, millisecondsBetweenUpdates

periodic =
  stop: stop
  pulse: pulse

module.exports = periodic
