class Api::V1::ItemsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    begin
      render json: ItemSerializer.new(Item.select_records(params))
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def create
    item = Item.create!(item_params)
    begin
      render json: ItemSerializer.new(item)
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  # def update
  #   item = Item.find(params[:id])
  #   item.update!(item_params)
  #   render json: ItemSerializer.format_item(item)
  # end

  def destroy
    Item.find(params[:id]).destroy
  end

  # def find_all
  #   items = if params[:name].present? && !(params[:min_price] || params[:max_price])
  #             Item.find_all_by_text(params[:name])
  #           elsif !params[:name]
  #             Item.find_all_by_price(params[:min_price], params[:max_price])
  #           elsif params[:name].blank?
  #             []
  #           end
  #   render json: ItemSerializer.format_items(items)
  # end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end