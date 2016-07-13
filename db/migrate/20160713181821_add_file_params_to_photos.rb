class AddFileParamsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_file_name, :text
    add_column :photos, :photo_file_size, :decimal
    add_column :photos, :photo_content_type, :string
  end
end
