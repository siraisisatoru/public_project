NumBox = Class{}

function NumBox:init(delx,dely,num) -- delx and dely begin from 1
    self.delx = delx
    self.dely = dely
    self.num = num or 0

    self.moving = false
    self.step = 0
    self.delPerdt = 0
    self.speed = 10
    self.dir = {0,0} -- -1 , 0 , 1
    self.popUp = -1 -- -1 befault 0 fixed 1 zooming
    self.sumPopUp = false
    self.NBscale = -1.4
    self.zoomingSpeed = 4--4
    self.completeRender = false
    self.completeMoving = true
end

function NumBox:update(dt)
    if self.moving then
        self.delPerdt = self.delPerdt + self.speed * dt
        if self.delPerdt >= self.step then

            self.delPerdt = roundNum(self.delPerdt)

            self.delx = self.delx + self.dir[1]*self.delPerdt
            self.dely = self.dely + self.dir[2]*self.delPerdt
            -- update the xy coordinate when the moving stop

            self.delPerdt = 0
            self.step = 0
            self.dir[1] , self.dir[2] = 0,0

            self.moving = false
            self.completeMoving = true
        end
    end 

    if (self.popUp == 1) and (not self.sumPopUp) then
        self.NBscale = self.NBscale + self.zoomingSpeed*dt
        if self.NBscale >= -0.4 then -- -1.4 -> -0.4
            self.NBscale = -0.4
            self.popUp = 0
            self.completeRender = true
        end
    elseif (self.popUp == 1) and (self.sumPopUp) then  -- summing pop up
        self.NBscale = self.NBscale + (self.zoomingSpeed )*dt -- * 0.025
        if self.NBscale >= 0.4 then -- -1.4 -> 0 -> 0.4
            self.NBscale = 0.4
            self.popUp = 0
            self.completeRender = true
        end
    end
    
end

function NumBox:render(Pop)
    -- 1 -> no effect pop up
    -- 0 -> initial 2 / 4 pop up
    -- -1 -> sumed pop up
    -- render the box associate with the number
    -- draw the box background first then the number
    
    Pop = Pop or 0
    if self.num > 0 and Pop <= 0 then
        if Pop == 0 then
            self.sumPopUp = false
        elseif Pop == -1 then
            self.sumPopUp = true
        end
        if self.popUp == -1 then
            self.popUp = 1 -- zoom in
        end

    elseif self.num > 0 then
        self.NBscale = 0.4
    end


    boxX = (tableLeftTopXY[1] + 10 ) + (self.delx - 1 + self.dir[1]*self.delPerdt ) * (10 + boxSize) 
    boxY = (tableLeftTopXY[2] + 10 ) + (self.dely - 1 + self.dir[2]*self.delPerdt ) * (10 + boxSize)
    
    numX = boxX
    numY = boxY + 20

    --  1. the box
    local index = 0
    if self.num ~= 0 then
        index = math.log(self.num)/math.log(2)
    else
        index = nil
    end
    
    color = numberColor[index]
    color = color or BoxColor
    love.graphics.setColor(color)
    if self.num > 0 then
        BS = (love.graphics.getWidth() - 7*10) /4 * (self.NBscale > 0 and (1.4-self.NBscale) or (1.4+self.NBscale))
        love.graphics.rectangle('fill' , boxX - BS/2 + BS/(2*(self.NBscale > 0 and (1.4-self.NBscale) or (1.4+self.NBscale))) , boxY - BS/2 + BS/(2*(self.NBscale > 0 and (1.4-self.NBscale) or (1.4+self.NBscale))) , BS  , BS , 5 ,5 )
    else
        BS = boxSize
        love.graphics.rectangle('fill' , boxX , boxY , BS  , BS , 5 ,5 )
    end
    
    --  2. the number
    -- love.graphics.setFont(middleFont)
    love.graphics.setFont(numberFont)
    if self.num == 2 or self.num == 4 then -- num = 2 , 4
        love.graphics.setColor(1,1,1,1)
    else
        if self.num ~= 0 then -- num > 0
            love.graphics.setColor(NumberColor)
        else -- num == 0
            -- remember to change back to 0,0,0,0
            love.graphics.setColor(0,0,0,0) -- set it invisitable
        end
    end
    if self.num ~= -1 then
        -- -- love.graphics.print(tostring(self.dir[2]) ,0, 50)
        -- -- if self.dir[2] == -1 then
        -- love.graphics.print(tostring(self.delx)..' '..tostring(self.dely) ..' ' .. tostring(self.delPerdt), 0 ,60)
        -- -- end
        love.graphics.printf(tostring(self.num) , numX , numY , boxSize , 'center' )
    end
end

function NumBox:getNum()
    return self.num
end

function NumBox:setNum(num)
    self.num = num
end

function NumBox:getXY() -- return a 2 elements table
    return {self.delx , self.dely}
end

function NumBox:getComMoving()
    return self.completeMoving
end

function NumBox:getComRender()
    return self.completeRender
end
function NumBox:setNumXY(x, y, num)
    self.num = num
    self.delx = x
    self.dely = y
end


-- function NumBox:setXY(coordinate)
--     self.delx = coordinate[1]
--     self.dely = coordinate[2]
-- end

function NumBox:shifting(vStep , hStep)
    self.dir[1] , self.dir[2] = 0,0
    if self.num > 1 then
        if vStep ~= 0 then
            self.step = math.abs(vStep)
            if vStep > 0 then
                self.dir[2] = 1
                
            else
                self.dir[2] = -1
            end
            self.moving = true
            self.completeMoving = false
        elseif hStep ~= 0 then
            self.step = math.abs(hStep)
            if hStep > 0 then
                self.dir[1] = 1
            else
                self.dir[1] = -1
            end
            self.moving = true
            self.completeMoving = false
        end
    end
end

-- round function for rounding the time 
function roundNum(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end