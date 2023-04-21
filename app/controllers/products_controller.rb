# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: %i[edit update show destroy]

  def index
    @products = policy_scope(Product)
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:notice] = "#{@product.name} is added in products."
      redirect_to mine_products_path
    else
      flash[:alert] = 'Error occured while saving your product.'
      render new_product_path
    end
  end

  def update
    @product.images.purge unless product_params[:images].nil?
    redirect_to @product.update(product_params) ? mine_products_path : :edit
    flash[:notice] = "#{@product.name} is updated."
  end

  def destroy
    @product.images.purge
    @product.destroy && redirect_to(mine_products_path)
    flash[:notice] = "#{@product.name} is deleted from products."
  end

  def show
    @cart_item = CartItem.new(quantity: 1)
    @cart_item.product = @product
  end

  def search
    @products = Product.where('name ILIKE ?', "%#{params[:keyword]}%")

    respond_to do |format|
      format.html
      format.json do
        @products
      end
    end
  end

  def mine
    @products = Product.where('user_id = ?', current_user.present? ? current_user.id : nil)
    authorize @products
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, images: [])
  end

  def find_product
    @product = Product.find(params[:id])
    authorize @product
  rescue StandardError
    redirect_to products_path
    flash[:notice] = 'Product not found or you are not authorized to view product.'
  end
end
