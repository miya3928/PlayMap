class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmarkable = find_bookmarkable
    @bookmark = @bookmarkable.bookmarks.new(user: current_user)
  
    respond_to do |format|
      if @bookmark.save
        flash.now[:notice] = 'ブックマークを追加しました。'
        format.html { redirect_to @bookmarkable, notice: 'ブックマークを追加しました。' }
        format.js
      else
        flash[:alert] = 'ブックマークの追加に失敗しました。'
        format.html { redirect_to @bookmarkable, alert: 'ブックマークの追加に失敗しました。' }
        format.js
      end
    end
  end

  def destroy
    @bookmarkable = find_bookmarkable
    @bookmark = current_user.bookmarks.find_by(bookmarkable: @bookmarkable)
  
    respond_to do |format|
      if @bookmark&.destroy
        flash.now[:alert]= 'ブックマークを削除しました。'
        format.html { redirect_to @bookmarkable, notice: 'ブックマークを削除しました。' }
        format.js
      else
        flash[:alert] = 'ブックマークの削除に失敗しました。'
        format.html { redirect_to @bookmarkable, alert: 'ブックマークの削除に失敗しました。' }
        format.js
      end
    end
  end
  
  private

  def find_bookmarkable
    params.each do |key, value|
      if key.to_s =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    raise ActiveRecord::RecordNotFound, "Bookmarkable not found"
  end

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_type, :bookmarkable_id)
  end
end