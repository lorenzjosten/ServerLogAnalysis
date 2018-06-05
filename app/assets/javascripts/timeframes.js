var datetime_form = {
  set_min_date(d) {
    $('#start_date').attr('min', d);
  },
  set_max_date(d) {
    $('#end_date').attr('max', d);
  },
  set_start_date(d) {
    $('#start_date').val(d);
  },
  set_end_date(d) {
    $('#end_date').val(d);
  }
};

class TimeframePoller {
  constructor(url, timeout) {
    this.url = url;
    this.timeout = timeout;
  }
  request() {
    if(this.url) {$.get(this.url);};
  }
  poll() {
    setTimeout(this.request.bind(this), this.timeout);
  }
}

var timeframe_poller = new TimeframePoller(null, 0);
