class OwnershipsController < ApplicationController
  before_action :logged_in_user



  def create

    logger.debug "-create-----------------------------------"
    logger.debug "params[:item_code]:-----------------------------"
    logger.debug params[:item_code]

    if params[:item_code]
      @item = Item.find_or_initialize_by(item_code: params[:item_code])
    else
      @item = Item.find(params[:item_id])
    end
    logger.debug "@item.id:--------------------------"
    logger.debug @item.id
    logger.debug "@item.new_record?:--------------------------"
    logger.debug @item.new_record?
  
    # itemsテーブルに存在しない場合は楽天のデータを登録する。
    if @item.new_record?
      # TODO 商品情報の取得 RakutenWebService::Ichiba::Item.search を用いてください
      response = RakutenWebService::Ichiba::Item.search(
        itemCode: params[:item_code]
      )
      items = response.first(1)

      logger.debug "レスポンス取るとこまで:--------------------------"
      item                  = items.first
      @item.title           = item['itemName']
      @item.small_image     = item['smallImageUrls'].first['imageUrl']
      @item.medium_image    = item['mediumImageUrls'].first['imageUrl']
      @item.large_image     = item['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
      @item.detail_page_url = item['itemUrl']
      @item.item_code       = params[:item_code]
      @item.save!
    end

logger.debug "itemテーブル確認まで:--------------------------"
    # TODO ユーザにwant or haveを設定する
    # params[:type]の値にHaveボタンが押された時には「Have」,
    # Wantボタンが押された時には「Want」が設定されています。
    
    if params[:type] == 'Have'
      current_user.have(@item)
    else
      current_user.want(@item)
    end
logger.debug "have/want実行まで:--------------------------"
  end

  def destroy
logger.debug "ownershipsController#destroy実行:--------------------------"
    @item = Item.find(params[:id])
logger.debug "@item.item_code:--------------------------"
logger.debug @item.item_code

    # TODO 紐付けの解除。 
    # params[:type]の値にHave itボタンが押された時には「Have」,
    # Want itボタンが押された時には「Want」が設定されています。
    if params[:type] == 'Have'
      current_user.unhave(@item)
    else
      current_user.unwant(@item)
    end
  end

end
