module UrlHelper

  def dynamic_cancel_path(session)
    if session[:referrer].nil?
      projects_path
    elsif params[:pattern_id]
      session[:referrer]+"##{params[:pattern_id]}"
    elsif params[:id] && !session[:referrer].end_with?(params[:id])
      session[:referrer]+"##{params[:id]}"
    else
      session[:referrer]
    end
  end


  def filter_name
    unless request.query_parameters.empty?
      filter_key = request.query_parameters.keys.first
      request.query_parameters[filter_key]
    end
  end

  def photo_key_from_database(model)
    # if the user wanted to update the image but the form validation failed the pattern/project will still get a new attachment/blob that's not yet saved to the database. As there is no image allocated to that blob/attachment on Cloudinary the image thumbnail breaks. That's why the actual key from the database (not from memory) needs to be pulled here:
    ActiveStorage::Attachment.find_by(record_id: model.id).blob.key
  end
end
