module ErrorModule
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ErrorModule::NoDateError do |e|
        render_error_msg(e.sanitize)
      end
      rescue_from ErrorModule::NoFileError do |e|
        render_error_msg(e.sanitize)
      end
      rescue_from ErrorModule::DataError do |e|
        render_error_msg(e.sanitize)
      end
      rescue_from ErrorModule::FileError do |e|
        render_error_msg(e.sanitize)
      end
    end

    def render_error_msg( msg )
      respond_to do |format|
        format.js { render js: "$('#show-error-msg').html('#{msg}').trigger('show-error');" }
      end
    end
  end
end
