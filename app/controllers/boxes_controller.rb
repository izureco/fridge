class BoxesController < ApplicationController
  def index
    @boxes = Box.includes(:user).order("created_at DESC")
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
    @foods = @box.foods
  end

  def category
    binding.pry
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
