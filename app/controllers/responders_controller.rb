class RespondersController < ApplicationController
  def index
    render 'capacity' if params[:show] == 'capacity'
    @responders = Responder.all
  end

  def new
    render json: { message: 'page not found' }, status: 404
  end

  def create
    @responder = Responder.new create_responder_params
    if @responder.valid?
      @responder.save
      render 'show', status: 201
    else
      render json: { message: @responder.errors.messages }, status: 422
    end
  end

  def show
    @responder = Responder.find_by name: params[:name]
    render nothing: true, status: 404 if @responder.blank?
  end

  def edit
    render json: { message: 'page not found' }, status: 404
  end

  def update
    @responder = Responder.find_by name: params[:name]
    if @responder.blank?
      render nothing: true
    else
      @responder.update_attributes update_responder_params
      render 'show', status: 201
    end
  end

  def destroy
    render json: { message: 'page not found' }, status: 404
  end

  private

  def create_responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def update_responder_params
    params.require(:responder).permit(:on_duty)
  end
end
