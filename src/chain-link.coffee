_ = require 'lodash'

ChainLink = (center = view.center, radius = 100, width = 100) ->
  path = new Path.Circle(center, radius)
  path.visible = false
  segments = path.segments

  # duplicate top segment
  path.insert(1, segments[1].clone())

  # duplicate bottom segment
  path.insert(4, segments[4].clone())

  # stretch circle into chain link
  [2, 3, 4].forEach (i) ->
    segment = segments[i]
    segment.point = segment.point.add [width, 0]

  # define quadrants
  Quadrant = (min, max, segments...) ->
    Quadrant.all ?= []
    Quadrant.all.push this

    this.curve = new paper.Curve(segments...)
    this.contains = (angle) ->
      while angle > 360 then angle -= 360
      min <= angle <= max
    this.pointFor = (angle) =>
      normalizedAngle = (angle - min) / (max - min)
      this.curve.getPointAt normalizedAngle, true
    this

  Quadrant.for = (angle) ->
    _.find Quadrant.all, (q) -> q.contains(angle)

  new Quadrant(0, 90, segments[2], segments[3])
  new Quadrant(90, 180, segments[3], segments[4])
  new Quadrant(180, 270, segments[5], segments[0])
  new Quadrant(270, 360, segments[0], segments[1])

  this.pointFor = (angle) ->
    Quadrant.for(angle).pointFor angle
  this.path = path

  view.update()
  this

window.ChainLink = ChainLink
module.exports = ChainLink
