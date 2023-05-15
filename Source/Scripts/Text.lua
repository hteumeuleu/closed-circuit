class('Text').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local font <const> = gfx.getFont()

-- Text
--
function Text:init(x, y, w, h, value, alignment)

	Text.super.init(self)
	-- Font values
	local leading <const> = 4
	local fontHeight <const> = font:getHeight()
	-- Calculate where the text should be drawn vertically within the image
	local innerTextWidth, innerTextHeight = gfx.getTextSize(value)
	local innerTextLeading = (innerTextHeight / fontHeight) * leading
	innerTextHeight += innerTextLeading
	local innerTextX = 0
	local innerTextY = math.floor((h - innerTextHeight) / 2)
	-- Draw text in image
	local image = gfx.image.new(w, h)
	gfx.pushContext(image)
		playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite)
		playdate.graphics.drawTextInRect(value, innerTextX, innerTextY, w, h, leading, "?", alignment)
		playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeCopy)
	gfx.popContext()
	-- Setup sprite
	self:setImage(image)
	self:setCenter(0, 0)
	self:moveTo(x, y)
	self:setZIndex(999)
	self:add()

end