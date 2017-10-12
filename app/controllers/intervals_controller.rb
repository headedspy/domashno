require 'csv'

class IntervalsController < ApplicationController
	#protect_from_forgery unless: -> { request.format.json? }
	protect_from_forgery with: :null_session	
	def index
	end

	def create
		sum = 0
		nsum = 0
		
		crow = 0
		
		a = 0	
	
		csv_file = params[:csv_file]
		csv_file_path = csv_file.path

		arr_of_arrs = CSV.read(csv_file_path)
		
		CSV.foreach(csv_file_path) do |row|
			30.times do |i|
				a = arr_of_arrs[crow + i][0]
				nsum += a.to_i
			end

			sum = nsum if nsum > sum
			crow += 1
			if crow == arr_of_arrs.length - 30
				break
			end
		end
		render plain: sum.ceil(2)
	end

end
