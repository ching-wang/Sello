class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :products, through: :orders
  has_many :basket_joins

  has_secure_password

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  validates :email, {
    presence: true
  }

  validates :name, {
    presence: true,
    uniqueness: true,
    length: { in: 2..23 }
  }

  validates :password, {
    presence: true,
    length: { minimum: 6 }
  }

  def products
    Product.where user_id: self.id
  end

    def add_to_basket(product_id, quantity=1)
        product_id = product_id.to_i
        max_q = self.max_quantity(product_id)
        product = Product.find(product_id)
        if quantity <= max_q
            can_add = true
            if self.basket.any? {|item| item[:product_id]==product_id.to_i}
                join = BasketJoin.find_by(user_id: self.id, product_id: product_id)
                new_quantity = join.quantity + quantity
                join.update(quantity: new_quantity)
            else 
                BasketJoin.create(user_id: self.id, product_id: product_id, quantity: quantity)
            end
        else can_add = false
        end
        can_add
    end
    
  def products_by_name
    self.products.map(&:name)
  end

  def past_orders
    orders = Order.where(user_id: self.id)
  end

    def max_quantity(product_id)
        product_stock = Product.find(product_id).stock_count
        if self.basket.any? {|item| item[:product_id]==product_id.to_i}
            join = BasketJoin.find_by(user_id: self.id, product_id: product_id.to_i)
            current_number_in_basket = join.quantity
            max = product_stock - current_number_in_basket
        else max = product_stock
        end
        max
    end

  def basket
    basket_joins = BasketJoin.where(user_id: self.id)
    basket = []
    basket_joins.each do |join|
      basket << { product_id: join.product_id, quantity: join.quantity }
    end
    basket
  end

  def checkout_basket(address)
    buyer_id = self.id
    order = Order.create_with_basket(self, address)
  end

    def number_in_basket(product_id)
        if self.basket.any? {|item|item[:product_id]==product_id.to_i}
          quantity = self.basket.select{|item|item[:product_id]==product_id.to_i}[0][:quantity]
        else 0
        end
    end

  def basket_total
    basket = self.basket
    total = 0
    basket.each do |item|
      quantity = item[:quantity]
      product_price = Product.find(item[:product_id]).price
      total += quantity * product_price
    end
    total.to_s.to_f
  end

  def remove_from_basket(product_id)
    product_id = product_id.to_i
    join = self.basket.select{|j|j[:product_id]==product_id}
    if join[0][:quantity] < 2
        basket_join = BasketJoin.find_by(product_id: product_id, user_id: self.id)
        basket_join.destroy
    else num_in_basket = join[0][:quantity]
        new_num = num_in_basket - 1
        basket_join = BasketJoin.find_by(product_id: product_id, user_id: self.id)
        basket_join.update(quantity: new_num)
    end
    self.basket
  end

  def remove_all_from_basket(product_id)
    product_id = product_id.to_i
    join = self.basket.select{|j|j[:product_id]==product_id}
    basket_join = BasketJoin.find_by(product_id: product_id, user_id: self.id)
    basket_join.destroy if basket_join
    self.basket  
    end
end
