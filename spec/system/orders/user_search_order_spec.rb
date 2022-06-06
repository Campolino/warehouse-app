require 'rails_helper'

describe 'Usuário busca por um pedido' do
    it 'e deve estar autenticado' do
        user = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')
        
        login_as(user)
        visit root_path

        within('header nav') do
            expect(page).to have_field 'Buscar Pedido'
            expect(page).to have_button 'Buscar'
        end
    end

    it 'a partir do menu' do
        user = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
        
        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: order.code
        click_on 'Buscar'
        
        expect(page).to have_content "Resultados pela busca por: #{order.code}"
        expect(page).to have_content '1 pedido encontrado'
        expect(page).to have_content "Código: #{order.code}"
        expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
        expect(page).to have_content "Fornecedor: ACME LTDA"
    end

    it 'encontra múltiplos pedidos' do
        user = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        first_warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        second_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('AC23AD98')

        first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('AC23TW90')

        second_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 8.days.from_now)

        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ZZ000000')

        third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 5.days.from_now)
        
        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: 'AC23'
        click_on 'Buscar'
        
        expect(page).to have_content "Resultados pela busca por: AC23"
        expect(page).to have_content '2 pedidos encontrado'
        expect(page).to have_content "Código: #{first_order.code}"
        expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
        expect(page).to have_content "Fornecedor: ACME LTDA"
        expect(page).to have_content "Código: #{second_order.code}"
        expect(page).to have_content "Galpão Destino: CWB - Cuiaba"
        expect(page).to have_content "Fornecedor: ACME LTDA"
        expect(page).not_to have_content "Código: #{third_order.code}"
    end
end