class RespondersController < ApplicationController
	def index
		@responders = Responder.all
	end

	def new
		render json: { message: "page not found" }, status: 404
	end

	def create
		Responder.create(params[:responder])
		render nothing: true
	end

	def show
		@responder = Responder.find_by name: params[:name]
	end

	def edit
		render json: { message: "page not found" }, status: 404
	end

	def update
		render nothing: true
	end

	def destroy
		render json: { message: "page not found" }, status: 404
	end

	private
    def responder_params
      params.require(:responder).permit(:type, :name, :capacity, :on_duty)
    end
end
