signal = require './signal'

module.exports.Pulser = (item) ->
  saw = new signal.DarkSaw()
  #saw = new signal.Saw()
  this.move = () ->
    delta = 10 * saw.next()
    item.bounds = item.bounds.expand delta, delta
  this
