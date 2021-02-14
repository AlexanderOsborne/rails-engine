class Api::V1::MerchantsController < ApplicationController

  def index
    begin
      render json: MerchantSerializer.new(Merchant.select_records(params))
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def show
    begin
      if params[:item_id]
        render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
      else
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
      end
    rescue
      render json: {"error" => {}}, status:404
    end
  end

end