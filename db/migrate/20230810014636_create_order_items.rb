class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|

      t.integer :order_id, null: false #注文ID
      t.integer :item_id, null: false #商品ID
      t.integer :quantity, null: false #個数
      t.integer :price, null: false #単価（税込）
      t.integer :product_status, null: false, default: 0 #制作ステータス
      t.timestamps
    end
  end
end
