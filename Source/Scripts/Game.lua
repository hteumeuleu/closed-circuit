class("Game").extends()

local gfx <const> = playdate.graphics
local font <const> = gfx.font.new("Assets/closed")
gfx.setFont(font)

function Game:init()

	Game.super.init(self)
	self:addHandlers()
	self:addMenuItems()
	self:load()
	return self

end

-- addHandlers()
--
function Game:addHandlers()

	local myInputHandlers = {

		leftButtonDown = function()
			if self.level.index ~= 0 then
				self.level.player:left()
			end
		end,
		rightButtonDown = function()
			if self.level.index ~= 0 then
				self.level.player:right()
			end
		end,
		upButtonDown = function()
			if self.level.index ~= 0 then
				self.level.player:up()
			end
		end,
		downButtonDown = function()
			if self.level.index ~= 0 then
				self.level.player:down()
			end
		end,
		AButtonDown = function()
			if self.level.index == 0 then
				self.level:win()
			end
		end,
		AButtonHeld = function()
			if self.level.index ~= 0 then
				self.level = Level(self.level.index)
			end
		end,
		BButtonDown = function()
			if self.level.index == 0 then
				self.level:win()
			else
				local function timerCallback()
					self.level.player:back()
				end
				self.BButtonDownTimer = playdate.timer.keyRepeatTimer(timerCallback)
			end
		end,
		BButtonUp = function()
			if self.level.index ~= 0 and self.BButtonDownTimer ~= nil then
				self.BButtonDownTimer:remove()
			end
		end,

	}
	playdate.inputHandlers.push(myInputHandlers)

end

-- update()
--
function Game:update()

	if self.level and self.level.isWon then
		local index = self.level.index
		if index < 0 or index >= 10 then
			index = 0
		else
			index += 1
		end
		self.level = Level(index)
	end

end

-- reset()
--
function Game:reset()

	self.level = Level(0)

end

-- skip()
--
function Game:skip()

	local index = self.level.index
	if index < 0 or index >= 10 then
		index = 0
	else
		index += 1
	end
	self.level = Level(index)

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

-- addMenuItems()
--
function Game:addMenuItems()

	local menu = playdate.getSystemMenu()
	menu:addMenuItem("Reset", function()
		self:reset()
	end)

end
