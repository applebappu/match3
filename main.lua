-- BOARD --
tile_size = 20
board_size = 10
board = {}
for i = 1, board_size do
	board[i] = {}
	local gem = {}
	for j = 1, board_size do
		board[i][j] = {"o", gem}
	end
end

-- FONT --
font = love.graphics.newFont("courier.ttf", tile_size)
love.graphics.setFont(font)

-- CURSOR --
cursor = {
	blink_timer = 0,
	blink_time = 0.25,
	visible = true,
	position = {
		x = 1, 
		y = 1
	}
}

-- GEMS --
gems = {
	red = {255,0,0},
	green = {0,255,0},
	blue = {0,0,255},
	white = {255,255,255}
}

function love.draw()
	for i = 1, #board do
		for j = 1, #board[i] do
			love.graphics.print(board[i][j][1], i * tile_size, j * tile_size)
		end
	end

	if cursor.visible then
		love.graphics.rectangle("line", (cursor.position.x * tile_size) - tile_size/4, cursor.position.y * tile_size , tile_size, tile_size)
	end
end

function love.update(dt)
	-- blink the cursor on and off
	cursor.blink_timer = cursor.blink_timer + 1 * dt
	if cursor.blink_timer >= cursor.blink_time then
		cursor.blink_timer = 0
		if cursor.visible == true then
			cursor.visible = false
		else
			cursor.visible = true
		end
	end
end

function love.keyreleased(k)
	if k == "escape" then
		love.event.quit()
	elseif k == "left" then
		cursor.position.x = cursor.position.x - 1
		if cursor.position.x < 1 then
			cursor.position.x = 1
		end
	elseif k == "right" then
		cursor.position.x = cursor.position.x + 1
		if cursor.position.x > board_size then
			cursor.position.x = board_size
		end
	elseif k == "down" then
		cursor.position.y = cursor.position.y + 1
		if cursor.position.y > board_size then
			cursor.position.y = board_size
		end
	elseif k == "up" then
		cursor.position.y = cursor.position.y - 1
		if cursor.position.y < 1 then
			cursor.position.y = 1
		end
	end
end
