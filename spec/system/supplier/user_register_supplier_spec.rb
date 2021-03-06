require 'rails_helper'

describe 'Usuário cadastra fornecedor' do
    it 'a partir da tela inicial' do
        # Arrange

        # Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar novo fornecedor'

        # Assert
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('Nome Fantasia')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
        expect(page).to have_field('E-mail')
    end

    it 'com sucesso' do
        # Arrange

        # Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar novo fornecedor'

        fill_in 'Razão Social', with: 'ACME LTDA'
        fill_in 'Nome Fantasia', with: 'ACME'
        fill_in 'CNPJ', with: '55101188000155'
        fill_in 'Endereço', with: 'Av. das Pedras, 125'
        fill_in 'Cidade', with: 'Guarupaba'
        fill_in 'Estado', with: 'SC'
        fill_in 'E-mail', with: 'acme@acme.com'

        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Fornecedor cadastrado com sucesso.'
        expect(page).not_to have_content 'Fornecedor não cadastrado.'

        expect(page).to have_content 'ACME'
        expect(page).to have_content 'ACME LTDA'
        expect(page).to have_content 'CNPJ: 55101188000155'
        expect(page).to have_content 'Endereço: Av. das Pedras, 125 - Guarupaba - SC'
        expect(page).to have_content 'Email: acme@acme.com'
    end

    it 'com dados incompletos' do
        # Arrange

        # Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar novo fornecedor'

        fill_in 'Razão Social', with: ''
        fill_in 'Nome Fantasia', with: ''
        fill_in 'CNPJ', with: ''

        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Fornecedor não cadastrado.'
        expect(page).to have_content 'Razão Social não pode ficar em branco'
        expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
        expect(page).to have_content 'CNPJ não pode ficar em branco'
        expect(page).to have_content 'E-mail não pode ficar em branco'
        expect(page).to have_content 'CNPJ não possui o tamanho esperado (14 caracteres)'
    end
end