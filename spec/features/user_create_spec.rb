require 'feature_helper'

RSpec.feature 'User create' do
  let(:username) { 'bittermonk' }
  let(:email) { 'mac@example.com' }
  let(:password) { 'I am going to use a very secure password' }
  let(:password_confirmation) { 'I am going to use a very secure password' }

  context 'As an uncredentialed user' do
    context 'with acceptable information' do
      scenario 'I can register for a new account' do
        visit root_path
        click_link I18n.t('user.sign_up.link')
        expect(page).to have_content I18n.t('user.sign_up.title')
        within('#new_user') do
          fill_in 'user_email', with: email
          fill_in 'user_password', with: password
          fill_in 'user_password_confirmation', with: password_confirmation
        end
        click_button I18n.t('user.sign_up.link')
        expect(page).to have_content I18n.t('user.sign_up.success')
      end
    end

    context 'with unacceptable information' do
      let(:password) { '' }

      scenario 'I can see errors when I register for a new account' do
        visit root_path
        click_link I18n.t('user.sign_up.link')
        expect(page).to have_content I18n.t('user.sign_up.title')
        within('#new_user') do
          fill_in 'user_email', with: email
          fill_in 'user_password', with: password
          fill_in 'user_password_confirmation', with: password_confirmation
        end
        click_button I18n.t('user.sign_up.link')
        expect(page).to have_content I18n.t('user.errors.intro')
      end
    end
  end
end
