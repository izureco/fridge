class Box < ApplicationRecord
  with_options presence: true do
    validates :box_title
    validates :description
    validates :image
  end

  belongs_to :user
  has_one_attached :image

end
