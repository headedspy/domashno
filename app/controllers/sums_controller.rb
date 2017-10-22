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
		f = true
		CSV.foreach(csv_file_path) do |row|
			if f == true
				f = false
				next
			end
			arr.push(row[0].to_f)
		end

		arr.each do |i|
			sum += i
		end
		render plain: sum.round(2)
	end
end
