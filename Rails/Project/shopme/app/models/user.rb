class User < ApplicationRecord

    serialize :category, Array

    validates :name, presence: true
    validates :mobile, presence: true, numericality: {only_integer: true}, length: {is: 10}
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true

    validates_each :email do |record, attr, value|
        record.errors.add(attr, 'Invalid') unless value =~ /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/
    end
    validates_each :mobile do |record, attr, value|
        record.errors.add(attr, 'Invalid') unless value =~ /[7-9]{1}+[0-9]{9}/
    end

end
