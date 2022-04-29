class BoxesController < ApplicationController
  def index
    @boxes = Box.includes(:user).order("created_at DESC")
  end

  def new
    @box = Box.new
  end

  def create
    @box = Box.new(box_params)
    binding.pry
    if @box.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def box_params
    params.require(:box).permit(
      :box_title,
      :description,
      :image,
      :tag_list
    ).merge(
      user_id: current_user.id,
    )
  end
end
