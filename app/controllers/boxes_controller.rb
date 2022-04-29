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
      @box_form.save(tag_list)
      redirect_to root_path
    else
      render :new
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
end
