require 'feature_helper'

RSpec.feature 'Credentialing', speed: 'slow' do
  let(:password) { 'a secure password' }
  let(:user) do
    create(:user, password: password, password_confirmation: password)
  end

  context 'I exists' do
    let(:email) { user.email }

    context 'with correct email and password' do
      scenario 'allows me to log in' do
        visit root_url
        expect(page).to have_link I18n.t('user.sign_up.link')
        expect(page).to_not have_link I18n.t('user.logout.link')
        click_link I18n.t('user.login.link')
        within('#new-session') do
          fill_in 'email', with: email
          fill_in 'password', with: password
        end
        click_button I18n.t('user.fields.login')
        expect(page).to have_content I18n.t('user.login.success')
        expect(page).to have_link I18n.t('user.logout.link')
        expect(page).to_not have_link I18n.t('user.sign_up.link')
        expect(page).to_not have_link I18n.t('user.login.link')
      end
    end

    context 'with incorrect credentials' do
      let(:email) { 'not the email' }

      scenario 'does not allow me to log in' do
        visit root_url
        click_link I18n.t('user.login.link')
        within('#new-session') do
          fill_in 'email', with: 'not the user'
          fill_in 'password', with: 'not the password'
        end
        click_button I18n.t('user.fields.login')
        expect(page).to have_content I18n.t('user.errors.login')
        expect(page).to_not have_link I18n.t('user.logout.link')
        expect(page).to have_link I18n.t('user.sign_up.link')
        expect(page).to have_link I18n.t('user.login.link')
      end
    end

    context 'and I am logged in' do
      background { create_current_user }

      scenario 'allows me to log out' do
        visit root_url
        click_link I18n.t('user.logout.link')
        expect(page).to have_content I18n.t('user.login.link')
      end
    end
  end
end
