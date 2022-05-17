class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @boxes = @user.boxes
    @box_tag_list = BoxBoxtagRelation.where(params[:id]).order("created_at DESC")
  end
end
