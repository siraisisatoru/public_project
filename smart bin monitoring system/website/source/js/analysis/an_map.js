var map;
var currentView;
var popupMap_buffer = [];
var popupMap;
var markers;
var markerList = [];

const map_value = (value, x1, y1, x2, y2) => ((value - x1) * (y2 - x2)) / (y1 - x1) + x2;

function setMap() {
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
    markers = L.markerClusterGroup({
        chunkedLoading: true,
        showCoverageOnHover: false,
    });

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

    var USYD_lookup = lookUp["USYD"];
    var Station_lookup = lookUp["Stations"];

    add_marker_group(USYD_lookup, buildingMarker, "USYD");
    add_marker_group(Station_lookup, trainMarker, "Stations");
    markers.addLayers(markerList);

    map.addLayer(markers);
}

function add_marker_group(lookup_domain, marker_domain, lookup_key) {
    for (const [domain_key, value] of Object.entries(lookup_domain)) {
        var a = value;
        var title = a[2];
        var marker = L.marker(L.latLng(a[0], a[1]), {
            title: title,
            icon: marker_domain,
        });

        marker.on("click", function () {
            // close all
            const checkBoxs = document.querySelectorAll("input[type=checkbox]");
            checkBoxs.forEach((ck) => {
                ck.checked = false;
            });
            // open target one
            document.getElementById("checkbox-" + lookup_key).checked = true;
            document.getElementById("ckbox-" + domain_key).checked = true;
            // scroll down
            document.getElementById("chart-" + domain_key + "-div").scrollIntoView({
                behavior: "smooth",
            });
        });

        index_dict[domain_key] = markerList.length;
        markerList.push(marker);
    }
}

setMap();
