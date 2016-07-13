class Album < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	belongs_to :user
  has_many :photos, :dependent => :destroy
	has_many :comments, :dependent => :destroy

	def upload(params)
      random_nr = rand(1000..9999)
      image_name = random_nr.to_s + params[:file].original_filename
      write_file(image_name, params)
      photo = Photo.create!(:album_id => self.id)
      photo.photo_file_name = image_name
      photo.photo_file_size = number_to_human_size(params[:file].size, :precision => 5, :separator => '.')
      photo.photo_content_type = params[:file].content_type
      photo.save!
    end

    def write_file(image_name, params)
    	FileUtils.mkdir_p('public/assets/images') unless File.directory?('public/assets/images')
    	File.open(Rails.root.join('public', 'assets/images', image_name), 'wb') do |file|
        	file.write(params[:file].read)
      end
	end
end
