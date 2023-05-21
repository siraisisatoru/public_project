var chartList = {};
const autocolors = window["chartjs-plugin-autocolors"];

function setCollapse() {
    // const main_flex = document.getElementById("main_flex");

    const USYD_lookup = lookUp["USYD"];
    const Station_lookup = lookUp["Stations"];

    // console.log(USYD_lookup);
    // console.log(Station_lookup);
    setBuildingCollapse(USYD_lookup, "USYD");
    setBuildingCollapse(Station_lookup, "Stations");
}

function setBuildingCollapse(lookup_domain, colorKey) {
    const colorLookup = chartCollapse[colorKey];
    // console.log(colorLookup);

    const collapse_detail =
        colorKey == "USYD"
            ? document.getElementById("USYD-collapse-detail")
            : document.getElementById("stations-collapse-detail");

    var chartDiv;
    var collapseDiv;
    var inputTag;
    var collapseSummary;
    var collapseDetail;
    var detail;
    var canvasTag;

    for (const [domain_key, value] of Object.entries(lookup_domain)) {
        chartDiv = document.createElement("div");
        chartDiv.id = "chart-" + domain_key + "-div";

        collapseDiv = document.createElement("div");
        collapseDiv.classList.add(
            "collapse",
            "collapse-plus",
            "w-full",
            "mx-auto",
            "my-1",
            "rounded-lg"
        );
        inputTag = document.createElement("input");
        inputTag.classList.add("peer");
        inputTag.type = "checkbox";
        inputTag.id = "ckbox-" + domain_key;
        collapseSummary = document.createElement("div");
        collapseSummary.classList.add(
            "collapse-title",
            "text-primary-content",
            colorLookup[0],
            "peer-checked:" + colorLookup[1]
        );
        collapseSummary.innerHTML = domain_key;
        collapseDetail = document.createElement("div");
        collapseDetail.classList.add(
            "collapse-content",
            "text-primary-content",
            colorLookup[0],
            "peer-checked:" + colorLookup[1]
        );
        detail = document.createElement("div");
        detail.classList.add("bg-white", "rounded");
        canvasTag = document.createElement("canvas");
        canvasTag.id = "chart-" + domain_key;
        canvasTag.classList.add("w-full", "h-72");

        detail.appendChild(canvasTag);
        collapseDetail.appendChild(detail);

        collapseDiv.appendChild(inputTag);
        collapseDiv.appendChild(collapseSummary);
        collapseDiv.appendChild(collapseDetail);

        chartDiv.appendChild(collapseDiv);
        collapse_detail.appendChild(chartDiv);

        initChart(domain_key, canvasTag.id);
    }
}

function initChart(domain_key, canvasID) {
    chartList[domain_key] = new Chart(canvasID, {
        type: "line",
        data: {
            datasets: [],
        },
        options: {
            scales: {
                x: {
                    // type: "time",
                    // time: {
                    //     unit: "day",
                    //     // displayFormats: {
                    //     //     day: "DD",
                    //     // },
                    //     tooltipFormat: "DD",
                    // },

                    type: "time",
                    time: {
                        displayFormats: {
                            day: "d MMM",
                        },
                        round: "day",
                        unit: "day",
                    },

                    title: {
                        display: true,
                        text: "Date",
                    },
                },
                y: {
                    title: {
                        display: true,
                        text: "Fullness (%)",
                    },
                },
            },
            responsive: true,
            maintainAspectRatio: false,
            parsing: false,
            elements: {
                line: {
                    borderWidth: 1,
                },
                point: {
                    radius: 1,
                },
            },
        },
        plugins: [autocolors],
    });
    // console.log(domain_key);
    chartList[domain_key].options.plugins.legend = {
        position: "top",
        labels: {
            fontColor: "rgb(255, 99, 132)",
        },
        onClick: function (e, legendItem) {
            var index = legendItem.datasetIndex;
            var ci = this.chart;
            var alreadyHidden =
                ci.getDatasetMeta(index).hidden === null ? false : ci.getDatasetMeta(index).hidden;

            ci.data.datasets.forEach(function (e, i) {
                var meta = ci.getDatasetMeta(i);

                if (i !== index) {
                    if (!alreadyHidden) {
                        meta.hidden = meta.hidden === null ? !meta.hidden : null;
                    } else if (meta.hidden === null) {
                        meta.hidden = true;
                    }
                } else if (i === index) {
                    meta.hidden = null;
                }
            });

            ci.update();
        },
    };
}

export function getLineList(domain_key) {
    let list = [];
    chartList[domain_key].data.datasets.forEach((ele) => {
        // console.log(ele);
        list.push(ele.label);
    });
    return list;
}

export function removeLine(ID, domain_key) {
    for (let i = 0; i < chartList[domain_key].data.datasets.length; i++) {
        // console.log(chartList[domain_key].data.datasets[i].label)
        if (chartList[domain_key].data.datasets[i].label == ID) {
            chartList[domain_key].data.datasets.splice(i, 1);
            break;
        }
    }
}

// setCanvas(canvasTag.id, data)

export function updateLine(data_in, ID, domain_key) {
    chartList[domain_key].data.datasets.push({
        label: ID,
        data: data_in,
    });

    chartList[domain_key].update();
}


setCollapse();
