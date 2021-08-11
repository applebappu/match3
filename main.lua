love.window.setTitle('Match 3')

-- GEMS --
gems = {
	[1] = {255,0,0},
	[2] = {0,255,0},
	[3] = {0,0,255},
	[4] = {255,255,255}
}

-- BOARD --
tile_size = 20
board_size = 10
board = {}
for i = 1, board_size do
	board[i] = {}
		
	for j = 1, board_size do
		board[i][j] = {"o", gems[math.random(1,4)], false}
	end
end

love.window.setMode((board_size + 2) * tile_size, (board_size + 2) * tile_size)

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

print(board[1][1][2])

function love.draw()
	for i = 1, #board do
		for j = 1, #board[i] do
			if board[i][j][3] == false then
				love.graphics.setColor(board[i][j][2][1], board[i][j][2][2], board[i][j][2][3])
				love.graphics.print(board[i][j][1], i * tile_size, j * tile_size)
			end
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
	-- find matches, remove them
	for i = 1, #board do
		for j = 1, #board[i] do
			local tile1 = board[i][j]
			if board[i + 1][j] ~= nil then
				local tile2 = board[i + 1][j]
			end
			if board[i + 2][j] ~= nil then
				local tile3 = board[i + 2][j]
			end
			local tile2v = board[i][j + 1]
			local tile3v = board[i][j + 2]

			if tile1 == tile2 then
				if tile2 == tile3 then
					tile1[3] = true
					tile2[3] = true
					tile3[3] = true
				end
			elseif tile1 == tile2v then
				if tile2v == tile3v then
					tile1[3] = true
					tile2v[3] = true
					tile3v[3] = true
				end
			end	
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
