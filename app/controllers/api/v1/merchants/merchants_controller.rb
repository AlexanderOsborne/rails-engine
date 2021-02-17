class Api::V1::Merchants::MerchantsController < ApplicationController

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

  def find
      merchant = Merchant.search(params[:name]).first if params[:name]
      if merchant.nil?
        render json: {"data" => {}}, status:200
      else
      render json: MerchantSerializer.new(merchant)
      end
  end
end