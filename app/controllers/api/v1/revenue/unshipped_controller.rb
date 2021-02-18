class Api::V1::Revenue::UnshippedController < ApplicationController
  
  def index
    begin
      render json: PotentialRevenueSerializer.new(Invoice.unshipped_invoice_revenue(params[:quantity]))
    rescue
      render json: {"error" => {}}, status: 400
    end
  end
end