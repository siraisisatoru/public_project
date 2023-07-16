-- --------------------------------------------------------------------------------------
backgourndC = {225 , 166 , 121} -- 赤白橡 70
BackGroundColor = { backgourndC[1]/255 , backgourndC[2]/255 , backgourndC[3]/255 , 1 } 

tabelC = {199,133,80} -- 赤朽葉 68
TableColor = {tabelC[1]/255 , tabelC[2]/255 , tabelC[3]/255 , 1}

boxC = {148 , 122 , 109} -- 胡桃 64
BoxColor = {boxC[1]/255 , boxC[2]/255 , boxC[3]/255 , 1}

dotC = {143 , 90 , 60} -- 59
DotColor = {dotC[1]/255 , dotC[2]/255 , dotC[3]/255 , 1}

-- for num 2 , 4 font , others white 1,1,1,1
-- numC = {128 , 143 , 124} 
numC = {54 , 86 , 60} -- 
NumberColor = {numC[1]/255 , numC[2]/255 , numC[3]/255 , 1}

-- for num background
n2C = {221 , 210 , 59} -- 126
Number2Color = {n2C[1]/255 , n2C[2]/255 , n2C[3]/255 , 1}

n4C = {173 , 161 , 66} -- 125
Number4Color = {n4C[1]/255 , n4C[2]/255 , n4C[3]/255 , 1}

n8C = {217 , 205 , 144} -- 124
Number8Color = {n8C[1]/255 , n8C[2]/255 , n8C[3]/255 , 1}

n16C = {134 , 193 , 102} -- 123
Number16Color = {n16C[1]/255 , n16C[2]/255 , n16C[3]/255 , 1}

n32C = {145 , 180 , 147} -- 122
Number32Color = {n32C[1]/255 , n32C[2]/255 , n32C[3]/255 , 1}

n64C = {144 , 180 , 75} -- 121
Number64Color = {n64C[1]/255 , n64C[2]/255 , n64C[3]/255 , 1}

n128C = {102 , 186 , 183} -- 120
Number128Color = {n128C[1]/255 , n128C[2]/255 , n128C[3]/255 , 1}

n256C = {144 , 180 , 75} -- 133
Number256Color = {n256C[1]/255 , n256C[2]/255 , n256C[3]/255 , 1}

n512C = {177 , 180 , 121} -- 132
Number512Color = {n512C[1]/255 , n512C[2]/255 , n512C[3]/255 , 1}

n1024C = {131 , 138 , 45} --131
Number1024Color = {n1024C[1]/255 , n1024C[2]/255 , n1024C[3]/255 , 1}

n2048C = {147 , 150 , 80} -- 130
Number2048Color = {n2048C[1]/255 , n2048C[2]/255 , n2048C[3]/255 , 1}

numberColor = {Number2Color , Number4Color , Number8Color , Number16Color , Number32Color , Number64Color , Number128Color , Number256Color , Number512Color , Number1024Color , Number2048Color}
-- --------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------
math.randomseed(os.time())

tableLeftTopXY = {10 , 190}
boxSize = (love.graphics.getWidth() - 7*10) /4
state = 'non'
stateCD = 1 --0.6
keyPressDelayCouter = 0
freeSpace = 16
moveCount = 0
gameOver = false
toLight = false
lightness = 0
-- --------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------
-- a table contain the conner x,y 
controllerConner = { 
    (tableLeftTopXY[1] + 10 ) + 1.5*(10 +boxSize)           , (tableLeftTopXY[2] + 10) + 4.5*(10+boxSize)          - boxSize / 4, -- TL
    (tableLeftTopXY[1] + 10 ) + 1.5*(10 +boxSize) + boxSize , (tableLeftTopXY[2] + 10) + 4.5*(10+boxSize)          - boxSize / 4, -- TR
    (tableLeftTopXY[1] + 10 ) + 1.5*(10 +boxSize)           , (tableLeftTopXY[2] + 10) + 4.5*(10+boxSize) + boxSize- boxSize / 4, -- BL
    (tableLeftTopXY[1] + 10 ) + 1.5*(10 +boxSize) + boxSize , (tableLeftTopXY[2] + 10) + 4.5*(10+boxSize) + boxSize- boxSize / 4  -- BR
}

