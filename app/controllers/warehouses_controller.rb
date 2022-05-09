class WarehousesController < ApplicationController
    before_action :set_warehouse, only: [:edit, :update, :show, :destory]

    def show
    end

    def new
        @warehouse = Warehouse.new
    end

    def create        
        @warehouse = Warehouse.new(warehouse_params) # Strong parameters
        
        if @warehouse.save
            # flash[:notice] = 'Galpão cadastrado com sucesso' ou
            redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Galpão não cadastrado.'
            render 'new'
        end
    end

    def edit
    end
    
    def update
        if @warehouse.update(warehouse_params)
            redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível atualizar o galpão'
            render 'edit'
        end
    end

    private

    def set_warehouse
        id = params[:id]
        @warehouse = Warehouse.find(id)
    end

    def warehouse_params
        params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
    end
end