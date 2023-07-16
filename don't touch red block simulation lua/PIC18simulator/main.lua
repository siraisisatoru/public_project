
require('src.Dependencies')

function love.load()
    -- genRamCol()
    genAndUpdate()
    updateLvPattern()
end

function love.update(dt)
    
    timecounter = timecounter + dt
    if timecounter >= delaytime then
        timecounter = 0

        if state == 2 and barCounter <= 0 then
            if (patternToNum (buttonDownPattern)) ~= (patternToNum (futurePattern)) then
                state = 0
            elseif levelCounter == 0 then
                state = 1
            end
        end

        if state == 0 then
            -- print lost
            -- stay for ever
            -- state = 2
            updatePattern()
        elseif state == 1 then
            -- print win
            -- stay for ever
            -- state = 2
            updatePattern()
        elseif state == 2 then
            -- print pattern

            if barCounter <= 0 then
                genAndUpdate()
                barCounter = 9
            end
            barShift()
            
            -- updatePattern()
        else
            state = 0
            updatePattern()
        end

    end

    -- reset button pattern to all zero
    -- set green bar to all zero
    if ((barCounter > 1) and ((patternToNum (buttonDownPattern)+1) ~= 0) and state == 2) then
        buttonDownPattern[1],buttonDownPattern[2],buttonDownPattern[3],buttonDownPattern[4] = 0,0,0,0
        for i = 1 , 16 do
            LEDpattern[16][i] = 0
        end
    end

end

function love.draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle('fill', topLeftConner[1] , topLeftConner[2] ,400,400)

    if mapRender then
        -- purple
        love.graphics.setColor(138/255,43/255,226/255,1)
        love.graphics.rectangle('fill', topLeftConner[1] , topLeftConner[2] , 25*4 , 25*9)
        
        -- dark blue
        love.graphics.setColor(0,0,205/255,1)
        love.graphics.rectangle('fill', 25*5 , topLeftConner[2] , 25*4 , 25*9)

        -- yellow
        love.graphics.setColor(1,215/255,0,1)
        love.graphics.rectangle('fill', 25*9 , topLeftConner[2] , 25*4 , 25*9)

        -- red
        love.graphics.setColor(255/255,127/255,80/255,1)
        love.graphics.rectangle('fill', 25*13 , topLeftConner[2] , 25*4 , 25*9)

        -- light blue
        -- up   counter = 1
        -- down counter = 0
        love.graphics.setColor(0,1,1,0.5)
        love.graphics.rectangle('fill',topLeftConner[1],25*8,400,50)

        -- two black line
        love.graphics.setColor(0,0,0,0.8)
        -- upper
        love.graphics.rectangle('fill',topLeftConner[1],25*10,400,25)
        -- lowwer
        love.graphics.rectangle('fill',topLeftConner[1],25*15,400,25)

        -- green
        love.graphics.setColor(50/255,205/255,50/255,1)
        love.graphics.rectangle('fill',topLeftConner[1],25*16,400,25)

    end

    for i = 1 , 16 do
        for j = 1 , 16 do
            if LEDpattern[j][i] == 1 then
                love.graphics.setColor(1,0.1,0.1,1)
            else
                love.graphics.setColor(0.5,0.5,0.5,1)
            end
            love.graphics.circle('fill' , topLeftConner[1] + i*25 - 25/2 , topLeftConner[2] + j*25 - 25/2 , 10)
        end
    end
    
    for i = 1 , 4 do
        if buttonDownPattern[i] == 1 then
            love.graphics.setColor(211/255,211/255,211/255,1)
        else
            love.graphics.setColor(105/255,105/255,105/255,1)
        end
        love.graphics.rectangle('fill', 25*i +(i-1)*81.25  , 450 , 81.25 , 40 )
    end
    
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('H',25             , 465,81.25,'center')
    love.graphics.printf('J',25*2+81.25     , 465,81.25,'center')
    love.graphics.printf('K',25*3+81.25*2   , 465,81.25,'center')
    love.graphics.printf('L',25*4+81.25*3   , 465,81.25,'center')


    love.graphics.print(tostring(timecounter) , 0 , 500)
    love.graphics.print('buttonDownPattern: '..tostring(buttonDownPattern[1])..' '..tostring(buttonDownPattern[2])..' '..tostring(buttonDownPattern[3])..' '..tostring(buttonDownPattern[4]) 
                        ..'  futurePattern'..tostring(futurePattern[1])..' '..tostring(futurePattern[2])..' '..tostring(futurePattern[3])..' '..tostring(futurePattern[4]), 0 , 510)
    love.graphics.print('barcounter: '..tostring(barCounter) ..' levelCounter: '..tostring(levelCounter), 0 , 520)
    love.graphics.print(numberToBinStr(WREG) , 0 ,530)
    love.graphics.print(tostring(patternToNum(futurePattern)),0,540)
    -- love.graphics.print(tostring(),0,550)
end

