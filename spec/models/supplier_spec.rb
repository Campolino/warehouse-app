require 'rails_helper'

RSpec.describe Supplier, type: :model do
    describe '#valid?' do
        context "presence" do
            it 'falso quando corporate_name está vazio' do
                # Arrange
                first_supplier = Supplier.create(corporate_name: '', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
                # Act
                result = first_supplier.valid?
                # Assert
                expect(result).to eq false 
            end

            it 'falso quando brand_name está vazio' do
                # Arrange
                first_supplier = Supplier.create(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
                # Act
                result = first_supplier.valid?
                # Assert
                expect(result).to eq false 
            end
            
            it 'falso quando registration_number está vazio' do
                # Arrange
                first_supplier = Supplier.create(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
                # Act
                result = first_supplier.valid?
                # Assert
                expect(result).to eq false 
            end
            
            it 'falso quando email está vazio' do
                # Arrange
                first_supplier = Supplier.create(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: '')
                # Act
                result = first_supplier.valid?
                # Assert
                expect(result).to eq false 
            end
        end

        it 'falso quando CNPJ já foi usado' do
            # Arrange
            first_supplier = Supplier.create(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
            second_supplier = Supplier.create(corporate_name: 'Leiteira LTDA', brand_name: 'Leiteira', registration_number: '55101188000155', full_address: 'Rua Florinda, 800', city: 'Maringá', state: 'PR',email: 'empresa_leite@leiteira.com')

            # Act
            result = second_supplier.valid?
            # Assert
            expect(result).to eq false
        end
    end
end
