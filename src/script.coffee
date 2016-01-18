util = require './util'
IrregularPolygon = require './irregular-polygon'
ChainLink = require './chain-link'
Grass = require './grass'
motion = require './motion'
periodic = require './periodic'


randomInterval = (min, max) ->
  return Math.floor(Math.random() * max) + min

window.onload = () ->
  # Set up paper.js
  paper.install window
  paper.setup 'canv'

  project.currentStyle.strokeColor = 'black'
  project.currentStyle.strokeWidth = 5
  tool = new Tool()
  center = new Point(view.center)
  tool.onMouseDown = () ->
    randomSize = view.bounds.size.multiply Size.random()
    center = new Point(randomSize.width, randomSize.height)
    cl = new ChainLink(center, 50, 60)
    ip = new IrregularPolygon(center, cl)
    ip.complete()
    periodic.pulse 1000, ip.path

  i = 0
  view.onFrame = () ->
    skip = (i % 2) is 0
    i += 1
    return if skip
<<<<<<< HEAD
    pulsers.forEach (p) -> p.move()
    #grasses.forEach (g) -> g.move() # doing what it's supposed to, but suuuuper lags
=======
    grasses.forEach (g) -> g.move() #grasping at straws here...
>>>>>>> b21cf49b321ce5c46b05292842e7776bbc9ff5e5
    view.update()

  grasses = []
  tool.onKeyDown = (event) ->
    if event.key is 'g' #spawn grass
      randomSize = view.bounds.size.multiply Size.random()
      bottom = new Point(randomSize.width, randomInterval(view.bounds.size.height * 0.5, view.bounds.size.height))
      height = randomInterval(100, 200)
      g = new Grass(bottom, height)

      #grasses.push new motion.Sway g.blade # should add the sway motion... not sure what's up, but it breaks shrinking/growing
      grasses.push g

    # wind
    else if event.key is 'w' # start wind
      console.log 'whooosh'
      for blade in grasses
        blade.wind()

    else if event.key is 'q' # stop wind
      console.log 'unwhoosh'
      for blade in grasses
        blade.stopWind()

    else if event.key is 's' # grow
      for blade in grasses
        blade.shrink(-5)

    else if event.key is 'a' #shrink
      for blade in grasses
          blade.shrink(5)

  tool.onMouseMove = (event) ->
    null
