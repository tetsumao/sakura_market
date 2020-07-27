module ToastrErrorsOutputter
  extend ActiveSupport::Concern

  def toastr_error_message(msg)
    self.errors.full_messages.each do |m|
      msg += '</br>'
      msg += m
    end
    msg
  end
end
