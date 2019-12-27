class TweetsController < ApplicationController
  before_action :direct, except: [:index,:show]
  def index
    @tweets = Tweet.all.includes(:user).order("id DESC").page(params[:page]).per(5)
  end
  def new
  end

  def create
    Tweet.create(image: king_params[:image], text: king_params[:text], user_id: current_user.id)
  end
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(king_params)
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
    @comment = @tweet.comments.includes(:user)
  end

  private 
  def king_params
    params.permit(:image, :text)
  end
  def direct
    redirect_to action: :index unless user_signed_in?
  end
end
