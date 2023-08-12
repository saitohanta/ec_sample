class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id, null: false #顧客ID
      t.integer :status, null: false, default: 0 #注文ステータス
      t.string :ship_name, null: false #配送先氏名
      t.string :ship_postcode, null: false #郵便番号（配送先）
      t.string :ship_address, null: false #住所（配送先）
      t.integer :shipping_fee, null: false #送料
      t.integer :payment_method, null: false, default: 0 #支払い方法
      t.integer :total_price, null: false #請求額合計
      t.timestamps
    end
  end
end
