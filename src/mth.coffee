_ = require 'lodash'

MovingWindow = (memorySize) ->
  contents = []
  this.push = (sample) ->
    length = contents.unshift sample
    while length > memorySize
      contents.pop()
      length = contents.length
  this.average = () ->
    _.sum(contents) / contents.length
  this

mapRange = _.curry (oldMin, oldMax, newMin, newMax, input) ->
  oldRange = oldMax - oldMin
  newRange = newMax - newMin
  (((input - oldMin) * newRange) / oldRange) + newMin

module.exports =
  MovingWindow: MovingWindow
  mapRange: mapRange
