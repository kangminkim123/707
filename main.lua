-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- created on kangmin
-- created by may 1
-----------------------------------------------------------------------------------------


local physics = require( "physics" )

physics.start()
physics.setGravity( 0, 25 ) -- ( x, y )
physics.setDrawMode( "hybrid" )

local playerBullets = {}

local leftWall = display.newRect( 0, display.contentHeight / 2, 1, display.contentHeight )
--myRectangle.strkewidth = 3
--myRectangle.setFillColor( 0.5 )
--myRectangle.setStrokeColor( 1, 0, 0 )
leftWall.alpha = 0.0
physics.addBody( leftWall, "static", {
	friction = 0.5,
	bounce = 0.3
    } )

local theGround = display.newImage( "./assets/sprites/land.png" )
theGround.x = 520
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, "static", {
	friction = 0.5,
	bounce = 0.3
    } )

local theGround1 = display.newImage( "./assets/sprites/land.png")
theGround1.x = 1520
theGround1.y = display.contentHeight
theGround1.id = "the ground1"
physics.addBody( theGround1, "static", {
	friction = 0.5,
	bounce = 0.3
    } )


local badCharacter = display.newImage( "./assets/sprites/junia.png" )
badCharacter.x = 1520
badCharacter.y = display.contentHeight - 1000
badCharacter.id = "bad character"
physics.addBody( badCharacter, "dynamic", {
	friction = 0.5,
	bounce = 0.3
    } )

local theCharacter = display.newImage( "./assets/sprites/mario.png" )
theCharacter.x = display.contentCenterX 
theCharacter.y = display.contentCenterY
theCharacter.id = "the character"
physics.addBody( theCharacter, "dynamic", {
	density = 3.0,
	friction = 0.5,
	bounce = 0.3
    } )
theCharacter.isFixedRotation = true

local shootButton = display.newImage( "./assets/sprites/jumpButton.png" )
shootButton.x = display.contentWidth - 250
shootButton.y = display.contentHeight - 80
shootButton.id = "shootButton"
shootButton.alpha = 0.5

local dPad = display.newImage( "./assets/sprites/d-pad.png" )
dPad.x = 150
dPad.y = display.contentHeight - 200
dPad.id = "d-pad"

local upArrow = display.newImage( "./assets/sprites/upArrow.png" )
upArrow.x = 150
upArrow.y = display.contentHeight - 310
upArrow.id = "up arrow"

local downArrow = display.newImage( "./assets/sprites/downArrow.png" )
downArrow.x = 150
downArrow.y = display.contentHeight - 90
downArrow.id = "down arrow"

local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 200
leftArrow.id = "left arrow"

local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 200
rightArrow.id = "right arrow"

local jumpButton = display.newImage( "./assets/sprites/jumpButton.png" )
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5

local function checkCharacterCollision( self, event )

	if (event.phase == "began" ) then
		print( self.id .. ": collision began with" .. event.other.id )
	elseif (event.phase == "ended" ) then
	    print( self.id .. ":collision ended with " .. event.other.id )
	end
end

function checkplayerBulletsOutOfBounds()
	-- body
	    local bulletCounter
    
    if #playerBullets > 0 then
        for bulletCounter = #playerBullets, 1 , -1 do
        	if playerBullets[bulletCounter].x > display.contentWidth + 1000 then
        		playerBullets[bulletCounter]:removeself()
        		playerBullets[bulletCounter] = nil
        		table.remove(playerBullets, bulletCounter)
        		print("remove bullet")
        	end
        end
    end
end

local function onCollision( event )

	if ( event.phase == "began" ) then
		local obj1 = event.object1
		local obj2 = event.object2
		
		if ( ( obj1.id == "bad character" and obj2.id == "bullet" ) or
		     ( obj1.id == "bullet" and obj2.id == "bad character") ) then
		    display.remove( obj1 )
		    display.remove( obj2 )

		    for bulletCounter = #playerBullets, 1, -1 do
		    	if ( playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] == obj2 ) then
		    		table.remove( playerBullets, bulletCounter )
		    		break
		        end
		    end

		    badCharacter = nil

		    print ( "you could inrease a score here." )

		    local expolsionSound = audio.loadStream( "./assets/sprites/8bit_bomb_explosion.wav" )
		    local explosionChannel = audio.play ( expolsionSound )
		end
    end
end

function upArrow:touch( event )
	if ( event.phase == "ended" ) then
	    -- move the character up
	    transition.moveBy( theCharacter, {
	    	    x = 0, -- move 0 in the x direction
	    	    y = -50, -- move up 50 pixels
	    	    time = 100 --move in a 1/10 of a second
	    	    } )
	end
	

	return true
end

upArrow:addEventListener( "touch", upArrow )

function downArrow:touch( event )
	if ( event.phase == "ended" ) then
	    -- move the character up
	    transition.moveBy( theCharacter, {
	    	    x = 0, -- move 0 in the x direction
	    	    y = 50, -- move down 50 pixels
	    	    time = 100 --move in a 1/10 of a second
	    	    } )	
	end

	return true
end

downArrow:addEventListener( "touch", downArrow )

function leftArrow:touch( event )
	if ( event.phase == "ended" ) then
	    -- move the character up
	    transition.moveBy( theCharacter, {
	    	    x = -50, -- move 0 in the x direction
	    	    y = 0, -- move down 50 pixels
	    	    time = 100 --move in a 1/10 of a second
	    	    } )	
	end

	return true
end

leftArrow:addEventListener( "touch", leftArrow )

function rightArrow:touch( event )
	if ( event.phase == "ended" ) then
	    -- move the character up
	    transition.moveBy( theCharacter, {
	    	    x = 50, -- move 0 in the x direction
	    	    y = 0, -- move down 50 pixels
	    	    time = 100 --move in a 1/10 of a second
	    	    } )	
	end

	return true
end

rightArrow:addEventListener( "touch", rightArrow )

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        theCharacter:setLinearVelocity( 0, -750 )
    end

    return true
end

function shootButton:touch( event )
	if ( event.phase == "began" ) then

		local  aSingleBullet = display.newImage( "./assets/sprites/fireball.png")
		aSingleBullet.x = theCharacter.x
		aSingleBullet.y = theCharacter.y
		physics.addBody( aSingleBullet, 'dynamic')
		aSingleBullet.isBullet = true
		aSingleBullet.gravityScale = 0
		aSingleBullet.id = "bullet"
		aSingleBullet:setLinearVelocity( 1500, 0 )

		table.insert(playerBullets,aSingleBullet)
		print("# of bullet:" .. tostring(#playerBullets))
	end 

	return true
end

function checkCharacterPosition( event )

	if theCharacter.y > display.contentHeight + 500 then
		theCharacter.x = display.contentCenterX - 200
		theCharacter.y = display.contentCenterY
	end
end

jumpButton:addEventListener( "touch", jumpButton )
Runtime:addEventListener( "enterFrame", checkCharacterPosition )

shootButton:addEventListener( "touch", shootButton )
Runtime:addEventListener( "enterFrame", checkplayerBulletsOutOfBounds )

theCharacter.collision = checkCharacterCollision
theCharacter:addEventListener( "collision" )
Runtime:addEventListener( "collision", onCollision )