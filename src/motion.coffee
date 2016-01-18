signal = require './signal'

module.exports.Pulser = (item) ->
  #saw = new signal.DarkSaw()
  saw = new signal.Saw()
  this.move = () ->
    delta = 1.5 * saw.next()
    item.bounds = item.bounds.expand delta, delta
  this
