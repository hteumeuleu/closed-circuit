class('Level').extends()

local gfx <const> = playdate.graphics
local ldtk <const> = LDtk
ldtk.load("Levels/world.ldtk", false)
local offset <const> = playdate.geometry.point.new(10, 10)
local winSamplePlayer <const> = playdate.sound.sampleplayer.new("Sounds/win")

-- Level
--
function Level:init(index)

	self.index = index
	if self.index < 0 or self.index > 10 then
		self.index = 0
	end
	self.name = "Level_" .. index
	self.total = 0
	self.progress = 0
	self:load()

end

-- load()
--
-- based on SquidGodDev’s video tutorial.
function Level:load()

	gfx.sprite.removeAll()

	local level_name = self.name

	for layer_name, layer in pairs(ldtk.get_layers(level_name)) do
		if layer.tiles then
			local tilemap = ldtk.create_tilemap(level_name, layer_name)
			local layerSprite = gfx.sprite.new()
			layerSprite:setTilemap(tilemap)
			layerSprite:setCenter(0, 0)
			layerSprite:moveTo(offset.x, offset.y)
			layerSprite:setZIndex(layer.zIndex)
			layerSprite:add()

			local emptyTiles = ldtk.get_empty_tileIDs(level_name, "Solid", layer_name)
			if emptyTiles then
				gfx.sprite.addWallSprites(tilemap, emptyTiles, offset.x, offset.y)
			end
		end
	end

	-- Level outer walls
	gfx.sprite.addEmptyCollisionSprite(0, 0, 400, 10)
	gfx.sprite.addEmptyCollisionSprite(0, 230, 400, 10)
	gfx.sprite.addEmptyCollisionSprite(0, 10, 10, 220)
	gfx.sprite.addEmptyCollisionSprite(390, 10, 10, 220)

	-- Entities
	for index, entity in ipairs(LDtk.get_entities(level_name)) do
		if entity.name == "Light" then
			local light = Light(entity.position.x + offset.x, entity.position.y + offset.y)
			self.total += 1
			light:attachLevel(self)
		elseif entity.name == "Battery" then
			self.battery = Battery(entity.position.x + offset.x, entity.position.y + offset.y)
		elseif entity.name == "Crate" then
			Crate(entity.position.x + offset.x, entity.position.y + offset.y)
		elseif entity.name == "Player" then
			self.player = Player(entity.position.x + offset.x, entity.position.y + offset.y)
			self.player:attachLevel(self)
		elseif entity.name == "Text" then
			local offGridOffset = playdate.geometry.point.new(tonumber(entity.fields.offsetX), tonumber(entity.fields.offsetY))
			Text(entity.position.x + offset.x + offGridOffset.x, entity.position.y + offset.y + offGridOffset.y, entity.size.width, entity.size.height, entity.fields.text, tonumber(entity.fields.alignment))
		end
	end

	if self.battery and self.player then

		self.player:attachBattery(self.battery)

	end

	-- White flash effect
	local animator = playdate.graphics.animator.new(500, 1, 0,  playdate.easingFunctions.outQuad, 200)
	local white = gfx.image.new(400, 240, gfx.kColorWhite)
	local flash = gfx.sprite.new(white)
	flash:setCenter(0, 0)
	flash:moveTo(0, 0)
	flash:setZIndex(999)
	flash:add()
	flash.update = function(that)
		if not animator:ended() then
			that:setImage(white:fadedImage(animator:currentValue(), gfx.image.kDitherTypeAtkinson))
		end
	end

end

-- win()
--
function Level:win()

	-- Sound
	winSamplePlayer:play()
	-- Value checked by Game object
	self.isWon = true

end