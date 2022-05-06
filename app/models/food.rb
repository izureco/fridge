class Food < ApplicationRecord
  # validation
  with_options presence: true do
    validates :food_title
    validates :number_title
    validates :purchase_date
    validates :expiry_date
    validates :price
  end

  # association
  belongs_to :box

end
