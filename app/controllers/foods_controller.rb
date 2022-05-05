class FoodsController < ApplicationController
  def new
    # @form = Form::FoodCollection.new(params[:box_id])
    @form = Form::FoodCollection.new
  end

  def create
    binding.pry
    data = params.require('category')
    @form = Form::FoodCollection.new(food_collection_params)
    if @form.save == true
      redirect_to root_path, notice: "商品を登録しました"
    else
      # @form.saveに失敗した時点で,@form.errorsに何かしら入っている?
      render :new
    end
  end

  private

  def food_collection_params
    params.require(:form_food_collection)
    .permit(foods_attributes: [:availability, :food_title, :number_title, :purchase_date, :expiry_date, :price, :give_id, :category_id])
    .merge(
    box_id: params[:box_id]
  )
  end
end