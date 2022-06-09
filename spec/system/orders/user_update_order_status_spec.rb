require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')
        
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

    order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :pending)

    login_as jose
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
  end
  
  it 'e pedido foi entregue' do
    jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')
        
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

    order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :pending)

    login_as jose
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
  end
  
  it 'se pedido ENTREGUE não aparece butão para cancelar' do
    jose = User.create!(name: 'José Velasques', email: 'jvelas@email.com', password: 'password')
        
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

    order = Order.create!(user: jose, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :delivered)

    login_as jose
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).not_to have_button 'Marcar como CANCELADO'
  end
end