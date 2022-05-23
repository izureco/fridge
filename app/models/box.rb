class Box < ApplicationRecord
  belongs_to  :user
  has_many    :box_boxtag_relations
  has_many    :boxtags, through: :box_boxtag_relations
  has_many    :foods, dependent: :destroy

  # cocoon gem
  # accepts_nested_attributes_for :foods, allow_destroy: true

  has_one_attached :image
end
