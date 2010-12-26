class IndexController < ApplicationController
  def index
  end

  def oauth
    redirect_to :index
  end

  def callback
    redirect_to :index
  end

end
