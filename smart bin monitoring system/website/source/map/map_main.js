var map;
var currentView;
var popupMap_buffer = [];
var popupMap;
var markers;
var markerList = [];

var SNAPSHOT_buffer = {};
var zoomBack = false;
const map_value = (value, x1, y1, x2, y2) => ((value - x1) * (y2 - x2)) / (y1 - x1) + x2;

export function setZoomback(zoom) {
    zoomBack = zoom;
}

export function setMap() {
    map = L.map("map", {
        maxBoundsViscosity: 1.0,
        maxBounds: [
            [-90, -180],
            [90, 180],
        ],
        tap: false,
    }).setView([-33.89571095971944, 151.18809700012207], 15);
    map.invalidateSize();

    L.tileLayer(
        "https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}",
        {
            maxZoom: 18,
            minZoom: 2,
            attribution: 'Tiles &copy; <a href="http://www.esrij.com/"> Esri Japan </a>',
        }
    ).addTo(map);
}

export function getmarkerList() {
    return markerList;
}

export function checkmarkerList() {
    return typeof markerList;
}

export function updateBuffer(buffer) {
    SNAPSHOT_buffer = buffer;
}

export function getmarkers() {
    return markers;
}

export function addMarker() {
    if (typeof markers == "undefined") {
        // the variable is defined

        var USYD_lookup = lookUp["USYD"];
        var Station_lookup = lookUp["Stations"];

        var trainMarker = L.ExtraMarkers.icon({
            icon: "fa-train-subway",
            markerColor: "orange",
            shape: "square",
            prefix: "fa",
        });
        var buildingMarker = L.ExtraMarkers.icon({
            icon: "fa-building",
            markerColor: "cyan",
            shape: "square",
            prefix: "fa",
        });
        markers = L.markerClusterGroup({
            chunkedLoading: true,
            showCoverageOnHover: false,
        });
        add_marker_group(USYD_lookup, buildingMarker, "USYD");
        add_marker_group(Station_lookup, trainMarker, "Stations");
        markers.addLayers(markerList);
        map.addLayer(markers);
    }
}

