class('Player').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics

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

	local image <const> = gfx.image.new(self.width, self.height, gfx.kColorWhite)
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