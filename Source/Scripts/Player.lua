class('Player').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local circuitImageTable <const> = gfx.imagetable.new("Assets/circuit")

-- Player
--
function Player:init()

	Player.super.init(self)
	local tiles <const> = gfx.imagetable.new("Levels/tiles")
	self:setImage(tiles:getImage(1))
	self:setCenter(0, 0)
	self:moveTo(150, 10)
	self:setZIndex(99)
	self:setCollideRect(0, 0, self:getSize())
	self:add()
	-- History
	self.history = {}
	self.history.array = {}
	self.history.push = function(_, p, t)
		local item = {}
		item.point = p
		item.trace = t
		return table.insert(self.history.array, item)
	end
	self.history.pop = function()
		return table.remove(self.history.array)
	end
	return self

end

-- leaveTrace(x, y)
--
-- Leave a trace behind the player after moving.
function Player:leaveTrace(x, y)

	-- Set positions for n, n-1 and n-2 moves
	local n = playdate.geometry.point.new(self.x, self.y)
	local n1 = playdate.geometry.point.new(x, y)
	local n2 = nil
	if #self.history.array > 0 then
		n2 = self.history.array[#self.history.array].point
	end
	-- Set circuit image index depending on n, n-1 and n-2
	local imageIndex = 5
	if n2 == nil then
		if n.y == n1.y then
			-- horizontal straight
			imageIndex = 2
		elseif n.x == n1.x then
			-- vertical straight
			imageIndex = 4
		end
	elseif n.y == n1.y and n.y == n2.y then
		-- horizontal straight
		imageIndex = 2
	elseif n.x == n1.x and n.x == n2.x then
		-- vertical straight
		imageIndex = 4
	elseif (n.x > n1.x and n2.y > n.y) or (n.y > n1.y and n2.x > n.x) then
		-- top left
		imageIndex = 1
	elseif (n.x < n1.x and n2.y > n.y) or (n.y > n1.y and n2.x < n.x) then
		-- top right
		imageIndex = 3
	elseif (n.x > n1.x and n2.y < n.y) or (n.y < n1.y and n2.x > n.x) then
		-- bottom left
		imageIndex = 7
	elseif (n.x < n1.x and n2.y < n.y) or (n.y < n1.y and n2.x < n.x) then
		-- bottom right
		imageIndex = 9
	end
	-- Create sprite
	local image <const> = circuitImageTable:getImage(imageIndex)
	local sprite <const> = gfx.sprite.new(image)
	sprite:setCenter(0, 0)
	sprite:setCollideRect(0, 0, sprite:getSize())
	sprite:moveTo(x, y)
	sprite:add()
	return sprite

end

-- back()
--
function Player:back()

	if #self.history.array > 0 then

		local item = self.history:pop()
		self:moveTo(item.point)
		item.trace:remove()

	end

end

-- move()
--
function Player:move(newX, newY)

	local previousX, previousY = self:getPosition()
	local actualX, actualY = self:moveWithCollisions(newX, newY)
	if newX == actualX and newY == actualY then
		local trace <const> = self:leaveTrace(previousX, previousY)
		self.history:push(playdate.geometry.point.new(previousX, previousY), trace)
	end

end

-- up()
--
function Player:up()

	self:move(self.x, self.y - 20)

end

-- down()
--
function Player:down()

	self:move(self.x, self.y + 20)

end

-- left()
--
function Player:left()

	self:move(self.x - 20, self.y)

end

-- right()
--
function Player:right()

	self:move(self.x + 20, self.y)

end