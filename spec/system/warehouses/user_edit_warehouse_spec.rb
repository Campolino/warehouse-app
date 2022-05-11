require 'rails_helper'

describe 'Usuário edita um galpão' do
    it 'a partir da tela inicial' do
        # Arrange
        warehouse = Warehouse.create!(name: 'Galpão SP', code: 'GRU', city: 'São Paulo', address: 'Rua depois da escola, 150', cep: '10000-000', description: 'Esse é um galpão', area: 80_000)

        # Act
        visit root_path
        click_on 'Galpão SP'
        click_on 'Editar'
    
        # Assert
        expect(page).to have_content 'Editar Galpão' 
        expect(page).to have_field 'Nome', with: 'Galpão SP' 
        expect(page).to have_field 'Código', with: 'GRU' 
        expect(page).to have_field 'Cidade', with: 'São Paulo' 
        expect(page).to have_field 'Endereço', with: 'Rua depois da escola, 150' 
        expect(page).to have_field 'CEP', with: '10000-000' 
        expect(page).to have_field 'Descrição', with: 'Esse é um galpão' 
        expect(page).to have_field 'Área', with: '80000' 
    end

    it 'com sucesso' do
        # Arrange
        warehouse = Warehouse.create!(name: 'Galpão SP', code: 'GRU', city: 'São Paulo', address: 'Rua depois da escola, 150', cep: '10000-000', description: 'Esse é um galpão', area: 80_000)

        # Act
        visit root_path
        click_on 'Galpão SP'
        click_on 'Editar'
        fill_in 'Nome', with: 'Galpão Internacional'
        fill_in 'Endereço', with: 'Avenida da escola, 888'
        fill_in 'Área', with: '150000'
        fill_in 'Descrição', with: 'Galpão super grande'
        click_on 'Enviar'
    
        # Assert
        expect(page).to have_content 'Galpão atualizado com sucesso'
        expect(page).to have_content 'Nome: Galpão Internacional'
        expect(page).to have_content 'Endereço: Avenida da escola, 888'
        expect(page).to have_content 'Área: 150000 m²'
        expect(page).to have_content 'Galpão super grande'
        expect(page).to have_content 'CEP: 10000-000'
        expect(page).to have_content 'Galpão GRU'
    end

    it 'e mantém os campos obrigatórios' do
        # Arrange
        warehouse = Warehouse.create!(name: 'Galpão SP', code: 'GRU', city: 'São Paulo', address: 'Rua depois da escola, 150', cep: '10000-000', description: 'Esse é um galpão', area: 80_000)

        # Act
        visit root_path
        click_on 'Galpão SP'
        click_on 'Editar'
        fill_in 'Nome', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'Área', with: ''
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Não foi possível atualizar o galpão'
    end
end
