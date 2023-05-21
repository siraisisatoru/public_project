# This file is used for uploading data to the firebase realtime database
# Input dummy data from another script (expected ID_map_data.json)
# Use push function for 'building' field

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import json


cred = credentials.Certificate("elec5518-7d7c2-firebase-adminsdk-zt6lv-ae24bd78eb.json")
firebase_admin.initialize_app(cred)

ref = db.reference(
    "/", url="https://elec5518-7d7c2-default-rtdb.asia-southeast1.firebasedatabase.app"
)

# buildings_ref = ref.child("buildings")


with open(
    "/Users/ufobensonwong/dev/USYD-related/year_2/sem_1/elec5518/iot_project/firebase_access/ID_map_data.json",
    "r",
) as f:
    IDMAP = json.load(f)

# print(IDMAP)
USYD = IDMAP["USYD"]
Stations = IDMAP["Stations"]
# print(USYD)
# print(Stations)

uploadType = "all"  # station, USYD, all


if uploadType == "USYD" or uploadType == "all":
    for building in USYD:
        # print(building, '->', USYD[building])
        for level in USYD[building]:
            # print(level, '->', USYD[building][level])
            for idx, dataSet in enumerate(USYD[building][level]):
                # print(idx, dataSet)
                print(dataSet["ID"])
                # print(building, level, idx)
                # every IDs in each floor in each building
                # print(dataSet["ID"])
                sensor_ref = (
                    ref.child("buildings")
                    .child("USYD")
                    .child(building)
                    .child(level)
                    .child(dataSet["ID"])
                )

                for i in range(len(dataSet["fullness"])):
                    sensor_ref.push(
                        {
                            "timestamp": dataSet["timestamp"][i],
                            "weight": dataSet["weight"][i],
                            "power": dataSet["battery"][i],
                            "location": building + " " + dataSet["ID"],
                            "fullness": dataSet["fullness"][i],
                            "fullDepth": dataSet["fullDepth"],
                            "depth": dataSet["fullDepth"]
                            * (1 - dataSet["fullness"][i]),
                        }
                    )

if uploadType == "station" or uploadType == "all":
    for sName in Stations:
        # print(sName, '->', USYD[sName])
        for level in Stations[sName]:
            # print(level, '->', USYD[sName][level])
            for idx, dataSet in enumerate(Stations[sName][level]):
                # print(idx, dataSet)
                print(dataSet["ID"])

                # print(building, level, idx)
                # every IDs in each floor in each building
                # print(dataSet["ID"])
                sensor_ref = (
                    ref.child("buildings")
                    .child("Stations")
                    .child(sName)
                    .child(level)
                    .child(dataSet["ID"])
                )

                for i in range(len(dataSet["fullness"])):
                    sensor_ref.push(
                        {
                            "timestamp": dataSet["timestamp"][i],
                            "weight": dataSet["weight"][i],
                            "power": dataSet["battery"][i],
                            "location": sName + " " + dataSet["ID"],
                            "fullness": dataSet["fullness"][i],
                            "fullDepth": dataSet["fullDepth"],
                            "depth": dataSet["fullDepth"]
                            * (1 - dataSet["fullness"][i]),
                        }
                    )


print("done upload")
