function love.load()
   score = 0

   playingAreaWidth = 300
   playingAreaHeight = 388

   birdY = 200
   birdYSpeed = 0
   birdX = 62
   birdWidth = 30
   birdHeight = 25
   
   pipeSpaceHeight = 100
   pipeX = playingAreaWidth
   pipeWidth = 54
   pipe1X = playingAreaWidth
   pipe1SpaceY = newPipeSpaceY()

   pipe2X = playingAreaWidth + ((playingAreaWidth + pipeWidth) / 2)
   pipe2SpaceY = newPipeSpaceY()
   
end

function love.draw()
   fillBackground()
   bird()
   pipe(pipe1X, pipe1SpaceY)
   pipe(pipe2X, pipe2SpaceY)

   if (pipeX + pipeWidth) < 0 then
      resetPipe()
  end

  drawScore()
end

function love.update(dt)
   score = score + 1
   birdYSpeed = birdYSpeed + (516 * dt)
   birdY = birdY + (birdYSpeed * dt)
   pipe1X, pipe1SpaceY = movePipe(dt, pipe1X, pipe1SpaceY)
   pipe2X, pipe2SpaceY = movePipe(dt, pipe2X, pipe2SpaceY)
   handleCollision(pipe1X, pipe1SpaceY)
   handleCollision(pipe2X, pipe2SpaceY)
end

function love.keypressed(key)
   if birdY > 0 then
      birdYSpeed = -165
   end
end

function drawScore()
   love.graphics.setColor(1, 1, 1)
   love.graphics.print(score, 15, 15)
end

function fillBackground()
   love.graphics.setColor(.14, .36, .46)
   love.graphics.rectangle('fill', 0, 0, playingAreaWidth, playingAreaHeight)
end

function pipe(pipeX, pipeSpaceY)

   love.graphics.setColor(.37, .82, .28)
   love.graphics.rectangle(
      'fill',
      pipeX,
      0,
      pipeWidth,
      pipeSpaceY
   )
   love.graphics.rectangle(
      'fill',
      pipeX,
      pipeSpaceY + pipeSpaceHeight,
      pipeWidth,
      playingAreaHeight - pipeSpaceY - pipeSpaceHeight
   )
end

function movePipe(dt, pipeX, pipeSpaceY)
   pipeX = pipeX - (60 * dt)
   
   if (pipeX + pipeWidth) < 0 then
       pipeX = playingAreaWidth
       pipeSpaceY = newPipeSpaceY()
   end

   return pipeX, pipeSpaceY
end

function newPipeSpaceY()
   local pipeSpaceYMin = 54
   return love.math.random(
      pipeSpaceYMin,
      playingAreaHeight - pipeSpaceHeight - pipeSpaceYMin
   )
end

function bird()
   love.graphics.setColor(.87, .84, .27)
   love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)
end

function handleCollision(pipeX, pipeSpaceY)
   if birdX < (pipeX + pipeWidth) and 
      (birdX + birdWidth) > pipeX and 
      (birdY < pipeSpaceY or ((birdY + birdHeight) > (pipeSpaceY + pipeSpaceHeight)))
      or birdY > playingAreaHeight 
   then
      love.load()
   end
end
