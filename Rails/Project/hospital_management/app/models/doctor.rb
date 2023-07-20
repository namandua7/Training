class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :specialist
  validates_presence_of :experience
  validates_presence_of :age
  validates_presence_of :location

  validates_confirmation_of :password

  has_many :appointments
  has_many :patients, :through => :appointments

end
