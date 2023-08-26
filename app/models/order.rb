class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  belongs_to :customer

  #注文ステータス
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }
  #支払方法
  enum payment_method: { credit_card: 0, transfer: 1 }

end
