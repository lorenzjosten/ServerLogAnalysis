class DataPoller {
  constructor(url, timeout) {
    this.url = url;
    this.timeout = timeout;
  }
  request() {
    if(this.url) {$.get(this.url);}
  }
  poll() {
    setTimeout(this.request.bind(this), this.timeout);
  }
};
var data_poller = new DataPoller(null, 0);
