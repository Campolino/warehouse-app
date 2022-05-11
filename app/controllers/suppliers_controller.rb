class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:edit, :update, :show]

    def index
        @suppliers = Supplier.all
    end

    def show
    end

    private

    def set_supplier
        id = params[:id]
        @supplier = Supplier.find(id)
    end

    def supplier_params
        params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
    end
end