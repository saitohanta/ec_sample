class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order('id DESC').limit(8)
  end

  def about
  end
end
