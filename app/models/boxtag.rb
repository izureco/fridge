class Boxtag < ApplicationRecord
  has_many :box_boxtag_relations
  has_many :boxes, through: :box_boxtag_relations

  validates :tag_name,    uniqueness: true
end
