class("Game").extends()

local gfx <const> = playdate.graphics
local font <const> = gfx.font.new("Assets/closed")
gfx.setFont(font)

function Game:init()

	Game.super.init(self)
	self:attachEvents()
	self.level = Level(1)
	self:load()
	return self

end

-- attachEvents()
--
function Game:attachEvents()

	local myInputHandlers = {

		leftButtonDown = function()
			self.level.player:left()
		end,
		rightButtonDown = function()
			self.level.player:right()
		end,
		upButtonDown = function()
			self.level.player:up()
		end,
		downButtonDown = function()
			self.level.player:down()
		end,
		BButtonDown = function()
			local function timerCallback()
				self.level.player:back()
			end
			self.BButtonDownTimer = playdate.timer.keyRepeatTimer(timerCallback)
		end,
		BButtonUp = function()
			self.BButtonDownTimer:remove()
		end,

	}
	playdate.inputHandlers.push(myInputHandlers)

end

-- update()
--
function Game:update()

	if self.level and self.level.isWon then
		local index = self.level.index
		if index >= 1 and index <= 9 then
			self.level = Level(index+1)
		end
	end

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
