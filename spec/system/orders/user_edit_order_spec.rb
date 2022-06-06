require 'rails_helper'

describe 'Usuário edito pedido' do
    it 'e deve estar autenticado' do
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        
        order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

        visit edit_order_path(order.id)

        expect(current_path).not_to eq edit_order_path(order.id)
    end

    it 'com sucesso' do
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        first_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

        second_supplier = Supplier.create!(corporate_name: 'Leiteira LTDA', brand_name: 'Leiteira', registration_number: '33548680000100', full_address: 'Rua Florinda, 800', city: 'Maringá', state: 'PR',email: 'empresa_leite@leiteira.com')
        
        order = Order.create!(user: jose, warehouse: warehouse, supplier: first_supplier, estimated_delivery_date: 2.days.from_now)

        login_as(jose)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Editar'
        fill_in 'Data Prevista de Entrega', with: '12/12/2022'
        select 'Leiteira LTDA', from: 'Fornecedor'
        click_on 'Gravar'

        expect(page).to have_content 'Pedido atualizado com sucesso.'
        expect(page).to have_content 'Fornecedor: Leiteira LTDA'
        expect(page).to have_content "Data Prevista de Entrega: 12/12/2022"
    end

    
    it 'caso seja o responsável' do
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        ermanoteu = User.create!(name: 'Ermanoteu Malaquias', email: 'ermano@email.com', password: 'password')

        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        
        order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

        login_as(ermanoteu)
        visit edit_order_path(order.id)

        expect(current_path).to eq root_path
    end
end