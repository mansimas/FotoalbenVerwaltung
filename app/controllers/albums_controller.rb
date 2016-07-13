class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy, :image]
  skip_before_filter :authenticate_user!, :only => [:index, :show, :image]
  helper_method :sort_column, :sort_direction

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album_comments = @album.comments.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /albums/new
  def new
    @album = Album.create!(:user_id => current_user.id)
    redirect_to edit_album_path(@album)
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_photo
    @album = Album.find_by(:id => params[:photo][:album_id])
    if(params[:file])
        @album.upload(params)
    end
    respond_to do |format|
        format.html { render :edit }
        format.json { head :no_content }
    end
  end

  def image
    @photo = Photo.find(params[:photo_id])
    @photo_comments = @photo.comments.paginate(:page => params[:page], :per_page => 10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :description, :user_id)
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def sort_column
      if !params[:sort] || params[:sort] == nil
        params[:sort] = 'albums.id'
      end
      params[:sort]
    end
end
