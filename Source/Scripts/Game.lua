class("Game").extends()

local gfx <const> = playdate.graphics

function Game:init()

	Game.super.init(self)
	self.tiles = gfx.imagetable.new("Assets/tiles")
	local s = gfx.sprite.new(self.tiles:getImage(1))
	s:moveTo(200, 120)
	s:add()
	self:load()
	return self

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
