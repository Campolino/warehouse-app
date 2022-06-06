require 'rails_helper'

describe 'Usuário edita um pedido' do
    it 'e não é o dono' do
        jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')

        ermanoteu = User.create!(name: 'Ermanoteu Malaquias', email: 'ermano@email.com', password: 'password')

        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        
        order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)

        login_as(ermanoteu)
        patch(order_path(order.id), params: { order: { supplier_id: 3 }})

        expect(response).to redirect_to root_path 
    end
end