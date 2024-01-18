class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable, :timeoutable
<<<<<<< HEAD
=======
  has_many :blogs
  has_many :comments
>>>>>>> 94840faec5931e58964bfba6f41046e42ca70000
end
