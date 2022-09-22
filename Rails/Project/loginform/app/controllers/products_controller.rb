class ProductsController < ApplicationController

    def index

        if admin_signed_in?


            @admin = current_admin
            @products = @admin.products.all.paginate(page: params[:page], per_page: 3)

        else
            
            @products = Product.all.paginate(page: params[:page], per_page: 3)

        end

    end

    def search

        # @products = Product.where("name LIKE?","%" + params[:q] + "%")
        @products_search = Product.ransack(params[:q])
        @query = @products_search.result(distinct: true)
        # @products = Product.ransack(params[:q])

    end

    def new

        if !(admin_signed_in?)
            redirect_to root_path, notice: "Please sign in admin"
        else
            @product = Product.new
        end

    end

    def create

        if admin_signed_in?

            @admin = current_admin
            @product = @admin.products.new(product_params)

            if @product.save
                redirect_to @product
            else
                render 'new', status: :unprocessable_entity
            end

        end

    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        
        @product = Product.find(params[:id])
        
        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit', status: :unprocessable_entity
        end

    end

    def show

        @product = Product.find(params[:id])
    
    end

    def destroy
        @product = Product.find(params[:id])

        @product.destroy
        redirect_to products_path, status: :see_other
    end

    private

    def product_params
        params.require(:product).permit(:name, :category, :price, :image, :description)
    end

end