--  the x y coordinate of the controller conners
controllerT = {controllerConner[1],controllerConner[2],controllerConner[3],controllerConner[4]}
controllerR = {controllerConner[3],controllerConner[4],controllerConner[7],controllerConner[8]}
controllerB = {controllerConner[5],controllerConner[6],controllerConner[7],controllerConner[8]}
controllerL = {controllerConner[1],controllerConner[2],controllerConner[5],controllerConner[6]}

-- 4 flags for displaying the change of controlling box
upBar = false
downBar = false
leftBar = false
rightBar = false
-- --------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------
-- numberFont = love.graphics.newFont('font/webfont.ttf' , 38)
numberFont = love.graphics.newFont('font/Big Black Bear.ttf' , 27)
gameOverFont = love.graphics.newFont('font/Big Black Bear.ttf' , 90)
defaultFont = love.graphics.newFont(12)
middleFont = love.graphics.newFont(30)
-- --------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------
-- visible arrays
-- all visible arrays refresh when gameOver
graytable = {
    NumBox(1,1,-1),NumBox(2,1,-1),NumBox(3,1,-1),NumBox(4,1,-1),
    NumBox(1,2,-1),NumBox(2,2,-1),NumBox(3,2,-1),NumBox(4,2,-1),
    NumBox(1,3,-1),NumBox(2,3,-1),NumBox(3,3,-1),NumBox(4,3,-1), 
    NumBox(1,4,-1),NumBox(2,4,-1),NumBox(3,4,-1),NumBox(4,4,-1)
}

surfaceTable = {
    ['1,1']=NumBox(1,1,0),['2,1']=NumBox(2,1,0),['3,1']=NumBox(3,1,0),['4,1']=NumBox(4,1,0),
    ['1,2']=NumBox(1,2,0),['2,2']=NumBox(2,2,0),['3,2']=NumBox(3,2,0),['4,2']=NumBox(4,2,0),
    ['1,3']=NumBox(1,3,0),['2,3']=NumBox(2,3,0),['3,3']=NumBox(3,3,0),['4,3']=NumBox(4,3,0),
    ['1,4']=NumBox(1,4,0),['2,4']=NumBox(2,4,0),['3,4']=NumBox(3,4,0),['4,4']=NumBox(4,4,0)
}
-- --------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------
-- hash talbes for the visible arrays and temporary used array
-- mapping table refresh when gameOver
-- temporary refresh right before the end of the function involved the array

col = {
    [1] = {'1,1','1,2','1,3','1,4'},
    [2] = {'2,1','2,2','2,3','2,4'},
    [3] = {'3,1','3,2','3,3','3,4'},
    [4] = {'4,1','4,2','4,3','4,4'}
}

row = {
    [1] = {'1,1','2,1','3,1','4,1'},
    [2] = {'1,2','2,2','3,2','4,2'},
    [3] = {'1,3','2,3','3,3','4,3'},
    [4] = {'1,4','2,4','3,4','4,4'}
}

tempArr = {1,1,1,1}
tempresult = {0,0,0,0}
numOfnum = {0,0,0,0}
tempmovingindexs = {0,0,0,0}
tempRender = {} --  used in main and draw
tempWaitingList = {} -- in pairs pop {x1,y1,x2,y2} --  used in main and draw
tempTarget = {-1,-1,-1,-1} 
longDisplay = true
tableComMoving = true

tempSurfaceTable = {
    ['1,1']=-1,['2,1']=-1,['3,1']=-1,['4,1']=-1,
    ['1,2']=-1,['2,2']=-1,['3,2']=-1,['4,2']=-1,
    ['1,3']=-1,['2,3']=-1,['3,3']=-1,['4,3']=-1,
    ['1,4']=-1,['2,4']=-1,['3,4']=-1,['4,4']=-1
}


-- --------------------------------------------------------------------------------------