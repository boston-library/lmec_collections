class GalleriesController < CatalogController
  # Give Galleries access to the CatalogController configuration
  # Needed to be able to fetch documents from the Solr index
  include Blacklight::Configurable
  include Blacklight::SearchContext

  include GalleryFilters

  copy_blacklight_config_from(CatalogController)

  before_action :set_gallery, only: [ :edit, :update, :destroy, :add_item, :remove_item ]
  before_action :set_galleries, only: [ :index, :set_galleries_modal ]

  # GET /galleries
  # GET /galleries.json
  def index
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    # Galleries need special 404 handling. A guest (not logged-in)
    # user has an anonymous user account with an associated
    # gallery. If they log in while viewing detail page of that
    # gallery, the after-login redirect back to the show page will
    # fail with a 404, since their session has changed user accounts.
    set_gallery
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.json { render :index }
    end
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user_id = current_or_guest_user.id

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: "Favorites list was successfully created." }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: "Favorites list was successfully updated." }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: "Favorites list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /galleries/1/add-item.json
  def add_item
    @item_id = params[:item_id]
    @type = params[:type]
    @gallery.add_item(@type, @item_id)
    @gallery.save
    respond_to do |format|
      format.js { }
    end
  end

  # POST /galleries/1/remove-item.json
  def remove_item
    @item_id = params[:item_id]
    @type = params[:type]
    @gallery.remove_item(@type, @item_id)
    @gallery.save
    respond_to do |format|
      format.js { }
    end
  end

  def set_galleries_modal
    @item_id = params[:item_id]
    @type = params[:type]
    respond_to do |format|
      format.html { render partial: "set_galleries_modal" }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.owned_by(current_or_guest_user).find(params[:id])
    @document_list = search_service.fetch(@gallery.repo_objects, rows: GALLERY_ITEM_LIMIT)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gallery_params
    params.fetch(:gallery, {}).permit(:name, repo_objects: [], curriculum_materials: [])
  end
end
