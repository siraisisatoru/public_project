var mainchart;
export function initMainchart() {
    // End Defining data
    mainchart = new Chart("cl_chart", {
        type: "scatter",
        data: {
            // labels: ["pt1", "pt2", "pt3", "pt4", "pt5", "pt6", "pt7", "pt8"],

            datasets: [
                {
                    // data: data, // Specify the data values array
                    borderColor: "#2196f3", // Add custom color border
                    backgroundColor: "#2196f3", // Add custom color background (Points and Fill)
                    trendlineLinear: {
                        colorMin: "green",
                        colorMax: "green",
                        lineStyle: "dotted",
                        width: 2,
                    },
                },
            ],
        },
        options: {
            plugins: {
                legend: {
                    display: false,
                },
                title: {
                    display: true,
                    text: "Sensor regression analysis",
                },
            },

            // responsive: true, // Instruct chart js to respond nicely.
            maintainAspectRatio: false, // Add to prevent default behaviour of full-width/height
            elements: {
                line: {
                    borderWidth: 1,
                },
                point: {
                    radius: 1,
                },
            },
        },
    });
    mainchart.options.scales.x.title.display = true;
    mainchart.options.scales.y.title.display = true;
}

export function setMainchart(mode, data, labels) {
    // mainchart.data.datasets[0].data = data;
    // mainchart.data.labels = labels;
    if (mode == "LF") {
        mainchart.options.scales.x.title.text = "Level";
        mainchart.options.scales.y.title.text = "Fullness (%)";
        mainchart.data.datasets[0].trendlineLinear.width = 0.0001;
    } else {
        mainchart.options.scales.x.title.text = "Weight (kg)";
        mainchart.options.scales.y.title.text = "Height (cm)";
        mainchart.data.datasets[0].trendlineLinear.width = 2;
    }
    // mainchart.data.datasets[0].data =[];
    mainchart.data.datasets[0].data = data;
    // mainchart.data.labels = labels;
    // console.log(mainchart.data.datasets[0])
    // console.log(mainchart.data.labels)

    mainchart.update();
}
