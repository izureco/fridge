class Appetite < ActiveHash::Base
  self.data = [
    { id: 1, name: '食欲:少 -ご飯茶飯0.5杯-' },
    { id: 2, name: '食欲:普 -ご飯茶飯1.0杯-' },
    { id: 3, name: '食欲:多 -ご飯茶飯1.5杯-' }
  ]

  include ActiveHash::Associations
  has_many :users

end