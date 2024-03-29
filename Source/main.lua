import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/crank"
import "CoreLibs/animator"

import "Scripts/Libraries/LDtk"
import "Scripts/Player"
import "Scripts/Light"
import "Scripts/Battery"
import "Scripts/Crate"
import "Scripts/Text"
import "Scripts/Level"
import "Scripts/Game"
local g <const> = Game()

-- Playdate setup
playdate.setCrankSoundsDisabled(true)
playdate.graphics.setBackgroundColor(playdate.graphics.kColorBlack)
playdate.graphics.sprite.setBackgroundDrawingCallback(
	function(x, y, width, height)
		playdate.graphics.setColor(playdate.graphics.kColorBlack)
		playdate.graphics.fillRect(x, y, width, height)
	end
)

-- playdate.update()
--
function playdate.update()

	playdate.timer.updateTimers()
	playdate.graphics.sprite.update()
	g:update()

end

-- playdate.gameWillTerminate()
--
function playdate.gameWillTerminate()

	g:save()

end

-- playdate.deviceWillSleep()
--
function playdate.deviceWillSleep()

	g:save()

end

-- playdate.gameWillPause()
--
function playdate.gameWillPause()

	g:updatePauseScreen()

end

-- playdate.keyPressed()
--
function playdate.keyPressed(key)

	if key == "s" then
		g:skip()
	end

end