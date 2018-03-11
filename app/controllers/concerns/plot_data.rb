class PlotData

=begin
This class provides methods to create arrays of data needed to plot the desired graphs
site_visits = [{:access_time #hour, :visit #counts/hour)}*]
server_response = [{:url #name, :respT #average_time(msec)}]
url_visits = [{:url #name, :visits #counts}]
blog_visits = [{:url #blog_url, :visits #counts}]
=end

  URL_FILTER_KEYS = ["%feed.atom", "%feed", "%wp-login.php", "/de", "/", "/en", "%/blog"]
  STAT_FILTER_KEYS = ["200"]

  attr_reader :site_visits
  attr_reader :server_response
  attr_reader :url_visits
  attr_reader :blog_visits

  def initialize(access_data, timeframe)
    @t_start = parseDateTime(timeframe.start_date, timeframe.start_time)
    @t_end = parseDateTime(timeframe.end_date, timeframe.end_time)
    @access_data = url_filter(stat_filter(time_filter(access_data)))
    set_site_visits
    set_server_response
    set_blog_visits
    set_url_visits
  end

  private

  def set_site_visits
    @site_visits = Array.new(24) {|i| {hour: '%02d:%02d' % [i,0], visits: @access_data.select {|d| d.access_time.hour == i}.count}}
  end

  def set_url_visits
    res = Array.new
    @access_data.select('url').distinct.each do |sel|
      res.push({url: sel.url, visits: @access_data.select {|d| d.url == sel.url}.count})
    end
    @url_visits = res.sort_by {|x| x[:visits]}.reverse
  end

  def set_blog_visits
    res = Array.new
    blogs = @access_data.where('url like ? and not url like ?', '%blog%', '%blog').distinct.each do |sel|
      visits = @access_data.select {|d| d.url == sel.url}.count
      res.push({url: sel.url, visits: visits})
    end
    @blog_visits = res.sort_by {|x| x[:visits]}.reverse
  end

  def set_server_response
    res = Array.new
    @access_data.select('url').distinct.each do |sel|
      response_times = Array.new
      @access_data.select {|d| d.url == sel.url}.each {|d| response_times.push(d.respT)}
      res.push({url: sel.url, respT: response_times.sum/response_times.size })
    end
    @server_response = res.sort_by {|x| x[:respT]}.reverse
  end

  def parseDateTime(date, time)
    DateTime.parse(date.strftime("%Y-%m-%d").concat('T'+time.strftime("%H:%M:00")))
  end

  def time_filter(access_data)
    access_data.where("access_time >= ? and access_time <= ?", @t_start, @t_end)
  end


  def url_filter(access_data)
    URL_FILTER_KEYS.each {|key| access_data = access_data.where("not url like ?", key)}
    access_data
  end

  def stat_filter(access_data)
    STAT_FILTER_KEYS.each {|key| access_data = access_data.where("stat like ?", key)}
    access_data
  end

end
