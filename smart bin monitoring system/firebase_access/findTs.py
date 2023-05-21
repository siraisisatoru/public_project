import time

from datetime import datetime


n = int(16 * 7 * 1.3)


# beginTimestamp = 1684267200000 - 133200000*2
beginTimestamp = 1684267200000 - 3600000 * 24 * 2
targetTimestamp = 1684911600000


delay = 0

timeStampArr = []
# timeStampArr = [timeStampArr[i] * 3600 + 1682884800 + delay for i in timeStampArr]

# timeStampArr = [delay for i in timeStampArr]

for i in range(n + 11):
    if (i + 1) % 16 == 0:
        delay = 3600000 * 8
    else:
        delay = 0
    # print(delay)

    timeStampArr.append(beginTimestamp)
    beginTimestamp = beginTimestamp + 3600000 + delay
# print(timeStampArr)

for t in timeStampArr:
    dt_object = datetime.fromtimestamp(t / 1000)
    print("dt_object =", dt_object)


dt_object = datetime.fromtimestamp(targetTimestamp / 1000)
print("target T : \tdt_object =", dt_object)


"""

for j in range(10000):

    delay = 0

    timeStampArr = []
    # timeStampArr = [timeStampArr[i] * 3600 + 1682884800 + delay for i in timeStampArr]

    # timeStampArr = [delay for i in timeStampArr]

    for i in range(n + 12):
        if (i + 1) % 16 == 0:
            delay = 3600000 * 8
        else:
            delay = 0
        # print(delay)

        timeStampArr.append(beginTimestamp)
        beginTimestamp = beginTimestamp + 3600000 + delay
    # print(timeStampArr)

    deltaT = timeStampArr[-1] - targetTimestamp
    print(deltaT)

    if(deltaT == 0):
        break

    beginTimestamp = 1684267200000 - j * 100000

print(beginTimestamp)
print(timeStampArr[-1])
print(targetTimestamp)
timeStampArr = timeStampArr[12:]
"""
