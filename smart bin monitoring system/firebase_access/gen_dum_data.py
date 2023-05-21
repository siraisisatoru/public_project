# This file is used for generate reasonable dummy data
# Output csv file

import json

import re

from scipy import signal
import numpy as np
import matplotlib.pyplot as plt
import random
import time
from datetime import datetime
from datetime import timezone

import pytz


"""

|------------|------------|------------|------------|------------|------------|------------|
     Mon          Tue          Wed          Thu          Fri           Sat         Sun

|------------------------------------|
  6 7 8 9 10 11 12 1 2 3 4 5 6 7 8 9

  16 

"""


maxWeight = 5  # constant maximum weight 5kg

sineLookUp = np.sin(np.pi * np.linspace(0, 1, 100000) / 2) * 0.8

triangle = (signal.sawtooth(2 * np.pi * np.linspace(0, 1, 100000), 1) + 1) / 2 * 0.8
print(len(triangle))
print(len(sineLookUp))


# plt.plot(np.linspace(0, 1, 100000), triangle)
# plt.plot(np.linspace(0, 1, 100000), sineLookUp)
# plt.show()
# change from sine wave to triangular wave
sineLookUp = triangle




batteryLookUp = (
    1 - ((signal.sawtooth(2 * np.pi * np.linspace(0, 1, 100000), 1) + 1) / 2) * 0.85
)
batteryLookUp[len(batteryLookUp) - 1] = batteryLookUp[len(batteryLookUp) - 2]

# print(len(batteryLookUp))
# (signal.sawtooth(2 * np.pi * 5 * t, 1) + 1 )/2


sineResult_long = []
sineResult_lv2_long = []
sineResult_lv3_long = []
batteryResult_long = []

genedData = 16 * 7 * 3

x = np.linspace(1, genedData, genedData)


while 1:
    x2 = np.linspace(0, int((100000 - 1)), int(16 * (random.random() + 0.5)))
    for idn, x_2 in enumerate(x2):
        # print(int(x_2))
        sineResult_long.append((sineLookUp[int(x_2)] + random.random() * 0.2))
    if len(sineResult_long) > ((genedData) * 220):
        break

while 1:
    x2 = np.linspace(0, int((100000 - 1)), int((16 * 1.5) * (random.random() + 0.5)))
    for idn, x_2 in enumerate(x2):
        # print(int(x_2))
        sineResult_lv2_long.append((sineLookUp[int(x_2)] + random.random() * 0.2))
    if len(sineResult_lv2_long) > ((genedData) * 220):
        break

while 1:
    x2 = np.linspace(0, int((100000 - 1)), int((16 * 2) * (random.random() + 0.5)))
    for idn, x_2 in enumerate(x2):
        # print(int(x_2))
        sineResult_lv3_long.append((sineLookUp[int(x_2)] + random.random() * 0.2))
    if len(sineResult_lv3_long) > ((genedData) * 220):
        break

while 1:
    x2 = np.linspace(0, int((100000 - 1)), int(6 / 2 * 100))
    for idn, x_2 in enumerate(x2):
        # print(int(x_2))
        batteryResult_long.append(batteryLookUp[int(x_2)])
    if len(batteryResult_long) > ((genedData) * 220):
        break

# 1 -> 0    3.5hr

# print(len(sineResult_lv3_long))
# plt.plot(range(len(sineResult_long)), sineResult_long, "r-")


def divide_chunks(l, n):
    # looping till length l
    for i in range(0, len(l), n):
        yield l[i : i + n]


# How many elements each
# list should have
n = int(16 * 7 * 1.3)

weightResult_long = [
    sineResult_long[i] * maxWeight * random.uniform(0.5, 1.5)
    for i in range(len(sineResult_long))
]
weightResult = list(divide_chunks(weightResult_long, n))

weightResult2_long = [
    sineResult_lv2_long[i] * maxWeight * random.uniform(0.5, 1.5)
    for i in range(len(sineResult_lv2_long))
]
weightResult2 = list(divide_chunks(weightResult2_long, n))

weightResult3_long = [
    sineResult_lv3_long[i] * maxWeight * random.uniform(0.5, 1.5)
    for i in range(len(sineResult_lv3_long))
]
weightResult3 = list(divide_chunks(weightResult3_long, n))


