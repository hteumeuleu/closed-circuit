class("Game").extends()

local gfx <const> = playdate.graphics
local font <const> = gfx.font.new("Assets/closed")
gfx.setFont(font)

function Game:init()

	Game.super.init(self)
	self:addHandlers()
	self:load()
	return self

end

-- addHandlers()
--
function Game:addHandlers()

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
		AButtonHeld = function()
			self.level = Level(self.level.index)
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

	self.level = Level(1)

end

-- serialize()
--
function Game:serialize()

	local data = {}
	data.level = self.level.index
	return data

end

-- hasSave()
--
function Game:hasSave()

	return playdate.datastore.read("game") ~= nil

end

-- save()
--
function Game:save()

	playdate.datastore.write(self:serialize(), "game", playdate.isSimulator)

end

-- load()
--
function Game:load()

	local save = playdate.datastore.read("game")
	local index = 1
	if save then
		index = tonumber(save.level)
	end
	self.level = Level(index)

end

-- updatePauseScreen()
--
function Game:updatePauseScreen()

end
