require 'rails_helper'

describe 'Usuário acessa a tela de fornecedores' do
    it 'a partir do menu' do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end

        # Assert
        expect(current_path).to eq suppliers_path
    end

    it 'e vê lista de fornecedores' do
        # Arrange
        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000120', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'acme@acme.com')
        Supplier.create!(corporate_name: 'Leiteira LTDA', brand_name: 'Leiteira', registration_number: '3354868000110', full_address: 'Rua Florinda, 800', city: 'Maringá', state: 'PR',email: 'empresa_leite@leiteira.com')

        # Act
        visit root_path
        click_on 'Fornecedores'

        # Assert
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('ACME')
        expect(page).to have_content('Guarupaba - SC')
        expect(page).to have_content('Leiteira')
        expect(page).to have_content('Maringá - PR')
    end

    it 'e não existem fornecedores cadastrados' do
        # Arrange

        # Act
        visit root_path
        click_on 'Fornecedores'

        # Assert
        expect(page).to have_content('Não existem fornecedores cadastrados.')
    end
end