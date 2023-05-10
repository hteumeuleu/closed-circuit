class('Light').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local tiles <const> = gfx.imagetable.new("Levels/tiles")

-- Light
--
function Light:init(x, y)

	Player.super.init(self)
	self.isOn = false
	self:setImage(tiles:getImage(3))
	self:setCenter(0, 0)
	self:moveTo(x, y)
	self:setZIndex(98)
	self:setCollideRect(0, 0, self:getSize())
	self:add()

end

-- toggle()
--
function Light:toggle()

	self.isOn = not self.isOn
	if self.isOn then
		self:setImage(tiles:getImage(4))
	else
		self:setImage(tiles:getImage(3))
	end

end