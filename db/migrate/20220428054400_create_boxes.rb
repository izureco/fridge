class CreateBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :boxes do |t|
      t.string      :box_title,       null: false
      t.text        :description,     null: false
      t.references  :user,            foreign_key: true
      t.timestamps
    end
  end
end
