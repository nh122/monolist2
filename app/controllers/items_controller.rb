class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show, :haveusers, :wantusers]

  def new
    if params[:q]
      response = RakutenWebService::Ichiba::Item.search(
        keyword: params[:q],
        imageFlag: 1,
      )
      @items = response.first(20)
    end
  end

  def show
      @wantusers = @item.want_users
      @haveusers = @item.have_users
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

end
