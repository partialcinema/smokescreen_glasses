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
module.exports.MovingWindow = MovingWindow
