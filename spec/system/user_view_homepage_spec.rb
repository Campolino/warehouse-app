require 'rails_helper'

describe 'Visitante acessa a tela inicial' do
    it 'e vê o nome da app' do
        # Assert

        # Act
        visit('/')

        # Arrange
        expect(page).to have_content('Sistema de Galpões e Estoque')
    end
end