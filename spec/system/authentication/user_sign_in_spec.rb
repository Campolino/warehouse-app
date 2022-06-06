require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        # Arrange
        User.create!(email: 'lucas@email.com', password: 'password')

        # Act
        visit root_path

        click_on 'Login'

        within('main form') do
            fill_in 'E-mail', with: 'lucas@email.com' 
            fill_in 'Senha', with: 'password'

            click_on 'Entrar'
        end

        # Assert
        expect(page).to have_content 'Login efetuado com sucesso.'
        within('nav') do
            expect(page).not_to have_link 'Login' 
            expect(page).to have_button 'Sair'
            expect(page).to have_content 'lucas@email.com'
        end
    end

    it 'e faz logout' do
        # Arrange
        User.create!(email: 'lucas@email.com', password: 'password')

        # Act
        visit root_path

        click_on 'Login'

        within('main form') do
            fill_in 'E-mail', with: 'lucas@email.com'
            fill_in 'Senha', with: 'password'

            click_on 'Entrar'
        end

        click_on 'Sair'

        # Assert
        expect(page).to have_content 'Logout efetuado com sucesso.'
        expect(page).to have_link 'Login' 
        expect(page).not_to have_button 'Sair'
        expect(page).not_to have_content 'lucas@email.com'
    end
end
