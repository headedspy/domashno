require 'csv'

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
		CSV.foreach(csv_file_name) do |row|
			xi.push(rows.to_f)
			yi.push(row[0].to_f)
			rows += 1
		end
		sumyi = yi.inject(0, :+).to_f
		sumxi = xi.inject(0, :+).to_f
		xi2 = []
		xiyi = xi.zip(yi).map{|pair| pair.reduce(&:*)}
		sumxiyi = xiyi.inject(0, :+).to_f
		xi.each do |x|
			xi2.push(x**2)
		end
		sumxi2 = xi2.inject(0, :+)

		b1 = (rows.to_f*sumxiyi)/sumxi*sumyi - sumxi**2 + rows.to_f*sumxi2
		b0 = (sumxi/rows.to_f)*b1 + sumyi/rows.to_f


		str = b1.ceil(6).to_s + ", " + b0.ceil(6).to_s

		render plain: str
	end
end
