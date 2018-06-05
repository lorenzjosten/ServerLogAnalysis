function plot_site_usage(data) {
  if(data.length > 0) {
    AmCharts.makeChart( 'site-usage-chart', {
      "dataProvider": data,
      "type": "serial",
      "categoryField": "hour",
      "startDuration": 1,
      "creditsPosition": "top-right",
      "titles": [{
        'text': 'Average daily site visits'
      }],
      "categoryAxis": {
        "gridPosition": "start",
        "labelsEnabled": true,
        "title": "Hour"
      },
      "valueAxes": [{
        "title": "Visits [a.u.]"
      }],
      "graphs": [{
        "valueField": "visits",
        "type": "column",
        "fillAlphas": 0.8,
        "lineAlpha": 0
      }]
    });
  }
}
