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
      # 今作ったboxのIDを入れたい
      # paramsにidが格納されてないので、Not found errorになる。
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
end
