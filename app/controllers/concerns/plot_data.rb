class PlotData

=begin
This class provides methods to create arrays of data needed to plot the desired graphs
site_visits = [{:access_time, :visits}*]
=end

  attr_reader :access_data

  def initialize(access_data, timeframe)
    @t_start = timeframe.t_start
    @t_end = timeframe.t_end
    @access_data = access_data.where("access_time >= ? and access_time <= ? and stat = ? and not url like ?", @t_start, @t_end, 200, '%feed.atom%')
  end

  def url_visits
    res = Array.new
    @access_data.select('url').distinct.each do |sel|
      res.push({url: sel.url, visits: @access_data.select {|d| d.url == sel.url}.count})
    end
    return res
  end

  def site_visits
    return Array.new(24) {|i| {hour: i, visits: @access_data.select {|d| d.access_time.hour == i}.count}}
  end

  def server_response
    res = Array.new
    @access_data.select('url').distinct.each do |sel|
      response_times = Array.new
      @access_data.select {|d| d.url == sel.url}.each {|d| response_times.push(d.respT)}
      res.push({url: sel.url, respT: response_times.sum/response_times.size })
    end
    return res
  end

=begin  def blog_visits
    blog_name = Proc.new {|url| url.scan(Regexp.new('(?<=\/blog\/)[w{1,}\-*\/*]{1,}(?=$)'))[0]}
    res = Array.new
    blogs = @access_data.where('url like ?', '%blog%').distinct.each do |sel|
      blog_name.call(sel.url).uniq!.keep_if {|url| !url.nil? and url != "feed"}
    end
    return res
=end  end

end
