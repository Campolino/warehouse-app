require 'rails_helper'

RSpec.describe Warehouse, type: :model do
    describe '#valid?' do
        context "presence" do
            it 'falso quando name está vazio' do
                # Arrange
                warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Rua da avenida, 550', cep: '25000-000', area: 10_000, description: 'Aquele galpão')
                # Act
                result = warehouse.valid?
                # Assert
                expect(result).to eq false 
            end
    
            it 'falso quando code está vazio' do
                # Arrange
                warehouse = Warehouse.new(name: 'Galpão do Rio', code: '', address: 'Rua da avenida, 550', cep: '25000-000', area: 10_000, description: 'Aquele galpão')
                # Act
                result = warehouse.valid?
                # Assert
                expect(result).to eq false 
            end
    
            it 'falso quando address está vazio' do
                # Arrange
                warehouse = Warehouse.new(name: 'Galpão do Rio', code: 'RIO', address: '', cep: '25000-000', area: 10_000, description: 'Aquele galpão')
                # Act
                result = warehouse.valid?
                # Assert
                expect(result).to eq false 
            end
    
            it 'falso quando cep está vazio' do
                # Arrange
                warehouse = Warehouse.new(name: 'Galpão do Rio', code: 'RIO', address: 'Rua da avenida, 550', cep: '', area: 10_000, description: 'Aquele galpão')
                # Act
                result = warehouse.valid?
                # Assert
                expect(result).to eq false 
            end
    
            it 'falso quando area está vazio' do
                # Arrange
                warehouse = Warehouse.new(name: 'Galpão do Rio', code: 'RIO', address: 'Rua da avenida, 550', cep: '25000-000', area: nil, description: 'Aquele galpão')
                # Act
                result = warehouse.valid?
                # Assert
                expect(result).to eq false 
            end
    
            it 'falso quando description está vazio' do
                # Arrange
                warehouse = Warehouse.new(name: 'Galpão do Rio', code: 'RIO', address: 'Rua da avenida, 550', cep: '25000-000', area: 10_000, description: '')
                # Act
                result = warehouse.valid?
                # Assert
                expect(result).to eq false 
            end
        end
        
        it 'falso quanto code já foi usado' do
            # Arrange
            first_warehouse = Warehouse.create(name: 'Galpão do Rio', code: 'RIO', address: 'Rua da avenida, 550', cep: '25000-000', area: 25_000, description: 'Aquele galpão')
            second_warehouse = Warehouse.new(name: 'Galpão de Niteroi', code: 'RIO', address: 'Rua da lapa, 860', cep: '28000-000', area: 16_250, description: 'Outro galpão')

            # Act
            result = second_warehouse.valid?
            # Assert
            expect(result).to eq false
        end
    end
end
