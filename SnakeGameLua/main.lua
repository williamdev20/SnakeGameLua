snake = {
  positions = {
    { x = 100, y = 40 },
    { x = 80,  y = 40 },
    { x = 60,  y = 40 }
  },
  size = 20,
  width = 20,
  height = 20
}

ranX = math.floor(760 / 20)
ranY = math.floor(560 / 20)

fruit = {
  randomX = math.random(2, ranX) * 20,
  randomY = math.random(2, ranY) * 20,
  width = 20,
  height = 20
}

score = 0

direction = " "
movDirection = " "

function love.load()
  love.window.setTitle("Snake Game")
  fontePadrao = love.graphics.newFont(20)
  fonte = love.graphics.newFont("assets/fonts/Cabin-VariableFont_wdth,wght.ttf", 50)
end

isGameOver = false

function gameOver()
  isGameOver = true
end

isColision = false



function love.update(dt)
  head = { x = snake.positions[1].x, y = snake.positions[1].y }

  -- Verificação pra ficar parado
  if isGameOver then

  else
    if snake.positions[1].x >= 780 or snake.positions[1].x <= 0 or snake.positions[1].y <= 0 or snake.positions[1].y >= 580 then
      gameOver()
    else
      if love.keyboard.isDown("right") and direction ~= "left" then
        direction = "right"
      elseif love.keyboard.isDown("left") and direction ~= "right" then
        direction = "left"
      elseif love.keyboard.isDown("up") and direction ~= "down" then
        direction = "up"
      elseif love.keyboard.isDown("down") and direction ~= "up" then
        direction = "down"
      end

      if direction == "right" then
        head.x = head.x + snake.size
        love.timer.sleep(0.1)
      elseif direction == "left" then
        head.x = head.x - snake.size
        love.timer.sleep(0.1)
      elseif direction == "up" then
        head.y = head.y - snake.size
        love.timer.sleep(0.1)
      elseif direction == "down" then
        head.y = head.y + snake.size
        love.timer.sleep(0.1)
      end
    end
  end

  --- Colisão com a própria cobra

  for i = 4, #snake.positions do
    if head.x == snake.positions[i].x and head.y == snake.positions[i].y then
      gameOver()
    end
  end


  table.insert(snake.positions, 1, head)

  -- Colisão com a fruta

  if head.x == fruit.randomX and head.y == fruit.randomY then
    isColision = true
    score = score + 1
  else
    table.remove(snake.positions)
  end

  if isColision then
    fruit.randomX = math.random(2, ranX) * 20
    fruit.randomY = math.random(2, ranY) * 20
    isColision = false
  end
end

function love.draw()
  -- Snake config
  love.graphics.setColor(43 / 255, 172 / 255, 43 / 255)
  love.graphics.rectangle("fill", head.x, head.y, snake.width, snake.height)
  for i = 2, #snake.positions do
    love.graphics.rectangle("fill", snake.positions[i].x, snake.positions[i].y, snake.width, snake.height)
  end
  love.graphics.setFont(fontePadrao)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score)
  -- Fruit config
  love.graphics.setColor(255 / 255, 99 / 255, 71 / 255)
  love.graphics.rectangle("fill", fruit.randomX, fruit.randomY, fruit.width, fruit.height)


  -- Game over config
  if isGameOver then
    love.graphics.setColor(255 / 255, 99 / 255, 71 / 255)
    love.graphics.setFont(fonte)
    fontWidth = fonte:getWidth("GAME OVER!")
    fontHeight = fonte:getHeight()
    love.graphics.print("GAME OVER!", (love.graphics.getWidth() - fontWidth) / 2,
      (love.graphics.getHeight() - fontHeight) / 2)
  end
end
