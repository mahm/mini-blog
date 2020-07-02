class Topic < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 140 }
end
