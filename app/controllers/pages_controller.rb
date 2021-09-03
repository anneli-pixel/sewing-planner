class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :sample_account ]

  def home
  end

  def sample_account
  end
end
