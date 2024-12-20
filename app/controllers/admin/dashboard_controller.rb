class Admin::DashboardController < ApplicationController
  def index
    @users =User.all
    @posts =Post.all
    @reviews = Review.all
  end
end
