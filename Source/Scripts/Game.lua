class("Game").extends()

local gfx <const> = playdate.graphics
local ldtk <const> = LDtk
local offset <const> = playdate.geometry.point.new(10, 10)
local font <const> = gfx.font.new("Assets/closed")
gfx.setFont(font)

ldtk.load("Levels/world.ldtk", false)

function Game:init()

	Game.super.init(self)
	self:attachEvents()
	self:goToLevel("Level_0")
	self:load()
	return self

end

-- attachEvents()
--
function Game:attachEvents()

	local myInputHandlers = {

		leftButtonDown = function()
			self.player:left()
		end,
		rightButtonDown = function()
			self.player:right()
		end,
		upButtonDown = function()
			self.player:up()
		end,
		downButtonDown = function()
			self.player:down()
		end,
		BButtonDown = function()
			self.player:back()
		end,

	}
	playdate.inputHandlers.push(myInputHandlers)

end

-- goToLevel()
--
-- based on SquidGodDev’s video tutorial.
function Game:goToLevel(level_name)

	gfx.sprite.removeAll()

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
			Light(entity.position.x + offset.x, entity.position.y + offset.y)
		elseif entity.name == "Battery" then
			Battery(entity.position.x + offset.x, entity.position.y + offset.y)
		elseif entity.name == "Player" then
			self.player = Player(entity.position.x + offset.x, entity.position.y + offset.y)
		end
	end


end

-- update()
--
function Game:update()

end

-- restart()
--
function Game:restart()

end

-- serialize()
--
function Game:serialize()

	return ""

end

-- hasSave()
--
function Game:hasSave()

	return playdate.datastore.read("game") ~= nil

end

-- save()
--
function Game:save()

	local prettyPrint = false
	if playdate.isSimulator then
		prettyPrint = true
	end
	local serialized = self:serialize()
	playdate.datastore.write(serialized, "game", prettyPrint)

end

-- load()
--
function Game:load()

	local save = playdate.datastore.read("game")
	if save then
	end

end

-- updatePauseScreen()
--
function Game:updatePauseScreen()

end