sineResult = list(divide_chunks(sineResult_long, n))
sineResult_lv2 = list(divide_chunks(sineResult_lv2_long, n))
sineResult_lv3 = list(divide_chunks(sineResult_lv3_long, n))
batteryResult = list(divide_chunks(batteryResult_long, n))


beginTimestamp = 1684267200000 - 3600000 * 24 * 2
# beginTimestamp = 1684267200000 - 3600000 * 24 * 9 #testing


delay = 0

timeStampArr = []
# timeStampArr = [timeStampArr[i] * 3600 + 1682884800 + delay for i in timeStampArr]

# timeStampArr = [delay for i in timeStampArr]

for i in range(n+11):
# for i in range(n+8): #testing
    if (i + 1) % 16 == 0:
        delay = 3600000 * 8
    else:
        delay = 0
    # print(delay)

    timeStampArr.append(beginTimestamp)
    beginTimestamp = beginTimestamp + 3600000 + delay


# print(timeStampArr)

timeStampArr = timeStampArr[11:]
# timeStampArr = timeStampArr[7:] #testing





print(len(weightResult), len(weightResult[0]))
print(len(sineResult), len(sineResult[0]))
print(len(batteryResult), len(batteryResult[0]))
print(len(timeStampArr))

# plt.plot(range(len(timeStampArr)), timeStampArr, "r-")
# plt.show()

# 221 336
# 221 336
# 221 336
# 336

sineIndex = 0

with open(
    "/Users/ufobensonwong/dev/USYD-related/year_2/sem_1/elec5518/iot_project/firebase_access/ID_map.json",
    "r",
) as f:
    IDMAP = json.load(f)

# print(IDMAP)
USYD = IDMAP["USYD"]
Stations = IDMAP["Stations"]
# print(USYD)
# print(Stations)

for building in USYD:
    # print(building, '->', USYD[building])
    for level in USYD[building]:
        # print(level, '->', USYD[building][level])
        # print(int(re.sub(r'[^\d]+', '', level)))
        dataSet = []
        for idx, ID in enumerate(USYD[building][level]):
            # print(idx, ID)
            # print(building, level, idx)
            data = {
                "timestamp": timeStampArr,
                "fullDepth": 25,
                "battery": batteryResult[int(ID)],
                "ID": ID,
            }
            if int(re.sub(r"[^\d]+", "", level)) == 1:
                data["fullness"] = sineResult[int(ID)]
                data["weight"] = weightResult[int(ID)]

            elif int(re.sub(r"[^\d]+", "", level)) == 2:
                data["fullness"] = sineResult_lv2[int(ID)]
                data["weight"] = weightResult2[int(ID)]

            else:
                data["fullness"] = sineResult_lv3[int(ID)]
                data["weight"] = weightResult3[int(ID)]

            dataSet.append(data)
            # print(len(sineResult[sineIndex]),len(timeStampArr),len(batteryResult[sineIndex]),len(weightResult))

            # every IDs in each floor in each building
        USYD[building][level] = dataSet

for sName in Stations:
    # print(sName, '->', USYD[sName])
    for level in Stations[sName]:
        # print(level, '->', Stations[sName][level])
        dataSet = []
        for idx, ID in enumerate(Stations[sName][level]):
            # print(idx, ID)
            # print(sName, level, idx)
            data = {
                "timestamp": timeStampArr,
                "fullDepth": 25,
                "battery": batteryResult[int(ID)],
                "ID": ID,
            }
            if int(re.sub(r"[^\d]+", "", level)) == 1:
                data["fullness"] = sineResult[int(ID)]
                data["weight"] = weightResult[int(ID)]

            elif int(re.sub(r"[^\d]+", "", level)) == 2:
                data["fullness"] = sineResult_lv2[int(ID)]
                data["weight"] = weightResult2[int(ID)]

            elif int(re.sub(r"[^\d]+", "", level)) == 3:
                data["fullness"] = sineResult_lv3[int(ID)]
                data["weight"] = weightResult3[int(ID)]

            dataSet.append(data)

            # every IDs in each floor in each station
        Stations[sName][level] = dataSet

# print(IDMAP)


with open(
    "/Users/ufobensonwong/dev/USYD-related/year_2/sem_1/elec5518/iot_project/firebase_access/ID_map_data.json",
    "w",
) as f:
    json.dump(IDMAP, f)
