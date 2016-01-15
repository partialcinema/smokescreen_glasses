Grass = (bottom, height) ->
  radius = 5
  sharpness = 0.8

  bottomLeft = bottom.subtract [radius, 0]
  topLeft = bottomLeft.subtract [0, height * sharpness]

  bottomRight = bottom.add [radius, 0]
  topRight = bottomRight.subtract [0, height * sharpness]

  top = bottom.subtract [0, height]

  #right side of blade
  leftPath = new Path()
  leftPath.strokeColor = 'darkgreen'
  leftPath.fillColor = 'darkgreen'
  leftPath.strokeWidth = 1
  leftPath.closed = true

  leftPath.add(bottomLeft)
  leftPath.add(topLeft)
  leftPath.add(top)
  leftPath.add(bottom)
  #leftPath.fullySelected = true
  leftPath.segments[2].handleIn = leftPath.segments[2].handleIn.add(-radius, radius)

  #left side of blade
  rightPath = new Path()
  rightPath.strokeColor = 'darkgreen'
  rightPath.fillColor = 'green'
  rightPath.strokeWidth = 1
  rightPath.closed = true

  rightPath.add(bottomRight)
  rightPath.add(topRight)
  rightPath.add(top)
  rightPath.add(bottom)
  rightPath.segments[2].handleIn = rightPath.segments[2].handleIn.add(radius, radius)

  blade = new Group([leftPath, rightPath])

  isBlowing = false
  intervalId = null

  this.wind = () ->
    isBlowing = true
    rotate = () -> blade.rotate(5, bottom)
    rotateIntervalId = setInterval(rotate, 20)

  this.stopWind = () ->
    isBlowing = false
    clearInterval(rotateIntervalId)



  this.grow = (amount) ->
    console.log blade.leftPath.segments[2]

    #view.onFrame(event) ->


  this.shrink = (amount) -> #
    shrinkSegment = () ->
      for path in blade
        path.segments[2].point.y += amount

    shrinkIntervalID = setInterval(shrinkSegment(), 30)



#########################
  view.update()

module.exports = Grass
