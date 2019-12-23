class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end
  def new
  end

  def create
    Tweet.create(king_params)
  end

  private 
  def king_params
    params.permit(:name,:image,:text)
  end
end
