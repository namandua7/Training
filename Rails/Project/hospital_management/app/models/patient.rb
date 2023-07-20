class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :age
  validates_presence_of :gender
  validates_presence_of :mobile

  validates_confirmation_of :password

  has_many :doctors, :through => :appointments
  has_many :appointments, dependent: :delete_all
  
end
