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
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
    rescue
    render json: {"error" => {}}, status:404
    end
  end

end