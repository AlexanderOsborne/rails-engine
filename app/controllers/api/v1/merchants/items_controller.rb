class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    require 'pry'; binding.pry
    merchant = Merchant.find(params[:merchant_id])
    begin
      render json: MerchantSerializer.new(Merchant.select_records(params))
    rescue
      render json: {"error" => {}}, status:404
    end
  end
end