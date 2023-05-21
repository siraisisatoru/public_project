// Universal file for front page charts

var fullness = [0, 0, 0, 0]; // 0-25, 25.1-50, 50.1-75, 75.1-100
var batteryFullness = [0, 0, 0, 0]; // 0-25, 25.1-50, 50.1-75, 75.1-100
var chart1;
var chart2;
var lineChart;
const autocolors = window["chartjs-plugin-autocolors"];

var lineIDbuffer = [];

function setPie() {
    // fp_chart_1;
    chart1 = new Chart("fp_chart_1", {
        type: "pie",
        data: {
            labels: ["<25%", "<50%", ">50%", ">75%"],
            datasets: [
                {
                    data: fullness,
                    backgroundColor: color_bar,
                    hoverOffset: 4,
                },
            ],
        },
        options: {
            plugins: {
                legend: { display: false },
                title: {
                    display: true,
                    text: "Overall bin fullness",
                    padding: {
                        top: 2,
                        bottom: 2,
                    },
                },
            },
        },
    });

    chart2 = new Chart("fp_chart_2", {
        type: "pie",
        data: {
            labels: ["Low power", "<50%", ">50%", ">75%"],
            datasets: [
                {
                    data: batteryFullness,
                    backgroundColor: color_bar_rev,
                    hoverOffset: 4,
                },
            ],
        },
        options: {
            plugins: {
                legend: { display: false },
                title: {
                    display: true,
                    text: "Overall battery fullness",
                    padding: {
                        top: 2,
                        bottom: 2,
                    },
                },
            },
        },
    });
}

export function updatePie(newFullness, newBatteryFullness) {
    
    chart1.data.datasets.forEach((dataset) => {
        dataset.data = newFullness;
    });
    chart1.update();
    chart2.data.datasets.forEach((dataset) => {
        dataset.data = newBatteryFullness;
    });
    chart2.update();
}

function setLineChart() {
    // lineChart = new Chart("fp_top_list_trend", config);
    lineChart = new Chart("fp_top_list_trend", {
        type: "line",
        data: {
            datasets: [],
        },
        options: {
            scales: {
                x: {
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
    lineChart.options.plugins.legend = {
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

export function getLineList() {
    let list = [];
    lineChart.data.datasets.forEach((ele) => {
        // console.log(ele);
        list.push(ele.label);
    });
    return list;
}

export function removeLine(ID) {
    
    for (let i = 0 ; i < lineChart.data.datasets.length;i++){
        // console.log(lineChart.data.datasets[i].label)
        if(lineChart.data.datasets[i].label == ID){
            lineChart.data.datasets.splice(i,1);
            break;
        }
    }
}

export function clearLine() {
    // console.log("remove lines");
    lineChart.data.datasets = [];
}
// data_in, sensorData.key, top10Full_ID
export function updateLine(data_in, ID) {
    lineChart.data.datasets.push({
        label: ID,
        data: data_in,
    });
    lineChart.update();
}

setPie();
setLineChart();
