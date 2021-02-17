class Api::V1::Revenue::MerchantsController < ApplicationController
  
  def index
    if params[:quantity] != nil
      render json: MerchantRevenueSerializer.new(Merchant.top_revenue(params[:quantity]))
    else 
      render json: {"error" => {}}, status: 400
    end
  end
  
  def show
    begin
      merchant = Merchant.top_revenue(1).find(params[:id])
      render json: MerchantRevenueSerializer.new(merchant)
    rescue
      render json: {"error" => {}}, status: 404
    end
  end
end