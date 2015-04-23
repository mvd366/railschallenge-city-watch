class EmergenciesController < ApplicationController
	def index
		render nothing: true
	end

	def new
		render json: { message: "page not found" }, status: 404
	end

	def create
		render nothing: true
	end

	def show
		render nothing: true
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
end
