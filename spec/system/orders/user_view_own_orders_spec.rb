require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
    it 'e deve estar autenticado' do
        visit root_path
        click_on 'Meus Pedidos'

        expect(current_path).to eq new_user_session_path
    end

    it 'e não vê outros pedidos' do
        # Usuários
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        epicurino = User.create!(name: 'Epicurino Herbalius', email: 'epiher@email.com', password: 'password')

        # Galpão
        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        # Fornecedor
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        
        # Ordens
        first_order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: 'pending')

        second_order = Order.create!(user: epicurino, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 8.days.from_now, status: 'canceled')

        third_order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.days.from_now, status: 'delivered')

        login_as(jose)
        visit root_path
        click_on 'Meus Pedidos'

        expect(page).to have_content first_order.code
        expect(page).to have_content 'Pendente'
        expect(page).to have_content third_order.code
        expect(page).to have_content 'Entregue'
        expect(page).not_to have_content second_order.code
        expect(page).not_to have_content 'Cancelado'
    end

    it 'e visita um pedido' do
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')
        
        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

        first_order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
        
        login_as(jose)
        visit root_path
        click_on 'Meus Pedidos'
        click_on first_order.code

        expect(page).to have_content first_order.code
        expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
        expect(page).to have_content 'Fornecedor: ACME LTDA'
        formatted_date = I18n.localize(2.days.from_now.to_date)
        expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
    end

    it 'e não visita pedidos de outros usuários' do
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        rosa = User.create!(name: 'Rosa Augusta', email: 'rosaa@email.com', password: 'password')
        
        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

        first_order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
        
        login_as(rosa)
        visit order_path(first_order.id)

        expect(current_path).not_to eq order_path(first_order.id)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não possuí acesso à esse pedido'
    end
end