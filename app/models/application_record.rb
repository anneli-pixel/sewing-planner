class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def photo_in_database?
    ActiveStorage::Attachment.find_by(record_id: self.id, record_type: self.class.name)
  end
end
