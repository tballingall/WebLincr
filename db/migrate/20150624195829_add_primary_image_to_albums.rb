class AddPrimaryImageToAlbums < ActiveRecord::Migration
  def change
    # add_column :albums, :primary_image, :integer
    add_reference :albums, :picture, index: true, foreign_key: true
  end
end
