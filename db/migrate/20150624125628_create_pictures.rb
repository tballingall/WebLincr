class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.references :album, index: true, foreign_key: true
      t.integer :year
      t.string :color
      t.text :description
      t.string :image_uid
      t.string :image_name
    end
  end
end
