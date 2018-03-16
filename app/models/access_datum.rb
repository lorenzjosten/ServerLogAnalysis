class AccessDatum < ApplicationRecord
  belongs_to :input_file

  URL_FILTER_KEYS = ["%feed.atom", "%feed", "%wp-login.php", "/de", "/", "/en", "%/blog"] #blacklist urls
  STAT_FILTER_KEYS = ["200"] #whitelist server response stats

  scope :url_filtered, -> { URL_FILTER_KEYS.inject(all) {|filtered, url| filtered.merge(url_filter(url))} }
  scope :stat_filtered, -> { STAT_FILTER_KEYS.inject(none) {|filtered, stat| filtered.or(stat_filter(stat))} }

  scope :time_filter, -> (t1, t2) { where("access_time >= ? and access_time <= ?", t1, t2) }
  scope :url_filter, -> (url) { where("not url like ?", url) }
  scope :stat_filter, -> (stat) { where("stat like ?", stat) }

  scope :start_time, -> { order('access_time asc').first.access_time }
  scope :end_time, -> { order('access_time asc').last.access_time }
  scope :urls, -> { select('url').distinct }
  scope :blogs, -> { where('url like ?', '%blog%') }
  scope :url_visits, -> (url) { select {|d| d.url == url }.count }
  scope :url_visits_per_hour, -> (url, hour) { where('url like ?', url).select {|d| d.access_time.hour == hour}.count }
end
