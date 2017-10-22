require 'csv'

class FiltersController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }

	def index
	end

	def create
		sum = 0
		csv_file = params[:csv_file]
		csv_file_path = csv_file.path		
		arr = Array.new
		CSV.foreach(csv_file_path) do |row|
			if row[2].to_i.odd?
				arr.push(row[1].to_f)
			end
		end

		arr.each do |i|
			sum += i
		end
		render plain: sum.ceil(2)
	end


end
