class AddAlbumToComments < ActiveRecord::Migration
  def change
    add_column :comments, :album_id, :integer
  end
end
