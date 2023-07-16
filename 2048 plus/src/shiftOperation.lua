function numShift (dir)
    --[[
        moving up -> vStep < 0
        moving down -> vStep > 0
        moving left -> hStep < 0
        moving right -> hStep > 0
    ]]
    if dir == 'up' then
        for i = 1 , 4 do
            colShift('up' , i)
            resetTempTables()
        end
    elseif dir == 'down' then
        for i = 1 , 4 do
            colShift('down' , i)
            resetTempTables()
        end
    elseif dir == 'left' then
        for i = 1 , 4 do
            rowShift('left' , i)
            resetTempTables()
        end
    elseif dir == 'right' then
        for i = 1 , 4 do
            rowShift('right' , i)
            resetTempTables()
        end
    end

end


function colShift(dir,colNum) -- 1 to 4
    --[[
        1   |2   |3   |4
        5   |6   |7   |8
        9   |10  |11  |12
        13  |14  |15  |16
        (1) (2)  (3)  (4)
    ]]

    -- put the numbers into the temporary array
    -- top to bottom (1 - > 4) , left to right (1 - > 4)

    tempHashTable = {{}, {}, {}, {}}

    if dir == 'up' then
        for i = 1 , 4 do
            tempArr[i] = surfaceTable[col[colNum][i]]:getNum()
        end
        setMovingIndex()

        for i = 1 , 4 do
            -- tempSurfaceTable[col[colNum][i]] = 1024
            tempSurfaceTable[col[colNum][i]] = tempresult[i] * numOfnum[i]

        end


-- ---------------------------------------
        for i = 1 , 4 do
            if tempArr[i] == 0 then
                tempmovingindexs[i] = 200
            end
        end
-- ---------------------------------------
        for i = 1 , 4 do -- setTarget
            tempTarget[i] = i - tempmovingindexs[i]
        end
        for i = 1 , 4 do
            tempmovingindexs[i] = tempmovingindexs[i] * -1
        end




        for i = 1 , 4 do
            if tempTarget[i] > 0 and tempTarget[i] < 5 then
                table.insert(tempHashTable[  tempTarget[i]  ] , i)
            end
        end
    
        for i = 1 , 4 do
            if #tempHashTable[i] == 2 then
                table.insert( tempWaitingList, {colNum , tempHashTable[i][1] , colNum ,tempHashTable[i][2]})
                -- table.insert( tempWaitingList, {colNum , tempHashTable[1][1] , colNum ,tempHashTable[1][2]})
                -- table.insert( tempWaitingList, {tempTarget[1],tempTarget[2],tempTarget[3],tempTarget[4]})
        
            end
        end
    
        for i = 1 , 4 do
            if numOfnum[i] == 2 then
                table.insert( tempRender, NumBox(colNum , i , tempresult[i]*2 ))
            end
        end


    elseif dir == 'down' then
        for i = 1,4 do
            tempArr[i] = surfaceTable[col[colNum][5-i]]:getNum()
        end
        setMovingIndex()

-- ---------------------------------------
        for i = 1 , 4 do
            if tempArr[i] == 0 then
                tempmovingindexs[i] = 200
            end
        end
