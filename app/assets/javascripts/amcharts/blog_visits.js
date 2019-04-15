AmCharts.makeChart( 'blog-visits-chart', {
  "pathToImages": "http://cdn.amcharts.com/lib/3/images/",
  "dataProvider": [],
  "type": "serial",
  "categoryField": "url",
  "startDuration": 1,
  "creditsPosition": "top-right",
  "titles": [{
    'text': 'Blogs - Site Visits'
  }],
  "categoryAxis": {
    "gridPosition": "start",
    "labelsEnabled": false,
    "title": "Blog URL [hover chart bars]"
  },
  "valueAxes": [{
    "title": "Visits [a.u.]"
  }],
  "graphs": [{
    "valueField": "visits",
    "type": "column",
    "fillAlphas": 0.8,
    "lineAlpha": 0,
    "balloonText": "[[category]]: <b>[[value]]</b>"
  }],
  "chartScrollbar": {
    "dragIcon": "dragIconRoundBig",
    "backgroundColor": "#808080",
    "backgroundAlpha": 1
  }
});
