class EmergenciesController < ApplicationController
  def index
    @emergencies = Emergency.all
  end

  def new
    render json: { message: 'page not found' }, status: 404
  end

  def create
    @emergency = Emergency.new new_emergency_params
    if @emergency.valid?
      @emergency.save
      Responder.dispatch(@emergency)
      # TODO: Dispatch responders
      render 'show', status: 201
    else
      render json: { message: @emergency.errors.messages }, status: 422
    end
  end

  def show
    @emergency = Emergency.find_by code: params[:code]
    render nothing: true, status: 404 if @emergency.blank?
  end

  def edit
    render json: { message: 'page not found' }, status: 404
  end

  def update
    @emergency = Emergency.find_by code: params[:code]
    if @emergency.blank?
      render nothing: true
    else
      @emergency.update_attributes update_emergency_params
      Responder.clear(@emergency) if @emergency.resolved_at.present?
      render 'show', status: 201
    end
  end

  def destroy
    render json: { message: 'page not found' }, status: 404
  end

  private

  def new_emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity, :full_response)
  end

  def update_emergency_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :full_response, :resolved_at)
  end
end
