snake = {
  x = 40,
  y = 40,
  speed = 20,
  width = 20,
  height = 20
}

ranX = math.floor(780 / 20)
ranY = math.floor(580 / 20)

fruit = {
  randomX = math.random(0, ranX) * 20,
  randomY = math.random(0, ranY) * 20,
  width = 20,
  height = 20
}

direction = " "

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
  -- Verificação pra ficar parado
  if isGameOver then

  else
    if snake.x >= 780 or snake.x <= 0 or snake.y <= 0 or snake.y >= 580 then
      gameOver()
    else
      if love.keyboard.isDown("right") then
        direction = "right"
      elseif love.keyboard.isDown("left") then
        direction = "left"
      elseif love.keyboard.isDown("up") then
        direction = "up"
      elseif love.keyboard.isDown("down") then
        direction = "down"
      end

      if direction == "right" then
        snake.x = snake.x + snake.speed
        love.timer.sleep(0.1)
      elseif direction == "left" then
        snake.x = snake.x - snake.speed
        love.timer.sleep(0.1)
      elseif direction == "up" then
        snake.y = snake.y - snake.speed
        love.timer.sleep(0.1)
      elseif direction == "down" then
        snake.y = snake.y + snake.speed
        love.timer.sleep(0.1)
      end
    end
  end


  -- Colisão com a fruta

  if snake.x == fruit.randomX and snake.y == fruit.randomY then
    isColision = true
  end


  --[[  if snake.x < fruit.width + fruit.randomX and
      snake.x + fruit.width > fruit.randomX and
      snake.y < fruit.height + fruit.randomY and
      snake.y + fruit.height > fruit.randomY then
    isColision = true
  end

  --]]

  if isColision then
    fruit.randomX = math.random(0, ranX) * 20
    fruit.randomY = math.random(0, ranY) * 20
    isColision = false
  end

  function love.draw()
    -- Snake config
    love.graphics.setColor(43 / 255, 172 / 255, 43 / 255)
    love.graphics.rectangle("fill", snake.x, snake.y, snake.width, snake.height)
    love.graphics.setFont(fontePadrao)
    love.graphics.print(snake.y)
    love.graphics.print(snake.x, 0, 20)
    love.graphics.print(fruit.randomX, 0, 40)
    love.graphics.print(fruit.randomY, 0, 60)

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
end

-- Pesquisar todos os temas da atividade de historia individualmente, um resumo de forma bem resumida. Escolher apenas uma para apresentar. O individual é somente texto. Entregar o link do docs na atividade. Pode ser um vídeo didático (como o do trabalho de química)
