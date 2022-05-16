class ProductModelsController < ApplicationController
    before_action :set_product_model, only: [:edit, :update, :show]
    before_action :authenticate_user!, only: [:index]

    def index
        @product_models = ProductModel.all
    end

    def show
    end

    def new
        @product_model = ProductModel.new
        @suppliers = Supplier.all
    end

    def create
        @product_model = ProductModel.new(product_model_params)

        if @product_model.save
            redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Modelo de Produto não cadastrado.'
            @suppliers = Supplier.all
            render 'new'
        end
    end

    private

    def set_product_model
        @product_model = ProductModel.find(params[:id])
    end

    def product_model_params
        params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
    end
end