mth = require './mth'

movingAverage = (memorySize, func) ->
  movingWindow = new mth.MovingWindow(memorySize)
  (args...) ->
    result = func args...
    movingWindow.push result
    movingWindow.average()

module.exports.movingAverage = movingAverage

Saw = (samplesPerPeriod) ->
  x = 0.0
  this.next = () ->
    result = 2.0 * (x - Math.floor(x)) - 1
    x += 0.01
    result
  this

module.exports.Saw = Saw

SawAntiderivative = (samplesPerPeriod) ->
  x = 0
  this.next = () ->
    x * (x - period)

DarkSaw = (samplesPerPeriod) ->
  saw = new Saw()
  filtered = movingAverage 15, saw.next
  this.next = filtered
  this

module.exports.DarkSaw = DarkSaw


