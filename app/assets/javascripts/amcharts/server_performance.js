function plot_server_performance(data) {
  if(data.length > 0) {
    AmCharts.makeChart( 'server-performance-chart', {
      "pathToImages": "http://cdn.amcharts.com/lib/3/images/",
      "dataProvider": data,
      "type": "serial",
      "categoryField": "url",
      "startDuration": 1,
      "creditsPosition": "top-right",
      "graphs": [{
        "valueField": "respT",
        "type": "column",
        "fillAlphas": 0.8,
        "lineAlpha": 0,
        "balloonText": "[[category]]: <b>[[value]]</b>"
      }],
      "titles": [{
        'text': 'Server performance - response time'
      }],
      "categoryAxis": {
        "gridPosition": "start",
        "labelsEnabled": false,
        "title": "Site URL [hover chart bars]"
      },
      "valueAxes": [{
        "title": "Average server response time [ms]"
      }],
      "chartScrollbar": {
        "dragIcon": "dragIconRoundBig",
        "backgroundColor": "#808080",
        "backgroundAlpha": 1
      }
    });
  }
}
