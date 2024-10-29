class CartitemsController < ApplicationController
  def new
    @cart_item = CartItem.new
    @product = Product.find(params[:product_id])
  end
  
  def create
    @cart_item = CartItem.new(product_id: params[:cart_item][:product_id],
                               cart_id: current_cart.id, 
                               qty: params[:cart_item][:qty])
    if @cart_item.save
      flash[:notice] = 'カートに商品を追加しました'
      redirect_to root_path
    else
      flash.now[:alert] = 'カートに商品を追加できませんでした。'
      @product = Product.find(params[:cart_item][:product_id]) # エラー時に商品情報を再取得
      render 'new', status: :unprocessable_entity
    end
  end
  
  def destroy
    CartItem.find(params[:id]).destroy
    flash[:notice] = "カートから削除しました。"
    redirect_to cart_path(current_cart.id)
  end
end
