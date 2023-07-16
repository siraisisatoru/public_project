
function drawTable()
    love.graphics.setColor(TableColor)
    love.graphics.rectangle('fill', tableLeftTopXY[1], tableLeftTopXY[2], love.graphics.getWidth() - 10*2 , love.graphics.getWidth() - 10*2 , 5,5 )
end

function drawGrayBox()
    for index = 1 , 16 do
        graytable[ index ]:render()    
    end
end

function drawConner()
    love.graphics.setColor(DotColor)
    love.graphics.ellipse("fill", controllerConner[1] , controllerConner[2], 5, 5)
    love.graphics.ellipse("fill", controllerConner[3] , controllerConner[4], 5, 5)
    love.graphics.ellipse("fill", controllerConner[5] , controllerConner[6], 5, 5)
    love.graphics.ellipse("fill", controllerConner[7] , controllerConner[8], 5, 5)
end

function drawLine()
    love.graphics.setLineWidth(3)

    if ( upBar == true) then
        love.graphics.setColor(0,0,0,1)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.line(controllerT)

    
    if ( rightBar == true) then
        love.graphics.setColor(0,0,0,1)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.line(controllerR)


    if ( leftBar == true) then
        love.graphics.setColor(0,0,0,1)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.line(controllerL)


    if ( downBar == true) then
        love.graphics.setColor(0,0,0,1)
    else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.line(controllerB)
end

-- ---------------
-- function tempDraw()
--     love.graphics.print(tostring(tempTable[1]) ..' ' .. tostring(tempTable[2]) ..' ' ..  tostring(tempTable[3]) ..' ' ..  tostring(tempTable[4]) , 0 , 100)

-- end
-- ---------------

function drawSurface()
    for i , box in pairs(surfaceTable) do
        if box:getNum() > 0 then
            box:render(0)
        end
    end
end

function drawTempSumedBox()
    if #tempWaitingList > 0 then
        for i , box in pairs(tempRender) do
            if  surfaceTable[tostring(tempWaitingList[i][1])..','..tostring(tempWaitingList[i][2])]:getComMoving() and 
                surfaceTable[tostring(tempWaitingList[i][3])..','..tostring(tempWaitingList[i][4])]:getComMoving() 
            then
                box:render(-1)
            end
        end
    end

    love.graphics.print(tostring(#tempRender) .. '\t' .. tostring(#tempWaitingList) , 20 ,30)
    if #tempWaitingList > 0 then

        -- love.graphics.print(tostring(tempWaitingList[1][1])..' | '..tostring(tempWaitingList[1][2])..' | '..tostring(tempWaitingList[1][3])..' | '..tostring(tempWaitingList[1][4]) , 20 , 10)
        -- love.graphics.print(tostring(surfaceTable[mappingTable[tostring(tempWaitingList[1][1])..','..tostring(tempWaitingList[1][2])]]:getComMoving())..' | '..tostring(surfaceTable[mappingTable[tostring(tempWaitingList[1][3])..','..tostring(tempWaitingList[1][4])]]:getComMoving()) , 20 , 10)
        -- -- -- love.graphics.print(tostring(tempWaitingList[2][1])..' | '..tostring(tempWaitingList[2][2])..' | '..tostring(tempWaitingList[2][3])..' | '..tostring(tempWaitingList[2][4]) , 100 , 10)

        -- love.graphics.print(tostring(tempWaitingList[3][1])..','..tostring(tempWaitingList[3][2])..','..tostring(tempWaitingList[3][3])..','..tostring(tempWaitingList[3][4]) , 20 ,50)
    end
end

function drawTempSurfaceTable()
    
    love.graphics.print(tostring(tableComMoving) .. ' ' .. tostring(longDisplay) , 50 , 20 )
    for x = 1 , 4 do 
        for y = 1 , 4 do 
            love.graphics.print(tostring(tempSurfaceTable[tostring(x) .. ',' .. tostring(y)]) , x * 50 , y * 50)
        end

    end
end

function gameOverPage()
    love.graphics.setColor(1,1,1,lightness)
    love.graphics.rectangle('fill', 0,0,love.graphics.getWidth() , love.graphics.getHeight())

    love.graphics.setColor(0,0,0,lightness)
    love.graphics.setFont(gameOverFont)
    love.graphics.printf('!\nGAME OVER\n!' , 0 , love.graphics.getHeight()/2-300, love.graphics.getWidth(), 'center')
    love.graphics.setFont(numberFont)
    love.graphics.printf('press enter to continue' , 0 , love.graphics.getHeight()/2 + 170 , love.graphics.getWidth(),'center')
end

function wellcomepage()

end


