module AccessDataHelper
  def server_performance_data
    @access_data.server_performance_data(@start_dt, @end_dt).to_json.html_safe
  end
  def url_visits_data
    @access_data.url_visits_data(@start_dt, @end_dt).to_json.html_safe
  end
  def site_usage_data
    @access_data.site_usage_data(@start_dt, @end_dt).to_json.html_safe
  end
  def blog_visits_data
    @access_data.blog_visits_data(@start_dt, @end_dt).to_json.html_safe
  end
end
