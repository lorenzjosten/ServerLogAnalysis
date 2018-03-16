class AccessDataController < ApplicationController

  def index
    @access_data = AccessDatum.all
  end

  def show
    @access_data = AccessDataum.url_filtered.stat_filtered.time_filtered(params[t1], params[t2])
  end

end