-- ---------------------------------------
        tempmovingindexs[1] , tempmovingindexs[2] , tempmovingindexs[3] , tempmovingindexs[4] = tempmovingindexs[4] , tempmovingindexs[3] , tempmovingindexs[2] , tempmovingindexs[1] 
        numOfnum[1] , numOfnum[2] , numOfnum[3] , numOfnum[4] = numOfnum[4] , numOfnum[3] , numOfnum[2] , numOfnum[1]
        tempresult[1] , tempresult[2] , tempresult[3] , tempresult[4] = tempresult[4] , tempresult[3] , tempresult[2] , tempresult[1]
        for i = 1 , 4 do -- setTarget
            tempTarget[i] = i + tempmovingindexs[i] 
        end

        
        for i = 1 , 4 do
            -- tempSurfaceTable[col[colNum][i]] = 1024
            tempSurfaceTable[col[colNum][i]] = tempresult[i] * numOfnum[i]

        end




        for i = 1 , 4 do
            if tempTarget[i] > 0 and tempTarget[i] < 5 then
                table.insert(tempHashTable[  tempTarget[i]  ] , i)
            end
        end
    
        for i = 1 , 4 do
            if #tempHashTable[i] == 2 then
                table.insert( tempWaitingList, {colNum , tempHashTable[i][1] , colNum ,tempHashTable[i][2]})
                -- table.insert( tempWaitingList, {colNum , tempHashTable[1][1] , colNum ,tempHashTable[1][2]})
                -- table.insert( tempWaitingList, {tempTarget[1],tempTarget[2],tempTarget[3],tempTarget[4]})
        
            end
        end
    
        for i = 1 , 4 do
            if numOfnum[i] == 2 then
                table.insert( tempRender, NumBox(colNum , i , tempresult[i]*2 ))
                -- table.insert( tempRender, NumBox(colNum , i , 1024 ))

            end
        end




    end




    surfaceTable[col[colNum][1]]:shifting(tempmovingindexs[1],0)
    surfaceTable[col[colNum][2]]:shifting(tempmovingindexs[2],0)
    surfaceTable[col[colNum][3]]:shifting(tempmovingindexs[3],0)
    surfaceTable[col[colNum][4]]:shifting(tempmovingindexs[4],0)


    -- reset hash table table

    for i , v in pairs(tempHashTable) do
        table.remove( tempHashTable )
    end

    -- for i = 1 , 4 do
    --     table.insert( tempHashTable, {} )

    -- end



    for i , v in pairs(tempHashTable) do
        table.remove( tempHashTable )
    end




    
    -- table.insert( tempWaitingList, {tempTarget[1],tempTarget[2],tempTarget[3],tempTarget[4]})
    -- table.insert( tempWaitingList, {tempmovingindexs[1],tempmovingindexs[2],tempmovingindexs[3],tempmovingindexs[4]})
    -- -- -- -- table.insert( tempWaitingList, {numOfnum[i],numOfnum[i],numOfnum[i],numOfnum[i]})



    
    --[[
        wait until the boxes moved to the target x,y position
        render the one with numOfnum = 2 with num * 2
        reset all elements acording to the tempresult table 
    ]]

    --[[
        [A,B,C,D]
         1,2,0,0
         either 1 (2)
         or     2 (2)

        
        table.insert( surfaceTable, 14 , NumBox(x,y, V*2) ) 
    -- 14 = the tile of the col / row
    -- run this except the last element tempmovingindexs = 0
        table.remove( surfaceTable, 14 )
    ]]
end

function rowShift(dir,rowNum) -- 1 to 4
    --[[
        1   2   3   4       (1)
        --------------
        5   6   7   8       (2)
        --------------
        9   10  11  12      (3)
        --------------
        13  14  15  16      (4)
    ]]
    tempHashTable = {{}, {}, {}, {}}


    if dir == 'left' then
        for i = 1 , 4 do
            tempArr[i] = surfaceTable[row[rowNum][i]]:getNum()
        end
        setMovingIndex()


        -- tempSurfaceTable[row[rowNum][1]] = 1024
        tempSurfaceTable[row[rowNum][1]] = tempresult[1] * numOfnum[1]
        tempSurfaceTable[row[rowNum][2]] = tempresult[2] * numOfnum[2]
        tempSurfaceTable[row[rowNum][3]] = tempresult[3] * numOfnum[3]
        tempSurfaceTable[row[rowNum][4]] = tempresult[4] * numOfnum[4]


-- ---------------------------------------
        for i = 1 , 4 do
            if tempArr[i] == 0 then
                tempmovingindexs[i] = 200
            end
        end
-- ---------------------------------------
        for i = 1 , 4 do -- setTarget
            tempTarget[i] = i - tempmovingindexs[i]
        end
        for i = 1 , 4 do
            tempmovingindexs[i] = tempmovingindexs[i] * -1
        end



        for i = 1 , 4 do
            if tempTarget[i] > 0 and tempTarget[i] < 5 then
                table.insert(tempHashTable[  tempTarget[i]  ] , i)
                -- table.insert(tempHashTable[  tempTarget[i]  ] , 1024)

            end
        end
    
        for i = 1 , 4 do
            if #tempHashTable[i] == 2 then
                table.insert( tempWaitingList, { tempHashTable[i][1] , rowNum ,tempHashTable[i][2] , rowNum })
             -- table.insert( tempWaitingList, {tempHashTable[4][1] , rowNum ,tempHashTable[4][2] , rowNum })
                -- table.insert( tempWaitingList, {tempTarget[1],tempTarget[2],tempTarget[3],tempTarget[4]})
        
            end
        end
    
        for i = 1 , 4 do
            if numOfnum[i] == 2 then
                table.insert( tempRender, NumBox(i , rowNum , tempresult[i]*2 ))
            end
        end




    elseif dir == 'right' then
        for i = 1,4 do
            tempArr[i] = surfaceTable[row[rowNum][5-i]]:getNum()
        end
        setMovingIndex()

   

