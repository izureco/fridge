class EatoutFreq < ActiveHash::Base
  self.data = [
    { id: 1, name: 'まったく行かない -週0~1回-' },
    { id: 2, name: 'たまに行く      -週1~3回-' },
    { id: 3, name: 'ときどき行く    -週4~6回-' },
    { id: 4, name: 'ほぼ毎日行く    -週7回以上-' }
  ]

  include ActiveHash::Associations
  has_many :users

end