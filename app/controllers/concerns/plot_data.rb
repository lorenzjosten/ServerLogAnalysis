class PlotData

=begin
  This class provides methods to create arrays of data needed to plot the desired graphs
  site_visits = [{:access_time #hour, :visit #counts/hour)}*]
  server_response = [{:url #name, :respT #average_time(msec)}]
  url_visits = [{:url #name, :visits #counts}]
  blog_visits = [{:url #blog_url, :visits #counts}]
=end

  URL_FILTER_KEYS = ["%feed.atom", "%feed", "%wp-login.php", "/de", "/", "/en", "%/blog"] #blacklist
  STAT_FILTER_KEYS = ["200"] #whitelist

  #analysis model
  attr_reader :start_date, :end_date
  attr_reader :start_time, :end_time
  attr_reader :min_date, :max_date
  attr_reader :min_time, :max_time

  attr_reader :site_visits
  attr_reader :server_response
  attr_reader :url_visits
  attr_reader :blog_visits

  def initialize(access_data, timeframe)
    if set_time_range(access_data, timeframe)
      @access_data = url_filter(stat_filter(time_filter(access_data)))
      set_site_visits
      set_server_response
      set_blog_visits
      set_url_visits
    end
  end

  private

  def set_time_range(access_data, timeframe)
    if (dt_file = access_data.select('access_time')).any?
      @min_date = get_date(dt_file.first.access_time)
      @max_date = get_date(dt_file.last.access_time)
      if @min_date == @max_date
        @min_time = get_time(dt_file.first.access_time)
        @max_time = get_time(dt_file.last.access_time)
      end
      new_data = dt_file.where('updated_at > ?', timeframe.updated_at).any?
      @start_date = get_date((new_data || timeframe.start_date.nil?) ? dt_file.first.access_time : timeframe.start_date)
      @start_time = get_time((new_data || timeframe.start_time.nil?) ? dt_file.first.access_time : timeframe.start_time)
      @end_date = get_date((new_data || timeframe.end_date.nil?) ? dt_file.last.access_time : timeframe.end_date)
      @end_time = get_time((new_data || timeframe.end_time.nil?) ? dt_file.last.access_time : timeframe.end_time)
    end
    return !(@start_date && @start_time && @end_date && @end_time).nil?
  end

  def time_filter(access_data)
    access_data.where("access_time >= ? and access_time <= ?", parseDateTime(@start_date, @start_time), parseDateTime(@end_date, @end_time))
  end

  def url_filter(access_data)
    URL_FILTER_KEYS.each {|key| access_data = access_data.where("not url like ?", key)}
    access_data
  end

  def stat_filter(access_data)
    STAT_FILTER_KEYS.each {|key| access_data = access_data.where("stat like ?", key)}
    access_data
  end

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
    DateTime.parse(date+'T'+time)
  end

  def get_date(dt)
    dt.strftime("%Y-%m-%d")
  end

  def get_time(dt)
    dt.strftime("%H:%M")
  end

end