function add_marker_group(lookup_domain, marker_domain, lookup_key) {
    for (const [domain_key, value] of Object.entries(lookup_domain)) {
        var a = value;
        var title = a[2];
        var marker = L.marker(L.latLng(a[0], a[1]), {
            title: title,
            icon: marker_domain,
        });

        var floorPlanStr = loadFloorPlan(domain_key);

        marker.bindPopup(floorPlanStr, {
            minWidth: 300,
            maxWidth: 301,
            maxHeight: 300,
        });

        marker.on("click", function () {
            currentView = map.getCenter();
            $(".leaflet-control-zoom").css("visibility", "hidden");
            this.openPopup();
            popupMap = L.map("floorMap_" + domain_key, {
                crs: L.CRS.Simple,
                minZoom: 0,
                maxZoom: 1,
                zoomSnap: 0.5,
                zoomDelta: 0.5,
                maxBoundsViscosity: 1,
            }).setView([0, 0], -1.5);
            popupMap_buffer.push(popupMap);

            var floor_size = [];

            const fullPathObj = lookUp_floor_image_path[lookup_key][domain_key];
            const touchPtArr = lookUp_floor_image_coords[lookup_key][domain_key];
            const building_level = fullPathObj.length;
            var layers = {};

            for (let i = 0; i < building_level; i++) {
                var imageDia = fullPathObj[i].replace(/^.*[\\\/]/, "");
                imageDia = imageDia.split(".")[0].split("-")[1];
                floor_size.push([
                    parseInt(imageDia.split("x")[1]) / 5,
                    parseInt(imageDia.split("x")[0]) / 5,
                ]);
                // console.log(floor_size[i]);

                layers["level " + (i + 1)] = L.layerGroup([
                    L.imageOverlay(fullPathObj[i], [
                        [0, 0],
                        [floor_size[i][0], floor_size[i][1]],
                    ]),
                ]);

                // console.log(touchPtArr[i]);
                // console.log(SNAPSHOT_buffer);

                for (let ptIdx = 0; ptIdx < touchPtArr[i].length; ptIdx++) {
                    const localID = ID_LOOKUP[lookup_key][domain_key]["L" + (i + 1)][ptIdx];
                    // console.log(localID);
                    // console.log(SNAPSHOT_buffer[localID][Object.keys(SNAPSHOT_buffer[localID])]);
                    const localSensor =
                        SNAPSHOT_buffer[localID][Object.keys(SNAPSHOT_buffer[localID])];
                    const fullness = localSensor.fullness * 100;
                    // const fullness = 0;

                    layers["level " + (i + 1)].addLayer(
                        L.circle(touchPtArr[i][ptIdx], {
                            radius: circle_r,
                            color: color_bar[Math.floor(map_value(fullness, 0, 100, 0, 4))],
                            fillOpacity: 0.7,
                        }).on("click", () => {
                            document.getElementById("sensorInfo").classList.add("modal-open");
                            // TODO: change id to actual id
                            document.getElementById("dataSensorLocation").innerHTML =
                                localSensor.location;
                            // document.getElementById("dataRubbishHeight").innerHTML =
                            //     localSensor.depth.toFixed(3) + " cm";
                            let RH = localSensor.fullDepth - localSensor.depth;
                            if (RH < 0) {
                                RH = 0;
                            }
                            document.getElementById("dataRubbishHeight").innerHTML =
                                (RH).toFixed(3) + " cm";
                            document.getElementById("dataRubbishWeight").innerHTML =
                                localSensor.weight.toFixed(3) + " kg";
                            document.getElementById("dataBinFullness").innerHTML =
                                fullness.toFixed(3) + "%";
                            document.getElementById("dataSensorBattery").innerHTML =
                                (localSensor.power * 100).toFixed(3) + "%";
                            document.getElementById("dataLastUpdate").innerHTML = new Date(
                                localSensor.timestamp
                            ).toLocaleString("en-AU", {
                                localeMatcher: "best fit",
                                timeZoneName: "short",
                            });
                        })
                    );
                }
            }

            var currentBaseLayer = layers["level 1"].addTo(popupMap);

            popupMap.setView([floor_size[0][0] / 2, floor_size[0][1] / 2]);

            popupMap.setMaxBounds([
                [-10, -10],
                [floor_size[0][0] + 10, floor_size[0][1] + 10],
            ]);

            popupMap
                // .on("click", function (e) {
                //   console.log(e.latlng);
                //   currentBaseLayer.addLayer(L.marker(e.latlng));
                // })
                .on("baselayerchange", function (e) {
                    currentBaseLayer = e.layer;
                    popupMap.setMaxBounds([
                        [-10, -10],
                        floor_size[parseInt(e.name.split(" ")[1]) - 1].map((v) => v + 10),
                    ]);
                    popupMap.setView(
                        floor_size[parseInt(e.name.split(" ")[1]) - 1].map((v) => v + 10)
                    );
                });
            if (building_level > 1) L.control.layers(layers, null).addTo(popupMap);
        });

        marker.getPopup().on("remove", function (popup) {
            popupMap_buffer[0].off();
            popupMap_buffer[0].remove();
            popupMap_buffer.shift();
            if (zoomBack) {
                map.flyTo(currentView);
            }
            $(".leaflet-control-zoom").css("visibility", "");
        });
        index_dict[domain_key] = markerList.length;
        markerList.push(marker);
    }
}

function loadFloorPlan(domain_key) {
    var mapStr = " <div id='floorMap_" + domain_key + "' class='floorMap'> </div>";
    mapStr += `
    <div id="sensorInfo" class="modal z-10000">
      <div class="modal-box relative">
        <label onclick="document.getElementById('sensorInfo').classList.remove('modal-open');" class="btn btn-sm btn-circle absolute right-2 top-2">✕</label>
        <div id="sensorData" >
          <table class="table-auto">
            <tbody class="table-auto">
              <tr>
                <td class="py-2">Sensor location</td>
                <td class="py-2" id="dataSensorLocation"> </td>
              </tr>
              <tr>
                <td class="py-2">Rubbish height:</td>
                <td class="py-2" id="dataRubbishHeight"> </td>
              </tr>
              <tr>
                <td class="py-2">Rubbish weight:</td>
                <td class="py-2" id="dataRubbishWeight"> </td>
              </tr>
              <tr>
                <td class="py-2">Bin fullness:</td>
                <td class="py-2" id="dataBinFullness"> </td>
              </tr>
              <tr>
                <td class="py-2">Battery level:</td>
                <td class="py-2" id="dataSensorBattery"> </td>
              </tr>
              <tr >
                <td class="py-2">Last update time:</td>
                <td class="py-2" id="dataLastUpdate"> </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>`;
    return mapStr;
}

// setMap();
