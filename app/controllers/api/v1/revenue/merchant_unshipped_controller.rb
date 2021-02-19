class Api::V1::Revenue::MerchantUnshippedController < ApplicationController
  
  def index
    begin
      render json: MerchantUnshippedSerializer.new(Merchant.unshipped_revenue(params[:quantity]))
    rescue
      render json: {"error" => {}}, status: 400
    end
  end
end
