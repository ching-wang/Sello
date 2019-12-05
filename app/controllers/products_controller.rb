class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:new, :create, :edit, :update, :destroy, :basket, :checkout]

  def index
    @products = Product.all
    current_user ? @user = current_user : @user = nil
  end

  def new
    @product = Product.new
  end

  def basket
    @user = current_user
    @basket = @user.basket
  end

  def checkout
    @user = current_user
    @basket = @user.basket
  end

  def place_order
    @user = current_user
    if params[:address].length > 0
      @user.checkout_basket(params[:address])
      redirect_to orders_path
    else flash[:notice] = "Must enter an address!"
      render :checkout
    end
  end

  def show
    flash.now[:notice] = "Hello current action"
    @user = current_user
    @product = Product.find(params[:id])
    @no_in_basket = @user.number_in_basket(params[:id])
  end

  def add_to_basket
    product_id = params[:product_id]
    user = current_user
    user.add_to_basket(product_id)
    flash.now[:notice] = "Hello current action"
    redirect_to product_path(product_id)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_count, :img_url)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
