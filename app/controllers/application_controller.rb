require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :json

  rescue_from ActionController::UnpermittedParameters do |e|
    render json: { message: e.message }, status: 422
  end
end
