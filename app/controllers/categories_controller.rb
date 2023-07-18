class CategoriesController < ApplicationController

	def index
		categories = Category.all
		if categories.present?
			render json: categories , status: :ok
		else
			render json: {message: "Sorry No any categories available "}, status: :unprocessable_entity
		end
	end
end
