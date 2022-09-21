class Product < ApplicationRecord

    validates :name, presence: true, uniqueness: true
    validates :category, inclusion: {in: %w(Beauty Electronic Fashion Grocery Sports Medicines)}
    validates :price, presence: true, numericality: {only_integer: true}
    validates :image, presence: true

    # mount_uploader :image, ProductImageUploader

    has_one_attached :image

    belongs_to :admin
    # before_save :store_admin_id_to_product

    # def store_admin_id_to_product
    #     product.admin_id = admin.id
    # end

end