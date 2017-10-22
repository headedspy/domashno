require 'csv'

def number?(object)
	true if Float(object) rescue false
end

class LinRegressionsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	def index
	end

	def create
		csv_file = params[:csv_file]
		csv_file_name = csv_file.path
		rows = 1
		xi = []
		yi = []
		f = true
		CSV.foreach(csv_file_name) do |row|
			if f == true
				f = false
				next
			end
			if number?(row[0])
				xi.push(rows.to_f)
				yi.push(row[0].to_f)
				rows += 1
			end
		end
		sumyi = yi.inject(0, :+).to_f
		sumxi = xi.inject(0, :+).to_f
		xi2 = []
		xiyi = xi.zip(yi).map{|x, y| x*y}
		sumxiyi = xiyi.inject(0, :+).to_f
		xi.each do |x|
			xi2.push(x**2)
		end
		sumxi2 = xi2.inject(0, :+)

		b1 = (rows*sumxiyi - sumxi*sumyi)/(rows*sumxi2 - (sumxi)**2)
		b0 = (sumyi - sumxi*b1)/rows


		str = b1.round(6).to_s + ", " + b0.round(6).to_s

		render plain: str
	end
end
