class ProgressPoller {
  constructor(url, div, timeout) {
    this.url = url;
    this.timeout = timeout;
  }
  request() {
    $.get(this.url);
  }
  poll() {
    if(this.url && progress_bar.get_progress() < 100) { setTimeout(this.request.bind(this), this.timeout); };
  }
}

var progress_bar = {
  set_progress(progress) {
    var _progress = progress.toString();
    $('#scan-progress').attr('style', 'width: '+_progress+'%').data('progress', progress).html(_progress+'%');
  },
  get_progress() {
    return $('#scan-progress').data('progress');
  }
};

var progress_poller = new ProgressPoller(null, 300);
