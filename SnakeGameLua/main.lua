snake = {
  positions = {
    { x = 120, y = 40 },
    { x = 80,  y = 40 },
    { x = 40,  y = 40 }
  },
  size = 40,
  spriteBody = love.graphics.newImage("assets/sprites/SnakeBody1.png"),
  spriteDead = love.graphics.newImage("assets/sprites/SnakeDead.png"),
  spriteRight = love.graphics.newImage("assets/sprites/SnakeRight.png"),
  spriteLeft = love.graphics.newImage("assets/sprites/SnakeLeft.png"),
  spriteUp = love.graphics.newImage("assets/sprites/SnakeUp.png"),
  spriteDown = love.graphics.newImage("assets/sprites/SnakeDown.png")
}

ranX = math.floor(960 / 40)
ranY = math.floor(560 / 40)

fruit = {
  randomX = math.random(4, ranX) * 40,
  randomY = math.random(4, ranY) * 40,
  width = 40,
  height = 40,
  spriteFruit = love.graphics.newImage("assets/sprites/Fruit-removebg-preview.png")
}

score = 0

direction = " "
movDirection = " "

function love.load()
  love.window.setMode(1000, 600, {})
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
    if snake.positions[1].x >= 960 or snake.positions[1].x <= 0 or snake.positions[1].y <= 0 or snake.positions[1].y >= 560 then
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
        love.timer.sleep(0.15)
      elseif direction == "left" then
        head.x = head.x - snake.size
        love.timer.sleep(0.15)
      elseif direction == "up" then
        head.y = head.y - snake.size
        love.timer.sleep(0.15)
      elseif direction == "down" then
        head.y = head.y + snake.size
        love.timer.sleep(0.15)
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

  for i = 1, #snake.positions do
    if snake.positions[i].x == fruit.randomX and snake.positions[i].y == fruit.randomY then
      isColision = true
    end
  end

  if isColision then
    fruit.randomX = math.random(4, ranX) * 40
    fruit.randomY = math.random(4, ranY) * 40
    isColision = false
  end
end

function love.draw()
  -- Snake config

  if direction == "right" then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(snake.spriteRight, snake.positions[1].x, snake.positions[1].y)
  elseif direction == "left" then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(snake.spriteLeft, snake.positions[1].x, snake.positions[1].y)
  elseif direction == "up" then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(snake.spriteUp, snake.positions[1].x, snake.positions[1].y)
  elseif direction == "down" then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(snake.spriteDown, snake.positions[1].x, snake.positions[1].y)
  end

  love.graphics.setColor(1, 1, 1, 1)
  for i = 2, #snake.positions do
    love.graphics.draw(snake.spriteBody, snake.positions[i].x, snake.positions[i].y)
  end

  love.graphics.setFont(fontePadrao)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score)
  -- Fruit config

  love.graphics.draw(fruit.spriteFruit, fruit.randomX, fruit.randomY)

  -- Game over config
  if isGameOver then
    love.graphics.setColor(255 / 255, 99 / 255, 71 / 255)
    love.graphics.setFont(fonte)
    fontWidth = fonte:getWidth("GAME OVER!")
    fontHeight = fonte:getHeight()
    love.graphics.print("GAME OVER!", (love.graphics.getWidth() - fontWidth) / 2,
      (love.graphics.getHeight() - fontHeight) / 2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Pressione Enter para jogar novamente", 500)
  end
end
