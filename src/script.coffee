util = require './util'
IrregularPolygon = require './irregular-polygon'
ChainLink = require './chain-link'
motion = require './motion'

window.onload = () ->
  # Set up paper.js
  paper.install window
  paper.setup 'canv'

  project.currentStyle.strokeColor = 'black'
  project.currentStyle.strokeWidth = 5
  tool = new Tool()
  center = new Point(view.center)
  pulsers = []
  tool.onMouseDown = () ->
    randomSize = view.bounds.size.multiply Size.random()
    center = new Point(randomSize.width, randomSize.height)
    cl = new ChainLink(center, 50, 60)
    ip = new IrregularPolygon(center, cl.pointFor)
    ip.complete()
    pulsers.push new motion.Pulser ip.path

  i = 0
  view.onFrame = () ->
    skip = (i % 2) is 0
    i += 1
    return if skip
    pulsers.forEach (p) -> p.move()
    view.update()
