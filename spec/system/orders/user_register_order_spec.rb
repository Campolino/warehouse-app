require 'rails_helper'

describe 'Usuário cadastrar um pedido' do
    it 'e deve estar autenticado' do
        visit root_path
        click_on 'Registrar Pedido'

        expect(current_path).to eq new_user_session_path
    end
    
    it 'com sucesso' do
        # Arrange
        user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')

        Warehouse.create!(name: 'Galpão Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)
        
        warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

        Supplier.create!(corporate_name: 'Leiteira LTDA', brand_name: 'Leiteira', registration_number: '33548680000100', full_address: 'Rua Florinda, 800', city: 'Maringá', state: 'PR',email: 'empresa_leite@leiteira.com')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('AC23AD98')

        # Act
        login_as(user)
        visit root_path
        click_on 'Registrar Pedido'
        select 'GRU - Aeroporto SP', from: 'Galpão'
        select 'ACME LTDA - 55101188000155', from: 'Fornecedor'
        fill_in 'Data Prevista de Entrega', with: '20/12/2022'
        click_on 'Gravar'

        # Assert
        expect(page).to have_content 'Pedido cadastrado com sucesso.'
        expect(page).to have_content 'Pedido AC23AD98'
        expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
        expect(page).to have_content 'Fornecedor: ACME LTDA - 55101188000155'
        expect(page).to have_content 'Usuário Responsável: Sergio | sergio@email.com'
        expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'

        expect(page).not_to have_content 'Galpão Destino: Galpão Cuiaba'
        expect(page).not_to have_content 'Fornecedor: Leiteira LTDA'
    end
end