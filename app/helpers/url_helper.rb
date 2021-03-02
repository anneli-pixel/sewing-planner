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
end
