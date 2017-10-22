require 'csv'

class SumsController < ApplicationController
	protect_from_forgery unless: -> {request.format.json? }

	def index
	end

	def create
		sum = 0
		csv_file = params[:csv_file]
		csv_file_path = csv_file.path()
		arr = Array.new
		CSV.foreach(csv_file_path) do |row|
			arr.push(row[0].to_f)
		end

		arr.each do |i|
			sum += i
		end
		render plain: sum.round(2)
	end
end
