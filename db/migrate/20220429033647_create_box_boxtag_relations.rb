class CreateBoxBoxtagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :box_boxtag_relations do |t|
      t.references :box, foreign_key: true
      t.references :boxtag, foreign_key: true
      t.timestamps
    end
  end
end
