require 'csv'

class SumsController < ApplicationController
	protect_from_forgery unless: -> {request.format.json? }

	def index
	end

	def create
		sum = 0
		csv_file = params[:csv_file]
		csv_file_path = csv_file.path

		CSV.foreach(csv_file_path) do |row|
			sum += row[0].to_f
		end

		render plain: sum.ceil(2)
	end
end
