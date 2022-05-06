class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.boolean  :availability
      t.string   :food_title,    null: false
      t.integer  :number_title,  nill: false
      t.date     :purchase_date, null: false
      t.date     :expiry_date,   null: false
      t.integer  :price,         null: false
      t.integer  :give_id
      t.integer  :category_id,   null: false
      t.references :box,         foreign_key: true
      t.timestamps
    end
  end
end
