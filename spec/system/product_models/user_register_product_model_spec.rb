require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
    it 'com sucesso' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')

        # Act
        visit root_path

        click_on 'Modelos de Produtos'
        click_on 'Cadastrar Novo'

        fill_in 'Nome',	with: 'TV 32 polegadas'
        fill_in 'Peso',	with: 10_000
        fill_in 'Altura',	with: 70
        fill_in 'Largura',	with: 90
        fill_in 'Profundidade',	with: 10
        fill_in 'SKU',	with: 'TV32-SAMS-FPR80'
        select 'Samsung', from: 'Fornecedor'

        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
        expect(page).to have_content 'TV 32 polegadas'
        expect(page).to have_content 'Fornecedor: Samsung'
        expect(page).to have_content 'SKU: TV32-SAMS-FPR80'
        expect(page).to have_content 'Dimensão: 70cm x 90cm x 10cm'
        expect(page).to have_content 'Peso: 10000g'
    end
end