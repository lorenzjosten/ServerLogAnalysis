class AccessDatum < ApplicationRecord
  belongs_to :input_file
  validates_presence_of [:respT, :url, :request, :access_time, :stat, :input_file_id], on: :create

  URL_FILTER_KEYS = ["%feed.atom", "%feed", "%wp-login.php", "/de", "/", "/en", "%/blog"] # blacklist urls
  STAT_FILTER_KEYS = ["200"] # whitelist server response stats

  scope :url_filtered, -> { URL_FILTER_KEYS.inject(all) {|filtered, url| filtered.merge(url_filter(url))} }
  scope :url_filter, -> (url) { where("not url like ?", url) }
  scope :stat_filtered, -> { STAT_FILTER_KEYS.inject(none) {|filtered, stat| filtered.or(stat_filter(stat))} }
  scope :stat_filter, -> (stat) { where("stat like ?", stat) }
  scope :time_filter, -> (t1, t2) { where("access_time >= ? and access_time <= ?", t1, t2) }
  scope :access_times_asc, -> { order('access_time asc').pluck("access_time") }
  scope :first_dt, -> { access_times_asc.first }
  scope :last_dt, -> { access_times_asc.last }
  scope :blogs, -> { where('url like ? and url not like ?', '%blog%', '%blog') }
  scope :urls_unique, -> { select('url').distinct }
  scope :url_entries, -> (url) { select {|d| d.url == url} }
  scope :url_entries_count, -> (url) { url_entries(url).count }
  scope :response_per_url, -> (url) { url_entries(url).inject(0) {|sum, d| sum + d.respT}/url_entries_count(url) }
  scope :site_visits_per_hour, -> (hour) { select {|d| d.access_time.hour == hour}.count }
  scope :server_performance, -> { urls_unique.inject(Array.new) {|arr, u| arr.push({url: u.url, respT: response_per_url(u.url)})} }
  scope :url_visits, -> { urls_unique.inject(Array.new) {|arr, u| arr.push({url: u.url, visits: url_entries_count(u.url)})} }
  scope :blog_visits, -> { urls_unique.blogs.inject(Array.new) {|arr, u| arr.push({url: u.url, visits: url_entries_count(u.url)})} }
  scope :site_usage, -> { Array.new(24) {|i| {hour: '%02d:%02d' % [i,0], visits: site_visits_per_hour(i)}} }

  def self.plot_data(start_dt = first_dt, end_dt = last_dt)
    plot_data = stat_filtered.url_filtered
    (start_dt && end_dt) ? plot_data.time_filter(start_dt, end_dt) : plot_data
  end
  def self.server_performance_data(start_dt = first_dt, end_dt = last_dt)
    plot_data(start_dt, end_dt).server_performance.sort {|x,y| y[:respT] <=> x[:respT]}
  end
  def self.url_visits_data(start_dt = first_dt, end_dt = last_dt)
    plot_data(start_dt, end_dt).url_visits.sort {|x,y| y[:visits] <=> x[:visits]}
  end
  def self.blog_visits_data(start_dt = first_dt, end_dt = last_dt)
    plot_data(start_dt, end_dt).blog_visits.sort {|x,y| y[:visits] <=> x[:visits]}
  end
  def self.site_usage_data(start_dt = first_dt, end_dt = last_dt)
    plot_data(start_dt, end_dt).site_usage
  end
end
