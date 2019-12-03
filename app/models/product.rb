class Product < ApplicationRecord

    belongs_to :user
    has_many :product_tags
    has_many :tags, through: :product_tags
    has_many :orders
    has_many :users, through: :orders


    def add_tag_by_id(tag_id)
        if !ProductTag.find_by(product_id: self.id, tag_id: tag_id)
            ProductTag.create(product_id: self.id, tag_id: tag_id) 
        else puts "tag already associated with product"
        end
    end

    def remove_tag_by_id(tag_id)
        if ProductTag.find_by(product_id: self.id, tag_id: tag_id)
            pt = ProductTag.where(product_id: self.id, tag_id: tag_id)
            pt.destroy
        else puts "tag not associated product"
        end
    end

end
