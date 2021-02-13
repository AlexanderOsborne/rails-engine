class Api::V1::MerchantsController < ApplicationController

  def index
    begin
      render json: MerchantSerializer.new(Merchant.all)
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