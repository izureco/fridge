class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,    presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :family_type
  belongs_to :eatout_freq
  belongs_to :appetite

  has_many :boxes

end
