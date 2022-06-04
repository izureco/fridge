class BoxesController < ApplicationController
  def index
    # paginationのために、page(params[:page])を追加
    @boxes = Box.includes(:user).order("created_at DESC").page(params[:page])
    @box_tag_list = BoxBoxtagRelation.all
  end

  def new
    @box_form = BoxForm.new
  end

  def create
    @box_form = BoxForm.new(box_form_params)
    tag_list = params[:box_form][:tag_name].split(",")
    if @box_form.valid?
      box_id = @box_form.save(tag_list)
      redirect_to new_box_food_path(box_id)
    else
      render :new
    end
  end

  def show
    @box = Box.find(params[:id])
    @box_tag_list = BoxBoxtagRelation.where(params[:id])
    @user = User.find(@box.user.id)
    @foods = @box.foods
  end

  def edit
    # @box : 編集対象のbox_idのfoodsをインスタンスに格納
    # @box.foodsに食材一覧が入っている
    # edit.html.erbでは、@box.foods + 追加用の空欄フォームを表示すればよい。
    @box = Box.find(params[:id])
    @user = User.find(@box.user.id)
    @form = Form::FoodCollection.new(foods: @box.foods)
    binding.pry
  end

  def update
    # @box : 編集対象のbox_idのfoodsをインスタンスに格納
    # @box.foodsに食材一覧が入っている
    # フォーム入力された値は、@formに入っている
    # @box.foodsの内容を、@formにupdateする
    @box = Box.find(params[:id])
    @user = User.find(@box.user.id)
    @form = Form::FoodCollection.new(update_params)
    if @form.update(@box) == true
      redirect_to root_path, notice: "商品を登録しました"
    else
      render :edit
    end
  end

  private

  def box_form_params
    params.require(:box_form).permit(
      :box_title,
      :description,
      :tag_name,
      :image
    ).merge(
      user_id: current_user.id
    )
  end

  def update_params
    params.require(:form_food_collection)
    .permit(foods_attributes: [:id, :availability, :food_title, :number_title, :purchase_date, :expiry_date, :price, :give_id, :category_id])
    .merge(
    box_id: params[:box_id]
  )
  end
end