-- ---------------------------------------
        for i = 1 , 4 do
            if tempArr[i] == 0 then
                tempmovingindexs[i] = 200
            end
        end
-- ---------------------------------------
        tempmovingindexs[1] , tempmovingindexs[2] , tempmovingindexs[3] , tempmovingindexs[4] = tempmovingindexs[4] , tempmovingindexs[3] , tempmovingindexs[2] , tempmovingindexs[1] 
        numOfnum[1] , numOfnum[2] , numOfnum[3] , numOfnum[4] = numOfnum[4] , numOfnum[3] , numOfnum[2] , numOfnum[1]
        tempresult[1] , tempresult[2] , tempresult[3] , tempresult[4] = tempresult[4] , tempresult[3] , tempresult[2] , tempresult[1]        
        for i = 1 , 4 do -- setTarget
            tempTarget[i] = i + tempmovingindexs[i] 
        end
   
    
    
        for i = 1 , 4 do
            -- tempSurfaceTable[col[colNum][i]] = 1024
            tempSurfaceTable[row[rowNum][i]] = tempresult[i] * numOfnum[i]
        end



        for i = 1 , 4 do
            if tempTarget[i] > 0 and tempTarget[i] < 5 then
                table.insert(tempHashTable[  tempTarget[i]  ] , i)
            end
        end
    
        for i = 1 , 4 do
            if #tempHashTable[i] == 2 then
                table.insert( tempWaitingList, { tempHashTable[i][1] , rowNum ,tempHashTable[i][2] , rowNum})
                -- table.insert( tempWaitingList, {tempHashTable[4][1] , rowNum ,tempHashTable[4][2] , rowNum })
                -- table.insert( tempWaitingList, {tempTarget[1],tempTarget[2],tempTarget[3],tempTarget[4]})
        
            end
        end
    
        for i = 1 , 4 do
            if numOfnum[i] == 2 then
                table.insert( tempRender, NumBox(i , rowNum , tempresult[i]*2 ))
            end
        end


   
   
   
    end


    surfaceTable[row[rowNum][1]]:shifting(0,tempmovingindexs[1])
    surfaceTable[row[rowNum][2]]:shifting(0,tempmovingindexs[2])
    surfaceTable[row[rowNum][3]]:shifting(0,tempmovingindexs[3])
    surfaceTable[row[rowNum][4]]:shifting(0,tempmovingindexs[4])


    -- reset hash table table

    for i , v in pairs(tempHashTable) do
        table.remove( tempHashTable )
    end
end

