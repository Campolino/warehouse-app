require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        # Arrange

        # Act
        visit root_path

        click_on 'Login'
        click_on 'Criar conta'

        within('main form') do
            fill_in 'Nome', with: 'Jose'
            fill_in 'E-mail', with: 'jose@email.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme sua senha', with: '123456'
            click_on 'Criar conta'
        end

        # Assert
        expect(page).to have_content 'jose@email.com'
        expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
        expect(page).to have_button 'Sair'

        user = User.last
        expect(user.name).to eq 'Jose'
    end
end