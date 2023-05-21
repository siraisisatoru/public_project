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

with open(
    "/Users/ufobensonwong/dev/USYD-related/year_2/sem_1/elec5518/iot_project/firebase_access/ID_map_data.json",
    "r",
) as f:
    IDMAP = json.load(f)

# print(IDMAP)
USYD = IDMAP["USYD"]

# print(USYD["J01"]["L1"][0]["timestamp"][0])
# print(USYD["J01"]["L1"][0]["weight"][0])
# print(USYD["J01"]["L1"][0]["battery"][0])
# print("J01" + " " + USYD["J01"]["L1"][0]["ID"])
# print(USYD["J01"]["L1"][0]["fullness"][0])
# print(USYD["J01"]["L1"][0]["fullDepth"])
# print(USYD["J01"]["L1"][0]["fullDepth"] * USYD["J01"]["L1"][0]["fullness"][0])

sensor_ref = ref.child("buildings").child("USYD").child("J01").child("L1").child("0000")

sensor_ref.push(
    {
        "timestamp": USYD["J01"]["L1"][0]["timestamp"][0],
        "weight": USYD["J01"]["L1"][0]["weight"][0],
        "power": USYD["J01"]["L1"][0]["battery"][0],
        "location": "J01" + " " + USYD["J01"]["L1"][0]["ID"],
        "fullness": USYD["J01"]["L1"][0]["fullness"][0],
        "fullDepth": USYD["J01"]["L1"][0]["fullDepth"],
        "depth": USYD["J01"]["L1"][0]["fullDepth"]
        * USYD["J01"]["L1"][0]["fullness"][0],
    }
)

print("done upload")
