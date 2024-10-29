class CartsController < ApplicationController
  def show
    @cartitems = CartItem.where(cart_id: current_cart.id)
  end
end
