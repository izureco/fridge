class FoodsController < ApplicationController
  def new
    # @form = Form::FoodCollection.new(params[:box_id])
  # cocoon gem導入
    # @box = Box.find(params[:box_id])
    # @food = @box.foods.build
  # 元の記述
    @box = Box.find(params[:box_id])
    @form = Form::FoodCollection.new
  end

  def create
  # cocoon gem導入
    # binding.pry
    # @food = Food.new(food_params)
    # if @food.save
    #   redirect_to root_path, notice: "商品を登録しました"
    # else
    #   render :new
    # end

  #  元の記述
    @form = Form::FoodCollection.new(food_collection_params)
    if @form.save == true
      redirect_to root_path, notice: "商品を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  # cocoon gem
  # def food_params
  #   params.require(:food)
  #   .permit(
  #     :availability, :food_title, :number_title, :purchase_date, :expiry_date, :price, :give_id, :category_id)
  #   .merge(
  #   box_id: params[:box_id]
  # )
  # end

  def food_collection_params
  # 元の記述
    params.require(:form_food_collection)
    .permit(foods_attributes: [:availability, :food_title, :number_title, :purchase_date, :expiry_date, :price, :give_id, :category_id])
    .merge(
    box_id: params[:box_id]
  )
  end
end