class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.references :genre, null: false, foreign_key: true #ジャンルID
      t.string :name, null: false #商品名
      t.text :introduction, null: false #商品説明
      t.integer :price, null: false #単価（税抜）
      t.boolean :is_sold_out, default: false, null: false #販売ステータス
      t.timestamps
    end
  end
end
