require 'rails_helper'

RSpec.describe Order, type: :model do
    describe '#valid?' do
        it 'data estimada de entrega deve ser preenchido' do
            order = Order.new(estimated_delivery_date: '')

            order.valid?
            result = order.errors.include?(:estimated_delivery_date)

            expect(result).to be true
        end

        it 'estimated_delivery_date é obrigatória' do
            user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')

            warehouse = Warehouse.create!(name: 'Galpão Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)

            supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-12')

            result = order.valid?

            expect(result).to be true
        end

        it 'data estimada de entrega não deve no passado' do
            order = Order.new(estimated_delivery_date: 1.day.ago)

            order.valid?
            result = order.errors.include?(:estimated_delivery_date)

            expect(result).to be true
            expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
        end

        it 'data estimada de entrega deve ser igual ou maior que amanhã' do
            order = Order.new(estimated_delivery_date: 1.day.from_now)

            order.valid?
            result = order.errors.include?(:estimated_delivery_date)

            expect(result).to be false
        end
    end
    
    describe 'Gera um código aleatório' do
        it 'ao criar um novo pedido' do
            user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')

            warehouse = Warehouse.create!(name: 'Galpão Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)

            supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-12')

            order.save!
            result = order.code

            expect(result).not_to be_empty
            expect(result.length).to eq 8
        end

        it 'e o código é único' do
            user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')

            warehouse = Warehouse.create!(name: 'Galpão Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)

            supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

            first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-12')

            second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-22')

            second_order.save!

            expect(second_order.code).not_to eq first_order.code
        end
    end
end
