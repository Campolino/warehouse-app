require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
    it 'a partir da tela de fornecedores' do
        # Arrange
        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        Supplier.create!(corporate_name: 'Leiteira LTDA', brand_name: 'Leiteira', registration_number: '33548680000100', full_address: 'Rua Florinda, 800', city: 'Maringá', state: 'PR',email: 'empresa_leite@leiteira.com')

        # Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'ACME'

        # Assert
        expect(page).to have_content 'ACME'
        expect(page).to have_content 'ACME LTDA'
        expect(page).to have_content 'CNPJ: 55101188000155'
        expect(page).to have_content 'Endereço: Av. das Pedras, 125 - Guarupaba - SC'
        expect(page).to have_content 'Email: acme@acme.com'
    end

    it 'e volta para a tela inicial' do
        # Arrange
        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')

        # Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'ACME'
        click_on 'Voltar'

        # Assert
        expect(current_path).to eq root_path
    end
end