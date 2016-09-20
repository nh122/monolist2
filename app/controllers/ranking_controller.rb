class RankingController < ApplicationController
  before_action :logged_in_user

  def have
    array = Have.group(:item_id).order('count_id desc').limit(10).count(:id).keys
    @ranking = Item.find(array).index_by(&:id).slice(*array).values
  end

  def want
    array = Want.group(:item_id).order('count_id desc').limit(10).count(:id).keys
    @ranking = Item.find(array).index_by(&:id).slice(*array).values
  end
end
