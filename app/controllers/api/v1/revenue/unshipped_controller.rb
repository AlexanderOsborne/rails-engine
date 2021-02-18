class Api::V1::Revenue::UnshippedController < ApplicationController
  
  def index
    begin
      render json: PotentialRevenueSerializer.new(Merchant.unshipped_revenue(params[:quantity]))
    rescue
      render json: {"error" => {}}, status: 400
    end
  end
end