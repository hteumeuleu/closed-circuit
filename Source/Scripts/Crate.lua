class('Crate').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local tiles <const> = gfx.imagetable.new("Levels/tiles")

-- Crate
--
function Crate:init(x, y)

	Crate.super.init(self)
	self:setImage(tiles:getImage(8))
	self:setCenter(0, 0)
	self:moveTo(x, y)
	self:setZIndex(100)
	self:setCollideRect(0, 0, self:getSize())
	self:add()

end