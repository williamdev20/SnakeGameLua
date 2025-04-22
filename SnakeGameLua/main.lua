snake = {
	x = 50,
	y = 50,
	speed = 100,
	width = 20,
	height = 20
}

function love.load()		
	love.window.setTitle("Snake Game")
	fontePadrao = love.graphics.newFont(20)
	fonte = love.graphics.newFont("assets/fonts/Cabin-VariableFont_wdth,wght.ttf", 50)
end

isGameOver = false

function gameOver()
	isGameOver = true
end

function love.update(dt)
	if isGameOver then
		
	else
		if snake.x >= 770 then
			gameOver()
		else 
			if love.keyboard.isDown("right") then
				snake.x = snake.x + snake.speed * dt
			end
		end	
		
		if snake.x <= 0 then 
			gameOver()
		else 
			if love.keyboard.isDown("left") then
				snake.x = snake.x - snake.speed * dt
			end
		end

		if snake.y <= 0 then
			gameOver()
		else
			if love.keyboard.isDown("up") then
				snake.y = snake.y - snake.speed * dt
			end
		end

		if snake.y >= 570 then
			gameOver()
		else
			if love.keyboard.isDown("down") then
				snake.y = snake.y + snake.speed * dt
			end
		end
	end
end


function love.draw()
	love.graphics.setColor(43/255, 172/255, 43/255)
	love.graphics.rectangle("fill", snake.x, snake.y, snake.width, snake.height)
	love.graphics.setFont(fontePadrao)
	love.graphics.print(snake.y)
	love.graphics.print(snake.x, 0, 20)

	
	if isGameOver then
		love.graphics.setColor(255/255, 99/255, 71/255)
		love.graphics.setFont(fonte)
		fontWidth = fonte:getWidth("GAME OVER!")
		fontHeight = fonte:getHeight()
		love.graphics.print("GAME OVER!", (love.graphics.getWidth() - fontWidth) / 2, (love.graphics.getHeight() - fontHeight) / 2)
	end
end