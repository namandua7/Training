class Doctor < ApplicationRecord
    
    # has_one :patient

    has_many :patients, through: :appointments
    has_many :appointments

    # validates :name, presence: true #{ message: "Must be present" }
    # validates :email, presence: true #{ message: "Must be present" }
    # validates :mobile, presence: true #{ message: "Must be present" }
    # validates :status, presence: { message: "Must be present" }

    # validates :password, confirmation: true
    # validates :password_confirmation, presence: true

    # validates :status, inclusion: {in: %w(Available NotAvailable), message: "%{value} is not valid status" }

    # validates :mobile, length: {maximum: 10}

    # validates :mobile, numericality: { only_integer: true }

    # validates :email, uniqueness: true

    # before_validation :ensure_name_has_value

    # after_save :saving_confirmation

    #  before_save :record_saved, if: :check_for_status

    # after_commit :record_destroy, on: :destroy

    # after_commit :record_created, on: :create

    # def check_for_status
    #     if self.status=='Available'
    #         return true
    #     else
    #         return false
    #     end
    # end


    # class AfterDestroyCallback
    #     def after_destroy(a)
    #         puts "Record destroyed"
    #     end
    # end
    # after_destroy AfterDestroyCallback.new


    # private

    
    # def record_destroy
    #     puts "Record deleted"
    # end

    # def record_created
    #     puts "Record created"
    # end

    
        # def record_saved
        #     puts "Record is useful"
        # end

    #     def ensure_name_has_value
    #         if name.nil?
    #             self.name=email unless email.blank?
    #         end
    #     end

    #     def saving_confirmation
    #       puts "Record has been successfully saved"
    #     end

    #   after_initialize do |user|
    #     puts "You have initialized an object!"
    #   end
    
    #   after_find do |user|
    #     puts "You have found an object!"
    #   end

end
