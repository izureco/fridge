class Box < ApplicationRecord
  belongs_to  :user
  has_many    :box_boxtag_relations
  has_many    :boxtags, through: :box_boxtag_relations
  has_many    :foods
  has_one_attached :image
end
