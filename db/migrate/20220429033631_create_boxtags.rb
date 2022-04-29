class CreateBoxtags < ActiveRecord::Migration[6.0]
  def change
    create_table :boxtags do |t|
      t.string      :tag_name, null:false, uniqueness: true
      t.timestamps
    end
  end
end
