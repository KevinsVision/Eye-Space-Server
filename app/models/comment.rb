class Comment < ApplicationRecord
  has_many :user_comments
end
