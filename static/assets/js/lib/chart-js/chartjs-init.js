(function ($) {
    "use strict";

    /*  Sales Chart
    --------------------*/

    var sales = {
        type: 'line',
        data: {
            labels: ["2012", "2013", "2014", "2015", "2016", "2018", "2019"],
            type: 'line',
            defaultFontFamily: 'Montserrat',
            datasets: [{
                label: "Clothes",
                data: [0, 42, 23, 14, 25, 15, 140],
                backgroundColor: 'transparent',
                borderColor: '#e6a1f2',
                borderWidth: 3,
                pointStyle: 'circle',
                pointRadius: 5,
                pointBorderColor: 'transparent',
                pointBackgroundColor: '#e6a1f2',

                    }, {
                label: "Foods",
                data: [0, 30, 10, 60, 80, 63, 10],
                backgroundColor: 'transparent',
                borderColor: '#ed7f7e',
                borderWidth: 3,
                pointStyle: 'circle',
                pointRadius: 5,
                pointBorderColor: 'transparent',
                pointBackgroundColor: '#ed7f7e',
                    }, {
                label: "Electronics",
                data: [0, 50, 40, 20, 40, 79, 20],
                backgroundColor: 'transparent',
                borderColor: '#87de75',
                borderWidth: 3,
                pointStyle: 'circle',
                pointRadius: 5,
                pointBorderColor: 'transparent',
                pointBackgroundColor: '#87de75',
                    }]
        },
        options: {
            responsive: true,

            tooltips: {
                mode: 'index',
                titleFontSize: 12,
                titleFontColor: '#000',
                bodyFontColor: '#000',
                backgroundColor: '#fff',
                titleFontFamily: 'Montserrat',
                bodyFontFamily: 'Montserrat',
                cornerRadius: 3,
                intersect: false,
            },
            legend: {
                labels: {
                    usePointStyle: true,
                    fontFamily: 'Montserrat',
                },
            },
            scales: {
                xAxes: [{
                    display: true,
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    scaleLabel: {
                        display: false,
                        labelString: 'Month'
                    }
                        }],
                yAxes: [{
                    display: true,
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Value'
                    }
                        }]
            },
            title: {
                display: false,
                text: 'Normal Legend'
            }
        }
    };


    var team = {
        type: 'line',
        data: {
            labels: ["2012", "2013", "2014", "2015", "2016", "2018", "2019"],
            type: 'line',
            defaultFontFamily: 'Montserrat',
            datasets: [{
                label: "Tasks Completed",
                data: [0, 25, 10, 3, 20, 5, 30],
                backgroundColor: 'rgba(255,163,161,.5)',
                borderColor: 'rgba(237,127,126,.5)',
                borderWidth: 0.5,
                pointStyle: 'circle',
                pointRadius: 5,
                pointBorderColor: 'transparent',
                pointBackgroundColor: 'rgba(255,163,161,1)',
                    }, {
                label: "Cards Completed",
                data: [0, 7, 3, 12, 6, 27, 0],
                backgroundColor: 'rgba(135,222,117,.5)',
                borderColor: 'rgba(135,222,117,.5)',
                borderWidth: 0.5,
                pointStyle: 'circle',
                pointRadius: 5,
                pointBorderColor: 'transparent',
                pointBackgroundColor: 'rgba(135,222,117,1)',
                    }
                    , {
                label: "Product Release",
                data: [0, 15, 23, 8, 4, 14, 17],
                backgroundColor: 'rgba(95,180,250,.5)',
                borderColor: 'rgba(135,222,117,.5)',
                borderWidth: 0.5,
                pointStyle: 'circle',
                pointRadius: 5,
                pointBorderColor: 'transparent',
                pointBackgroundColor: 'rgba(95,180,250,1)',
                    }]
        },
        options: {
            responsive: true,
            tooltips: {
                mode: 'index',
                titleFontSize: 12,
                titleFontColor: '#000',
                bodyFontColor: '#000',
                backgroundColor: '#fff',
                titleFontFamily: 'Montserrat',
                bodyFontFamily: 'Montserrat',
                cornerRadius: 3,
                intersect: false,
            },
            legend: {
                position: 'top',
                labels: {
                    usePointStyle: true,
                    fontFamily: 'Montserrat',
                },


            },
            scales: {
                xAxes: [{
                    display: true,
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    scaleLabel: {
                        display: false,
                        labelString: 'Month'
                    }
                        }],
                yAxes: [{
                    display: true,
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Value'
                    }
                        }]
            },
            title: {
                display: false,
            }
        }
    };



    var barChart = {
        type: 'bar',
        data: {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
                {
                    label: "My First dataset",
                    data: [65, 59, 80, 81, 56, 55, 40],
                    borderColor: "rgba(135,222,117,.5)",
                    borderWidth: "0",
                    backgroundColor: "rgba(135,222,117,.5)"
                            },
                {
                    label: "My Second dataset",
                    data: [28, 48, 40, 19, 86, 27, 90],
                    borderColor: "rgba(0,0,0,0.09)",
                    borderWidth: "0",
                    backgroundColor: "rgba(0,0,0,0.07)"
                            }
                        ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                                }]
            }
        }
    };



    var radarChart = {
        type: 'radar',
        data: {
            labels: [["Eating", "Dinner"], ["Drinking", "Water"], "Sleeping", ["Designing", "Graphics"], "Coding", "Cycling", "Running"],
            datasets: [
                {
                    label: "My First dataset",
                    data: [65, 59, 66, 45, 56, 55, 40],
                    borderColor: "rgba(135,222,117,.5)",
                    borderWidth: "1",
                    backgroundColor: "rgba(135,222,117,.5)"
                            },
                {
                    label: "My Second dataset",
                    data: [28, 12, 40, 19, 63, 27, 87],
                    borderColor: "rgba(55, 160, 0, 0.7",
                    borderWidth: "1",
                    backgroundColor: "rgba(55, 160, 0, 0.5)"
                            }
                        ]
        },
        options: {
            legend: {
                position: 'top'
            },
            scale: {
                ticks: {
                    beginAtZero: true
                }
            }
        }
    };



    var lineChart = {
        type: 'line',
        data: {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
                {
                    label: "My First dataset",
                    borderColor: "rgba(237,127,126,.5)",
                    borderWidth: "1",
                    backgroundColor: "rgba(237,127,126,.5)",
                    data: [22, 44, 67, 43, 76, 45, 12]
                            },
                {
                    label: "My Second dataset",
                    borderColor: "rgba(55, 160, 0, 0.5)",
                    borderWidth: "1",
                    backgroundColor: "rgba(55, 160, 0, 0.5)",
                    pointHighlightStroke: "rgba(26,179,148,1)",
                    data: [16, 32, 18, 26, 42, 33, 44]
                            }
                        ]
        },
        options: {
            responsive: true,
            tooltips: {
                mode: 'index',
                intersect: false
            },
            hover: {
                mode: 'nearest',
                intersect: true
            }

        }
    };



    var pieChart = {
        type: 'pie',
        data: {
            datasets: [{
                data: [45, 25, 20, 10],
                backgroundColor: [
                                    "rgba(237,127,126,0.9)",
                                    "rgba(237,127,126,0.7)",
                                    "rgba(237,127,126,0.5)",
                                    "rgba(0,0,0,0.07)"
                                ],
                hoverBackgroundColor: [
                                    "rgba(237,127,126,0.9)",
                                    "rgba(237,127,126,0.7)",
                                    "rgba(237,127,126,0.5)",
                                    "rgba(0,0,0,0.07)"
                                ]

                            }],
            labels: [
                            "green",
                            "green",
                            "green"
                        ]
        },
        options: {
            responsive: true
        }
    };




    var doughutChart = {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [45, 25, 20, 10],
                backgroundColor: [
                                    "rgba(237,127,126,0.9)",
                                    "rgba(237,127,126,0.7)",
                                    "rgba(237,127,126,0.5)",
                                    "rgba(0,0,0,0.07)"
                                ],
                hoverBackgroundColor: [
                                    "rgba(237,127,126,0.9)",
                                    "rgba(237,127,126,0.7)",
                                    "rgba(237,127,126,0.5)",
                                    "rgba(0,0,0,0.07)"
                                ]

                            }],
            labels: [
                            "green",
                            "green",
                            "green",
                            "green"
                        ]
        },
        options: {
            responsive: true
        }
    };




    var polarChart = {
        type: 'polarArea',
        data: {
            datasets: [{
                data: [15, 18, 9, 6, 19],
                backgroundColor: [
                                    "rgba(237,127,126,0.9)",
                                    "rgba(237,127,126,0.8)",
                                    "rgba(237,127,126,0.7)",
                                    "rgba(0,0,0,0.2)",
                                    "rgba(237,127,126,0.5)"
                                ]

                            }],
            labels: [
                            "green",
                            "green",
                            "green",
                            "green"
                        ]
        },
        options: {
            responsive: true
        }
    };



    var singelBarChart = {
        type: 'bar',
        data: {
            labels: ["Sun", "Mon", "Tu", "Wed", "Th", "Fri", "Sat"],
            datasets: [
                {
                    label: "My First dataset",
                    data: [40, 55, 75, 81, 56, 55, 40],
                    borderColor: "rgba(55, 160, 0, 0.9)",
                    borderWidth: "0",
                    backgroundColor: "rgba(55, 160, 0, 0.5)"
                            }
                        ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                                }]
            }
        }
    };




    window.onload = function () {
        var ctx = document.getElementById("sales-chart").getContext("2d");
        window.myLine = new Chart(ctx, sales);

        var ctx = document.getElementById("team-chart").getContext("2d");
        window.myLine = new Chart(ctx, team);

        var ctx = document.getElementById("barChart").getContext("2d");
        window.myLine = new Chart(ctx, barChart);

        var ctx = document.getElementById("radarChart").getContext("2d");
        window.myLine = new Chart(ctx, radarChart);

        var ctx = document.getElementById("lineChart").getContext("2d");
        window.myLine = new Chart(ctx, lineChart);

        var ctx = document.getElementById("pieChart").getContext("2d");
        window.myLine = new Chart(ctx, pieChart);

        var ctx = document.getElementById("doughutChart").getContext("2d");
        window.myLine = new Chart(ctx, doughutChart);

        var ctx = document.getElementById("polarChart").getContext("2d");
        window.myLine = new Chart(ctx, polarChart);

        var ctx = document.getElementById("singelBarChart").getContext("2d");
        window.myLine = new Chart(ctx, singelBarChart);
    }; 
    
})(jQuery);









(function ($) {
    "use strict";



    // single bar chart
    var ctx = document.getElementById("singelBarChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Sun", "Mon", "Tu", "Wed", "Th", "Fri", "Sat"],
            datasets: [
                {
                    label: "My First dataset",
                    data: [40, 55, 75, 81, 56, 55, 40],
                    borderColor: "rgba(55, 160, 0, 0.9)",
                    borderWidth: "0",
                    backgroundColor: "rgba(55, 160, 0, 0.5)"
                            }
                        ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                                }]
            }
        }
    });




})(jQuery);