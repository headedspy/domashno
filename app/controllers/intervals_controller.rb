require 'csv'

class IntervalsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	def index
	end

	def create
		sum = 0
		nsum = 0 
		cel = 1
		csv_file = params[:csv_file]
		csv_file_path = csv_file.path
		arr_of_arrs = CSV.read(csv_file_path)
		values = Array.new

		CSV.foreach(csv_file_path) do |row|
			values.push(row[0].to_f)
		end

		for i in 0...values.length-29
			nsum = 0
			30.times do |ii|
				nsum += values[i+ii]
			end
			if nsum > sum
				sum = nsum
			end
		end
		render plain: sum.round(2)
	end

end
