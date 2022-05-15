require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    context 'presence: true' do
        describe 'valid?' do
            it 'name é obrigatório' do
                # Arrange
                supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
    
                pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)
    
                # Act
                result = pm.valid?
    
                # Assert
                expect(result).to eq false
            end
    
            it 'weight é obrigatório' do
                # Arrange
                supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
    
                pm = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)
    
                # Act
                result = pm.valid?
    
                # Assert
                expect(result).to eq false
            end
    
            it 'width é obrigatório' do
                # Arrange
                supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
    
                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)
    
                # Act
                result = pm.valid?
    
                # Assert
                expect(result).to eq false
            end
    
            it 'height é obrigatório' do
                # Arrange
                supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
    
                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)
    
                # Act
                result = pm.valid?
    
                # Assert
                expect(result).to eq false
            end
    
            it 'depth é obrigatório' do
                # Arrange
                supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
    
                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '', sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)
    
                # Act
                result = pm.valid?
    
                # Assert
                expect(result).to eq false
            end
    
            it 'sku é obrigatório' do
                # Arrange
                supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
    
                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: '', supplier: supplier)
    
                # Act
                result = pm.valid?
    
                # Assert
                expect(result).to eq false
            end
        end
    end
    
    describe 'Peso e dimensão' do
        it 'são iguais a zero' do
            # Arrange
            supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
        
            pm = ProductModel.new(name: 'TV 32', weight: 0, width: 0, height: 0, depth: 0, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)

            # Act
            result = pm.valid?

            # Assert
            expect(result).to eq false
        end
    end

    describe 'SKU' do
        it 'já está em uso' do
            # Arrange
            supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
        
            first_pm = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 50, depth: 10, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)
            second_pm = ProductModel.new(name: 'TV 40', weight: 12000, width: 90, height: 65, depth: 15, sku: 'TV32-SAMSUNG-FPR80T0', supplier: supplier)

            # Act
            result = second_pm.valid?

            # Assert
            expect(result).to eq false
        end
    end
end
