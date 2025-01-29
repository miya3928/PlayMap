class Admin::TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
   @tag = Tag.new(tag_params)
   if @tag.save
    redirect_to admin_tags_path, notice: "タグを作成しました。"
   else
    @tags = Tag.all
    flash.now[:alert] = "タグの作成に失敗しました。"
    render :index
   end 
  end

  def edit
    @tag
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path,notice: "タグを更新しました。"
    else
      flash.now[:alert] = "タグの更新に失敗しました。"
      render :edit 
    end     
  end

  def destroy
    if @tag.destroy
      redirect_to admin_tags_path, notice:"タグを削除しました。"
    else
      flash.now[:alert] = "タグの削除に失敗しました。"
      render :index
    end    
  end  

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end
  
  def tag_params
    params.require(:tag).permit(:name)
  end
 end 

