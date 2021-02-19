class Api::V1::Revenue::MerchantUnshippedController < ApplicationController
  
  def index
    begin
      require 'pry'; binding.pry
    rescue
      render json: {"error" => {}}, status: 400
    end
  end
end

# begin
#   render json: PotentialRevenueSerializer.new(Invoice.unshipped_invoice_revenue(params[:quantity]))
# rescue
#   render json: {"error" => {}}, status: 400
# end