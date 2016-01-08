_ = require 'lodash'

angleStepSize = 90
pointOnCircle = _.curry (center, angle) ->
  new paper.Point(angle: angle, length: 50).add center

IrregularPolygon = (center, pointFor = pointOnCircle(center)) ->
  angle = 0

  path = new Path()
  addSide = () ->
    return true if path.closed
    next = pointFor(angle)
    if angle > 360
      path.closed = true
    else
      path.add next
    angle += Math.random() * angleStepSize
    view.update()
    path.closed
  complete = () ->
    completed = false
    while(!completed)
      completed = addSide()
  addSide()
  this.addSide = addSide
  this.complete = complete
  this.path = path
  this

module.exports = IrregularPolygon
