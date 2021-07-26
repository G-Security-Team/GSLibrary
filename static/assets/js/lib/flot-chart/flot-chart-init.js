 
 

/*  Pie
------------*/

$(function () {

    var data = [
        {
            label: "Primary",
            data: 1,
            color: "#8fc9fb"
        },
        {
            label: "Success",
            data: 3,
            color: "#87de75"
        },
        {
            label: "Danger",
            data: 9,
            color: "#19A9D5"
        },
        {
            label: "Warning",
            data: 20,
            color: "#ed7f7e"
        }
    ];

    var plotObj = $.plot($("#flot-pie"), data, {
        series: {
            pie: {
                show: true,
                radius: 1,
                label: {
                    show: false,

                }
            }
        },
        grid: {
            hoverable: true
        },
        tooltip: {
            show: true,
            content: "%p.0%, %s, n=%n", // show percentages, rounding to 2 decimal places
            shifts: {
                x: 20,
                y: 0
            },
            defaultTheme: false
        }
    });

});


/*  Line
----------------*/

$(function () {

    // first chart
    var chart1Options = {
        series: {
            lines: {
                show: true
            },
            points: {
                show: true
            }
        },
        xaxis: {
            mode: "time",
            timeformat: "%m/%d",
            minTickSize: [1, "day"]
        },
        grid: {
            hoverable: true
        },
        legend: {
            show: false
        },
        grid: {
            color: "#fff",
            hoverable: true,
            borderWidth: 0,
            backgroundColor: '#FFF'
        },
        tooltip: {
            show: true,
            content: "y: %y"
        }
    };
    var chart1Data = {
        label: "chart1",
        color: "#87de75",
        data: [
      [1354521600000, 6322],
      [1355040000000, 6360],
      [1355223600000, 6368],
      [1355306400000, 6374],
      [1355487300000, 6388],
      [1355571900000, 6393]
    ]
    };
    $.plot($("#chart1"), [chart1Data], chart1Options);

});

/*  Bar
-------------*/

$(function () {

    // second chart
    var flotBarOptions = {
        series: {
            bars: {
                show: true,
                barWidth: 43200000
            }
        },
        xaxis: {
            mode: "time",
            timeformat: "%m/%d",
            minTickSize: [1, "day"]
        },
        grid: {
            hoverable: true
        },
        legend: {
            show: false
        },
        grid: {
            color: "#fff",
            hoverable: true,
            borderWidth: 0,
            backgroundColor: '#FFF'
        },
        tooltip: {
            show: true,
            content: "x: %x, y: %y"
        }
    };
    var flotBarData = {
        label: "flotBar",
        color: "#87de75",
        data: [
      [1354521600000, 1000],
      [1355040000000, 2000],
      [1355223600000, 3000],
      [1355306400000, 4000],
      [1355487300000, 5000],
      [1355571900000, 6000]
    ]
    };
    $.plot($("#flotBar"), [flotBarData], flotBarOptions);


});

$(function () {
    var d1 = [[20, 20], [42, 60], [54, 20], [80, 80]];

    //flot options
    var options = {
        legend: {
            show: false
        },
        series: {
            label: "Curved Lines Test",
            curvedLines: {
                active: true,
                nrSplinePoints: 20
            }
        },
        
        grid: {
            color: "#fff",
            hoverable: true,
            borderWidth: 0,
            backgroundColor: '#FFF'
        },
        tooltip: {
            show: true,
            content: "%s | x: %x; y: %y"
        },
        yaxes: [{
            min: 10,
            max: 90
        }, {
            position: 'right'
        }]
    };

    //plotting
    $.plot($("#flotCurve"), [
        {
            data: d1,
            lines: {
                show: true,
                fill: true,
                fillColor: "rgba(135,222,117,.5)",
                lineWidth: 3
            },
            //curve the line  (old pre 1.0.0 plotting function)
            curvedLines: {
                apply: true,
                
            }
      }, {
            data: d1,
            points: {
                show: true
            }
      }
      ], options);
});