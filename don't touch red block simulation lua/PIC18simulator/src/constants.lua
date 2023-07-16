topLeftConner = {25,25}

LEDpattern = {
    -- { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    -- { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    -- { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    -- { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    -- { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    -- { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    
    { 1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    { 0,0,0,0, 1,1,1,1, 0,0,0,0, 0,0,0,0 },
    { 0,0,0,0, 0,0,0,0, 1,1,1,1, 0,0,0,0 },
    { 0,0,0,0, 1,1,1,1, 0,0,0,0, 0,0,0,0 },
    { 1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    { 0,0,0,0, 1,1,1,1, 0,0,0,0, 0,0,0,0 },
    
    { 0,0,0,0, 0,0,0,0, 1,1,1,1, 0,0,0,0 },
    { 0,0,0,0, 1,1,1,1, 0,0,0,0, 0,0,0,0 },
    { 1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    
    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },

    -- { 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1 },
    -- { 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1 },
    -- { 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1 },
    -- { 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1 },

    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 }, -- 11
    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 }, -- 12
    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 }, -- 13
    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 }, -- 14
    

    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 },
    { 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 }
}

youLost = {
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1 },
    { 0,0,1,0,1,0,0,1,0,1,0,0,1,0,0,1 },
    { 0,0,0,1,0,0,1,0,0,0,1,0,1,0,0,1 },
    { 0,0,0,1,0,0,1,0,0,0,1,0,1,0,0,1 },
    { 0,0,0,1,0,0,0,1,0,1,0,0,1,0,0,1 },
    { 0,0,0,1,0,0,0,0,1,0,0,0,0,1,1,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 1,0,0,0,1,1,0,0,0,1,1,0,1,1,1,0 },
    { 1,0,0,1,0,0,1,0,1,0,0,0,0,1,0,0 },
    { 1,0,0,1,0,0,1,0,1,0,0,0,0,1,0,0 },
    { 1,0,0,1,0,0,1,0,0,1,1,0,0,1,0,0 },
    { 1,0,0,1,0,0,1,0,0,0,0,1,0,1,0,0 },
    { 1,0,0,1,0,0,1,0,0,0,0,1,0,1,0,0 },
    { 1,1,1,0,1,1,0,0,0,1,1,0,0,1,0,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
}

youWin = {
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1 },
    { 0,0,1,0,1,0,0,1,0,1,0,0,1,0,0,1 },
    { 0,0,0,1,0,0,1,0,0,0,1,0,1,0,0,1 },
    { 0,0,0,1,0,0,1,0,0,0,1,0,1,0,0,1 },
    { 0,0,0,1,0,0,0,1,0,1,0,0,1,0,0,1 },
    { 0,0,0,1,0,0,0,0,1,0,0,0,0,1,1,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,0 },
    { 0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,1 },
    { 0,1,0,0,1,0,0,1,0,1,0,1,1,0,0,1 },
    { 0,0,1,0,1,0,1,0,0,1,0,1,0,0,0,1 },
    { 0,0,1,0,1,0,1,0,0,1,0,1,0,0,0,1 },
    { 0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
}

-- ------------------------------------------

mapRender = true

-- ------------------------------------------
delaytime = 0.2
timecounter = 0

state = 2
-- 2 = normal playing state 
-- 1 = win
-- 0 = lost



futurePattern = {0,0,0,0}
currentPattern = {0,0,0,0}
buttonDownPattern = {0,0,0,0}

levelCounter = 64 -- 64
barCounter = 9

ramResult = 0xff
WREG = 0



