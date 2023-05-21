import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import json


cred = credentials.Certificate("elec5518-7d7c2-firebase-adminsdk-zt6lv-ae24bd78eb.json")
firebase_admin.initialize_app(cred)

ref = db.reference(
    "/", url="https://elec5518-7d7c2-default-rtdb.asia-southeast1.firebasedatabase.app"
)


deleteType = "all"  # station, USYD, all, clean

db_ref = ref.child("buildings")

if deleteType == "station":
    db_ref = db_ref.child("Stations")
    db_ref.delete()
    print('deleted Stations') 

elif deleteType == "USYD":
    db_ref = db_ref.child("USYD")
    db_ref.delete()
    print('deleted USYD') 

elif deleteType == "all":
    db_ref.delete()
    print('deleted all') 

elif deleteType == "clean":
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

    n = 145
    def cleandata(buildings, building, level, idx, ID):
        print(buildings, building, level, idx, ID)
        nodes = ref.child("buildings").child(buildings).child(building).child(level).child(ID).get().keys()
        # print((nodes))
        deleteNode = list(nodes).copy()
        deleteNode = deleteNode[n:]
        for node in deleteNode:
            print (node)
            ref.child("buildings").child(buildings).child(building).child(level).child(ID).child(node).delete()
            print('node deleted')
    for building in USYD:
        # print(building, '->', USYD[building])
        for level in USYD[building]:
            # print(level, '->', USYD[building][level])
            # print(int(re.sub(r'[^\d]+', '', level)))
            for idx, ID in enumerate(USYD[building][level]):
                # print(idx, ID)
                # print(building, level, idx, ID)
                nodes = ref.child("buildings").child('USYD').child(building).child(level).child(ID).get().keys()
                # print(len(nodes))
                if(len(nodes) > n):
                    cleandata('USYD', building, level, idx, ID)
    # getChildrenCount

    for sName in Stations:
        # print(sName, '->', USYD[sName])
        for level in Stations[sName]:
            # print(level, '->', Stations[sName][level])
            for idx, ID in enumerate(Stations[sName][level]):
                # print(idx, ID)
                # print(sName, level, idx, ID)
                nodes = ref.child("buildings").child('Stations').child(sName).child(level).child(ID).get().keys()
                # print(nodes)
                # print(len(nodes))
                if(len(nodes) > n):
                    cleandata('Stations',sName, level, idx, ID)
    print('clean done')


