require 'rails_helper'

describe 'Usuário deleta um galpão' do
    it 'com sucesso' do
        # Arrange
        warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)
        
        # Act
        visit root_path
        click_on 'Cuiaba'
        click_on 'Remover'

        # Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content 'Cuiaba'
        expect(page).not_to have_content 'CWB'
    end

    it 'e não apaga outros galpões' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', address: 'Rua depois da escola, 150', cep: '35000-000', description: 'Galpão Centro-Oeste', area: 80_000)
        second_warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Rua do Galpão, 1250', cep: '25000-000', description: 'Galpão destinado para cargas')

        # Act
        visit root_path
        click_on 'Cuiaba'
        click_on 'Remover'

        # Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).to have_content 'Galpão do Rio'
        expect(page).not_to have_content 'Cuiaba'
    end
end