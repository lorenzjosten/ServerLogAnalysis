class Timeframe {
  constructor() {
    this.start_date = $('#start-date-select');
    this.start_time = $('#start-time-select');
    this.end_date = $('#end-date-select');
    this.end_time = $('#end-time-select');
  }
  get t_start() {
    let t_start = this.parse_date( this.start_date.val(), this.start_time.val() );
    if( !(t_start instanceof Date && !isNaN(t_start)) ) { t_start = null; };
    return t_start;
  }
  get t_end() {
    let t_end = this.parse_date( this.end_date.val(), this.end_time.val() );
    if( !(t_end instanceof Date && !isNaN(t_end)) ) { t_end = null; };
    return t_end;
  }
  parse_date( date, time ) {
    return new Date( (date+" "+time).trim() );
  }
  update( date_str ) {
    this.start_date.attr( 'max', date_str );
    this.end_date.attr( 'max', date_str );

    if( typeof(this.start_date.attr('min')) == 'undefined' || typeof(this.end_date.attr('min')) == 'undefined' ) {
      this.start_date.attr( 'min', date_str );
      this.end_date.attr( 'min', date_str );
    };

    if( !this.start_date.val().trim() || !this.end_date.val().trim() ) {
      this.start_date.val( date_str );
      this.end_date.val( date_str );
    };

    if( !this.start_time.val().trim() || !this.end_time.val().trim() ) {
      this.start_time.val( "00:00" );
      this.end_time.val( "23:59" );
    };
  }
  reset() {
    this.start_time.val(null);
    this.end_time.val(null);
    this.start_date.removeAttr('max').removeAttr('min').val(null);
    this.end_date.removeAttr('max').removeAttr('min').val(null);
  }
};

class PlotData {
  constructor( timeframe ) {
    this.timeframe = timeframe;
    this.data = new Array();
  }
  get first() {
    return this.data[0];
  }
  get last() {
    return this.data[this.data.length-1];
  }
  get t_start() {
    let t_start = this.timeframe.t_start;
    if( t_start == null ) { t_start = this.first.date };
    return t_start;
  }
  get t_end() {
    let t_end = this.timeframe.t_end;
    if( t_end == null ) { t_end = this.last.date };
    return t_end;
  }
  get time_filtered_data() {
    let filtered = new Array();
    for( let d of this.data ) {
      if( d.date >= this.t_start && d.date <= this.t_end ) { filtered.push( d ); };
    };
    return filtered;
  }
  get server_performance() {
    let sp_data = new Array();
    for( let d of this.time_filtered_data ) {
      let index = this.indexOfURL( sp_data, d.url );
      if ( index == -1 ) { sp_data.push( {"url": d.url, "total": parseInt(d.respT), "count": 1, "average": parseInt(d.respT)} ); }
      else {
        sp_data[index].count += 1;
        sp_data[index].total += parseInt(d.respT);
        sp_data[index].average = parseInt(0.5+sp_data[index].total/sp_data[index].count);
      };
    };
    return this.sort_average_desc( sp_data );
  }
  get url_visits( ) {
    let uv_data = new Array();
    for( let d of this.time_filtered_data ) {
      let index = this.indexOfURL( uv_data, d.url );
      if ( index == -1 ) { uv_data.push( {"url": d.url, "visits": 1} ); }
      else { uv_data[index].visits += 1; };
    };
    return this.sort_visit_desc( uv_data );
  }
  get blog_visits() {
    let bv_data = new Array();
    for( let d of this.time_filtered_data ) {
      if( d.blog ) {
        let index = this.indexOfURL( bv_data, d.url );
        if ( index == -1 ) { bv_data.push( {"url": d.url, "visits": 1} ); }
        else { bv_data[index].visits += 1; };
      };
    };
    return this.sort_visit_desc( bv_data );
  }
  get site_usage() {
    let su_data = new Array();
    let dates = new Array();
    for( let i = 0; i < 24; i++ ) { su_data.push( {"hour": i, "total": 0, "average": 0} ); }
    for( let d of this.time_filtered_data ) {
      let hour = d.date.getHours();
      let date = new Date(d.date_str);
      let h_index = this.indexOfHour( su_data, hour );
      let d_index = this.indexOfDate( dates, date );
      if( d_index == -1 ) { dates.push( {"date": date} ); };
      su_data[h_index].total += 1;
      su_data[h_index].average = parseInt(0.5+su_data[h_index].total/dates.length);
    };
    return this.sort_hour_asc(su_data);
  }
  update( d ) {
    this.data.push( d );
  }
  reset() {
    this.data.length = 0;
  }
  indexOfURL( arr, url ) {
    for( let i = 0, len = arr.length; i < len; i++ ) { if ( arr[i].url == url ) { return i; } };
    return -1;
  }
  indexOfHour( arr, hour ) {
    for( let i = 0, len = arr.length; i < len; i++ ) { if ( arr[i].hour == hour ) { return i; } };
    return -1;
  }
  indexOfDate( arr, date ) {
    for( let i = 0, len = arr.length; i < len; i++ ) { if ( arr[i].date.valueOf() == date.valueOf() ) { return i; } };
    return -1;
  }
  sort_average_desc( arr ) {
    return arr.sort( function( a, b ) { return b.average-a.average; } );
  }
  sort_visit_desc( arr ) {
    return arr.sort( function( a, b ) { return b.visits - a.visits; } );
  }
  sort_hour_asc( arr ) {
    return arr.sort( function( a, b ) { return a.hour - b.hour; } );
  }
};

class Charts {
  constructor( plot_data ) {
    this.plot_data = plot_data;
  }
  reset() {
    for ( let chart of AmCharts.charts ) {
      chart.dataProvider.length = 0;
      chart.validateData();
    };
  }
  findChart( id ) {
    return AmCharts.charts.find( function(chart) {return chart.div.id == id;} );
  }
  update( id ) {
    let chart = this.findChart( id );
    switch( id ) {
      case "server-performance-chart":
        chart.dataProvider = this.plot_data.server_performance;
        break;
      case "url-visits-chart":
        chart.dataProvider = this.plot_data.url_visits;
        break;
      case "blog-visits-chart":
        chart.dataProvider = this.plot_data.blog_visits;
        break;
      case "site-usage-chart":
        chart.dataProvider = this.plot_data.site_usage;
    };
    chart.validateData();
  }
};

$(document).ready( function() {

  let scan_file_channel = pusher.subscribe('my-channel');
  let timeframe = new Timeframe();
  let plot_data = new PlotData( timeframe );
  let charts = new Charts( plot_data );

  scan_file_channel.bind( 'reset', function( data ) {
    timeframe.reset();
    plot_data.reset();
    charts.reset();
  });

  scan_file_channel.bind( 'update-data', function( data ) {
    data.date = new Date(data.date);
    plot_data.update( data );
    timeframe.update( data.date_str );
  });

  scan_file_channel.bind( 'update-progress', function( data ) {
    $('#scan-progress').attr( 'style', 'width: '+data.progress+"%;" ).html( data.progress+"%" );
  });

  $('#input-file-form').submit( function(e) {
    $('.show-graph').collapse('hide');
    $('#notification-div').empty();
  });

  $('.graph').on('update-graph', function() {
    charts.update( this.id );
  });

  $('.refresh-graph').click( function(e) {
    e.preventDefault();
    $(this).closest('.card').find('.graph').trigger('update-graph');
  });

  $('.show-graph').on('show.bs.collapse', function(e) {
    $(this).find('.graph').trigger('update-graph');
  });

});
