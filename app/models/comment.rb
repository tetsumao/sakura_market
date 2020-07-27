class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  validates :content, length: {maximum: 140}
  
  include ToastrErrorsOutputter
end
