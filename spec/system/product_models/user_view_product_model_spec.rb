require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'a partir do menu' do
        # Arrange

        # Act
        visit root_path

        within('nav') do
            click_on 'Modelos de Produtos'
        end

        # Assert
        expect(current_path).to eq product_models_path
    end

    it 'com sucesso' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung', registration_number: '55101188000155', full_address: 'Av. das Pedras, 125', city: 'Guarupaba', state: 'SC',email: 'sac@samsung.com')
        
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
        ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 20, depth: 15, sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)

        # Act
        visit root_path

        within('nav') do
            click_on 'Modelos de Produtos'
        end

        # Assert
        expect(page).to have_content 'TV 32'
        expect(page).to have_content 'TV32-SAMSU-XPTO90'
        expect(page).to have_content 'Samsung'
        expect(page).to have_content 'SoundBar 7.1 Surround'
        expect(page).to have_content 'SOU71-SAMSU-NOIZ77'
        expect(page).to have_content 'Samsung'
    end

    it 'e não existem produtos cadastrados' do
        # Act
        visit root_path

        within('nav') do
            click_on 'Modelos de Produtos'
        end

        # Assert
        expect(page).to have_content 'Não existem modelos de produtos cadastrados.'
    end
end