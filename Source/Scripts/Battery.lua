class('Battery').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local tiles <const> = gfx.imagetable.new("Levels/tiles")

-- Battery
--
function Battery:init(x, y)

	Battery.super.init(self)
	self.isOn = false
	self:setImage(tiles:getImage(2))
	self:setCenter(0, 0)
	self:moveTo(x, y)
	self:setZIndex(100)
	self:setCollideRect(0, 0, self:getSize())
	self:add()

end