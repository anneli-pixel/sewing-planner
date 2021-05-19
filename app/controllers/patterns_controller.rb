class PatternsController < ApplicationController
  before_action :save_referrer, except: [:create, :update]

  def index
    if params[:fabric_type_filter].present?
      @patterns = policy_scope(Pattern).order(garment_category_id: :asc, title: :asc).filter_by_fabric_type("#{params[:fabric_type_filter]}")
    elsif params[:garment_category_filter].present?
      @patterns = policy_scope(Pattern).order(fabric_type: :asc, title: :asc).filter_by_garment_category("#{params[:garment_category_filter]}")
    elsif params[:query].present?
      @patterns = policy_scope(Pattern).order(garment_category_id: :asc, fabric_type: :asc, title: :asc).search_by_title_and_designer("#{params[:query]}")
    else
      @patterns = policy_scope(Pattern).order(garment_category_id: :asc, fabric_type: :asc, title: :asc)
    end
  end

  def new
    @pattern = Pattern.new
    authorize @pattern
  end

  def create
    cleaned_params = clean(pattern_params)
    @pattern = Pattern.new(cleaned_params)
    authorize @pattern
    @pattern.user = current_user

    if @pattern.save
      redirect_to patterns_path+"##{@pattern.id.to_s}", notice: "Pattern successfully created."
    else
      render :new
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
    authorize @pattern

    respond_to do |format|
       format.js
     end
  end

  def edit
    @pattern = Pattern.find(params[:id])
    authorize @pattern
  end

  def update
    @pattern = Pattern.find(params[:id])
    cleaned_params = clean(pattern_params)
    @pattern.assign_attributes(cleaned_params) # need to validate the changes first (before saving to the database) otherwise the photo gets deleted/updated even if the form validation fails.

    if @pattern.valid?
      @pattern.restore_attributes

      attached_photo_in_database = ActiveStorage::Attachment.find_by(record_id: @pattern.id, record_type: @pattern.class.name)

      if attached_photo_in_database && cleaned_params[:photo] || attached_photo_in_database && cleaned_params[:delete_photo]
        attached_photo_in_database.purge # purge the old attachment (will also delete the blob and the image on cloudinary)
      end
    end

    if @pattern.update(cleaned_params.except(:delete_photo))
      redirect_to patterns_path(anchor: @pattern.id), notice: "Pattern succesfully edited."
    else
      # TODO reload the photo from the database so it's up-to-date (how?) which would replace the photo_key_from_database and photo_in_database? methods I use in the pattern form view

      render :edit
      #redirect_to patterns_path(anchor: @pattern.id), notice: "Something went wrong. Please try again."
    end
    authorize @pattern
  end

  def destroy
    @pattern = Pattern.find(params[:id])
    project_count = @pattern.projects.count
    shopping_item_count = @pattern.shopping_items.count
    authorize @pattern
    if @pattern.destroy
      unless !@pattern.photo.attached?
        @pattern.photo.purge
      end
      redirect_to patterns_path, notice: pattern_delete_success_message(project_count, shopping_item_count)
    else
      redirect_to patterns_path, notice: "Something went wrong. Please try again."
    end
  end

  private

  def pattern_params
    params.require(:pattern).permit(:title, :designer, :fabric_type, :pattern_url, :garment_category_id, :notes, :photo, :delete_photo, :purchased)
  end

  def clean(params)
    if params[:photo] && params[:delete_photo]
      cleaned_params = params.dup
      cleaned_params.delete :photo
      cleaned_params.delete :delete_photo
    else
      cleaned_params = params
    end
    cleaned_params
  end

  def pattern_delete_success_message(project_count, shopping_item_count)
    if project_count == 0
        "Pattern deleted."
    else
      "Pattern, #{project_count} #{'project'.pluralize(project_count)} and #{shopping_item_count} #{'shopping item'.pluralize(shopping_item_count)} deleted."
    end
  end
end
