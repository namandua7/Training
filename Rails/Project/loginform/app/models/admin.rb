class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable

  validates_confirmation_of :password
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :mobile

  has_many :products
  
end