class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
    end

    def create
        # 1 - Receber os dados enviados

        # 2 - Criar um novo galpão no banco de dados
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
        w = Warehouse.new(warehouse_params) # Strong parameters
        w.save

        redirect_to root_path
    end
end