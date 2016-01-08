regularDistribution = (options) ->
  { samples, min, max, inclusive } = options
  inclusive = true if not inclusive?
  width = max - min

  addValue = (i) ->
    min + (width * (i / samples))
  range = if inclusive then [0..samples] else [1...samples]
  range.map addValue

random = (min, max) ->
  dist = max - min
  min + (Math.random() * dist)

clamp = (n, min, max) ->
  n = Math.max(n, min) if min?
  n = Math.min(n, max) if max?
  n

DrunkenWalk = (options) ->
  { startingValue, noiseAmplitude, clamp: { min, max } } = options
  noiseMax = noiseAmplitude / 2
  noiseMin = -noiseMax
  @previousValue = startingValue
  next: () => 
    currentValue = @previousValue + random noiseMin, noiseMax
    currentValue = clamp currentValue, min, max
    @previousValue = currentValue
    currentValue

line = (p1, p2) ->
  slope = (p2.y - p1.y) / (p2.x - p1.x)
  (x) -> slope * (x - p1.x) + p1.y

mix = (a, b, proportion) ->
  inverseProportion = 1 - proportion
  (a * proportion) + (b * inverseProportion)

window.onload = () ->
  # Set up paper.js
  paper.install window
  paper.setup 'canv'

  project.currentStyle.strokeColor = 'black'
  project.currentStyle.strokeWidth = 5
  tool = new Tool()

  angle = 0
  angleStepSize = 90
  radius = 50
  center = new Point(view.center)
  path = new Path()
  addSide = () ->
    onPerimeter = new Point(angle: angle, length: radius).add center
    if (360 - angle) <= angleStepSize
      path.closed = true
    else
      path.add onPerimeter
    angle += Math.random() * angleStepSize
    view.update()
  tool.onMouseDown = addSide
  addSide()
  #bleep
  #view.onFrame = () ->
    #view.update()