function love.keypressed(k)
    -- exit keys
    if k == 'escape' then
        love.event.quit()
    end
    if love.keyboard.isDown('lgui') and love.keyboard.isDown('w') then
        love.event.quit()
    end


    if ((barCounter == 1 or barCounter == 0) and (patternToNum (buttonDownPattern) == 0)) then
        if k == 'h' then
            buttonDownPattern[1],buttonDownPattern[2],buttonDownPattern[3],buttonDownPattern[4] = 1,0,0,0
        elseif k == 'j' then
            buttonDownPattern[1],buttonDownPattern[2],buttonDownPattern[3],buttonDownPattern[4] = 0,1,0,0
        elseif k == 'k' then
            buttonDownPattern[1],buttonDownPattern[2],buttonDownPattern[3],buttonDownPattern[4] = 0,0,1,0
        elseif k == 'l' then
            buttonDownPattern[1],buttonDownPattern[2],buttonDownPattern[3],buttonDownPattern[4] = 0,0,0,1
        end
        updateGreenBar()
        updateGameStatus()
    end

end

-- update the fixed pattern array according to the state
function updatePattern()
    if state == 0 then
        for i = 1 , 16 do
            for j = 1 , 16 do
                LEDpattern[i][j] = youLost[i][j]
            end
        end

    elseif state == 1 then

        for i = 1 , 16 do
            for j = 1 , 16 do
                LEDpattern[i][j] = youWin[i][j]
            end
        end

    elseif state == 2 then

    else

    end

end

function updateGreenBar()
    for i = 1 , 4 do
        if buttonDownPattern[i] == 1 then
            for j = (i-1)*4+1 , i*4 do
                LEDpattern[16][j] = 1
            end
            break
        end
    end
end

function updateGameStatus()


    -- update level counter
    for i = 1 , 4 do
        if buttonDownPattern[i] ~= futurePattern[i] then
            break
        end
        if i == 4 and buttonDownPattern[i] == futurePattern[i] then
            levelCounter = levelCounter - 1
        end
    end

    updateLvPattern()

end

function updateLvPattern()

    -- update LED pattern level part
    WREG = 1
    for i = 1 , 64 do -- 64
        if i > levelCounter then
            WREG = 0
        end
        LEDpattern [math.floor((i-1)/16)+11][(i-1)%16 + 1] = WREG
        -- LEDpattern[11][i] = 1
    end
end


-- shift bars from the top to bottom (row 9)
-- only shift according to the current LED pattern 
-- and future pattern array
function barShift()
    
    barCounter = barCounter - 1

    for i = 9 , 2 , -1 do
        for j = 1 , 16 do
            LEDpattern[i][j] = LEDpattern[i-1][j]
        end
    end

    for i = 1 , 16 do
        LEDpattern[1][i] = 0
    end

    for i = 1 , 4 do
        if futurePattern[i] == 1 then
            for j = (i-1)*4+1 , i*4 do
                LEDpattern[1][j] = 1
            end
            break
        end
    end
    


end

-- generate a new round pattern at the top     
-- pass future pattern to current pattern
-- set a new pattern to future pattern
function genAndUpdate()
    -- generate random
    repeat
        genRamCol() 
    until (bit.rshift(ramResult,6) ~= patternToNum(futurePattern))

    -- update the patterns
    -- shift future pattern to current pattern
    for i = 1 , 4 do
        currentPattern[i] = futurePattern[i]
    end

    -- convert 8bit random number into future pattern with table form
    WREG = ramResult
    WREG = bit.rshift(WREG , 6)

    if WREG == 0 then
        -- 1000
        futurePattern[1],futurePattern[2],futurePattern[3],futurePattern[4] = 1,0,0,0
    elseif WREG == 1 then
        -- 0100
        futurePattern[1],futurePattern[2],futurePattern[3],futurePattern[4] = 0,1,0,0
    elseif WREG == 2 then
        -- 0010
        futurePattern[1],futurePattern[2],futurePattern[3],futurePattern[4] = 0,0,1,0
    else
        -- 0001
        futurePattern[1],futurePattern[2],futurePattern[3],futurePattern[4] = 0,0,0,1
    end

end

function genRamCol()
    WREG = ramResult
    WREG = bit.rshift(WREG, 3)
    ramResult = bit.bxor(WREG , ramResult)
    ramResult = bit.band(ramResult , 0xff)

    WREG = ramResult
    WREG = bit.lshift(WREG, 5)
    ramResult = bit.bxor(WREG , ramResult)
    ramResult = bit.band(ramResult , 0xff)

    WREG = ramResult
    WREG = bit.rshift(WREG, 9)
    ramResult = bit.bxor(WREG , ramResult)
    ramResult = bit.band(ramResult , 0xff)
end

-- functions that does not need in PIC18 
-- ------------------------------------------

-- convert numbers into string and return the string
-- no need in PIC18
function numberToBinStr(x)
	ret=""
	while x~=1 and x~=0 do
		ret=tostring(x%2)..ret
		x=math.modf(x/2)
	end
	ret=tostring(x)..ret
	return ret
end

-- convert pattern table into number
-- no need in PIC18
function patternToNum(pattern)
    local num = 0 
    -- i = 1 , 2 , 3 , 4
    -- return 0 , 1 , 2, , 3
    for i , n in pairs(pattern) do
        if n == 1 then
            num = i - 1
            break
        end
    end
    return num
end

