var map;
var currentView;
var popupMap_buffer = [];
var popupMap;
var markers;
var markerList = [];

var pieDatabank = {};

// const map_value = (value, x1, y1, x2, y2) => ((value - x1) * (y2 - x2)) / (y1 - x1) + x2;

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

    pieDatabank = { ...USYD_lookup, ...Station_lookup };
    // pieDatabank["Stations"] = ;

    for (const [domain_key, value] of Object.entries(pieDatabank)) {
        pieDatabank[domain_key] = [0, 0, 0, 0];
    }

    // console.log(pieDatabank);

    // markers.addLayers(markerList);
    // map.addLayer(markers);
}

export function updateBank(building, fullness, val) {
    pieDatabank[building][Math.floor(fullness * 4)] += val;
    document.getElementById("pie_" + building).innerText =
        pieDatabank[building][0] +
        "," +
        pieDatabank[building][1] +
        "," +
        pieDatabank[building][2] +
        "," +
        pieDatabank[building][3];
    $(".data-attributes span").peity("pie");
}

function add_marker_group(lookup_domain) {
    for (const [domain_key, value] of Object.entries(lookup_domain)) {
        var a = value;

        const svgIcon = L.divIcon({
            html:
                ` <p class="data-attributes">
            <span id='pie_` +
                domain_key +
                `' class='pie' data-peity='{ "radius": 18, "fill": ["#3ABFF8", "#36D399", "#FBBD23", "#F87272"]}'></span></p>`,
            className: "",
            iconSize: [24, 40],
            iconAnchor: [12, 40],
        });
        L.marker([a[0], a[1]], { icon: svgIcon }).addTo(map);

        index_dict[domain_key] = markerList.length;
        // markerList.push(marker);
        // map.addLayer(myBarChart);
    }
}
