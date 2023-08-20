class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items

  belongs_to :genre

  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true

  def item_status
    if is_sold_out == true
      "販売停止中"
    else
      "販売中"
    end
  end

  def with_tax_price
    (price * 1.08).floor
  end
end
