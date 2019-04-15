AmCharts.makeChart( "site-usage-chart", {
  "dataProvider": [],
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
    "valueField": "average",
    "type": "column",
    "fillAlphas": 0.8,
    "lineAlpha": 0
  }]
});
