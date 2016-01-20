_ = require 'lodash'
signal = require './signal'

intervalIds = {}

pulse = (seconds, item, updatesPerSecond = 30) ->
  samplesPerPeriod = seconds * updatesPerSecond
  nextSignalValue = new signal.SawIntegral(samplesPerPeriod, 0.5, 1.5)
  originalBounds = item.bounds
  move = () ->
    # need to figure this function out
    #delta = 1.5 * saw.next()
    #item.bounds = item.bounds.expand delta, delta
    newBounds = originalBounds.scale nextSignalValue()
    item.bounds = newBounds
    view.update()
  schedule updatesPerSecond, item.id, move

stop = (item) ->
  # this will only cancel the most recent animation
  # applied to an object. how do we handle multiple
  # animations on one object?
  intervalId = intervalIds[item.id]
  clearInterval(intervalId)

schedule = (updatesPerSecond, key, func) ->
  millisecondsBetweenUpdates = 1000 / updatesPerSecond
  intervalIds[key] = setInterval func, millisecondsBetweenUpdates

periodic =
  stop: stop
  pulse: pulse

module.exports = periodic