function setMovingIndex ( recursiveIndex )
    recursiveIndex = recursiveIndex or -1
    -- maybe improved by recursive function

    if recursiveIndex == -1 then
        for i = 1 , 4 do
            tempresult[i] = 0
            numOfnum[i] = 0
            tempmovingindexs[i] = 0
        end
        recursiveIndex = 1
    end


    -- 1.
    if tempArr[1] ~= 0 then
        tempresult[1] = tempArr[1]
        numOfnum[1] = numOfnum[1] + 1
        tempmovingindexs [1] = tempmovingindexs[1] + 0 * 1
    end
    
    -- 2.
    --[[
        [A][B][C][D]
            ^
        if B ~= 0     
            if A = 0
                A = B
            else
                if A = B and A counter < 2
                    counter ++
                else
                    B = B
                end
            end
        end
    ]]
    if tempArr[2] ~= 0 then
        if tempresult[1] == 0 then
            tempresult[1] = tempArr[2]
            numOfnum[1] = numOfnum[1] + 1
            tempmovingindexs [2] = tempmovingindexs[2] + 1 * 1
        else
            if tempArr[2] == tempresult[1] and numOfnum[1] < 2 then
                numOfnum[1] = numOfnum[1] + 1
                tempmovingindexs[2] = tempmovingindexs[2] + 1 * 1
            else
                tempresult[2] = tempArr[2] 
                numOfnum[2] = numOfnum[2] + 1
                tempmovingindexs [2] = tempmovingindexs[2] + 0 * 1
            end
        end
    end

    -- 3.
    --[[
        [A][B][C][D]
               ^
        if C ~= 0 
            if B = 0
                if A = 0
                    move to A
                else
                    move to B
                end
            else
                if B = C 
                    counter ++
                else
                    C = C
                end
            end
        end
    ]]
    if tempArr[3] ~= 0 then
        if tempresult[2] == 0 then
            if tempresult[1] == 0 then
                tempresult[1] = tempArr[3]
                numOfnum[1] = numOfnum[1] + 1
                tempmovingindexs [3] = tempmovingindexs[3] + 2 * 1
            else
                if tempresult[1] == tempArr[3] and numOfnum[1] < 2 then
                    numOfnum[1] = numOfnum[1] + 1
                    tempmovingindexs[3] = tempmovingindexs[3] + 2
                else
                    tempresult[2] = tempArr[3]
                    numOfnum[2] = numOfnum[2] + 1
                    tempmovingindexs[3] = tempmovingindexs[3] + 1
                end
            end
        else
            if tempresult[2] == tempArr[3] and numOfnum[2] < 2 then
                numOfnum[2] = numOfnum[2] + 1
                tempmovingindexs[3] = tempmovingindexs[3] + 1
            else
                tempresult[3] = tempArr[3] 
                numOfnum[3] = numOfnum[3] + 1
                tempmovingindexs [3] = tempmovingindexs[3] + 0 * 1
            end
        end
    end

    -- 4.
    --[[
        [A][B][C][D]
                  ^
        if C = 0
            if B = 0
                if A =0
                    A = D
                    counter ++
                else
                    if A = D and numOfnum[1] < 2
                        num++
                    else
                        b = D
                        counter ++
                    end
                end
            else
                if B = D and numOfnum[2] < 2
                    counter ++
                else
                    c = D
                    counter ++
                end 
            end
        else
            if C = D and numOfnum[3] < 2
                counter ++
            else
                D = D
                counter ++
            end 
        end

    ]]
    if tempArr[4] ~=0 then
        if tempresult[3] == 0 then
            if tempresult[2] == 0 then
                if tempresult[1] == 0 then
                    tempresult[1] = tempArr[4]
                    numOfnum[1] = numOfnum[1] + 1
                    tempmovingindexs[4] = tempmovingindexs[4] + 1 * 3
                else
                    if tempresult[1] == tempArr[4] and numOfnum[1] < 2 then
                        numOfnum[1] = numOfnum[1] + 1
                        tempmovingindexs[4] = tempmovingindexs[4] + 3 * 1
                    else
                        tempresult[2] = tempArr[4] 
                        numOfnum[2] = numOfnum[2] + 1
                        tempmovingindexs[4] = tempmovingindexs[4] + 2 *1
                    end
                end
            else -- b ~= 0
                if tempresult[2] == tempArr[4] and numOfnum[2] < 2 then
                    numOfnum[2] = numOfnum[2] + 1
                    tempmovingindexs[4] = tempmovingindexs[4] + 2 * 1
                else
                    tempresult[3] = tempArr[4]
                    numOfnum[3] = numOfnum[3] + 1
                    tempmovingindexs[4] = tempmovingindexs[4] + 1
                end
            end
        else
            if tempresult[3] == tempArr[4] and numOfnum[3] < 2 then
                numOfnum[3] = numOfnum[3] + 1
                tempmovingindexs[4] = tempmovingindexs[4] + 1
            else
                tempresult[4] = tempArr[4]
                numOfnum[4] = numOfnum[4] + 1
                tempmovingindexs[4] = tempmovingindexs[4] + 0 * 1
            end
        end
    end

    -- for i = 1 , 4 do
    --     tempresult[i] = 0
    --     numOfnum[i] = 0
    -- end
    -- return tempmovingindexs
end

function resetTempTables ()
    for i = 1 , 4 do
        tempArr[i] = 1
        tempresult[i] = 0
        numOfnum[i] = 0
        tempmovingindexs[i] = 0
        tempTarget[i] = -1 
    end
end

-- function setTarget()
--     --[[
--         use tempmovingindexs and numOfnum to update tempTarget
--     ]]
    
-- end
