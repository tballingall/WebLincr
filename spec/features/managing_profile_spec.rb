require 'feature_helper'

RSpec.feature 'Credentialing', speed: 'slow' do
  let(:other_user) { create(:user) }

  context 'As an guest' do
    scenario 'I can not edit user information' do
      visit user_path(other_user)
      expect(page).to_not have_link I18n.t('user.profile.edit_link')
      visit edit_user_path(other_user)
      expect(page).to have_content I18n.t('access.denied')
    end
  end

  context 'As an authenticated user' do
    let(:user) { create_current_user }
    let(:new_email) { 'bittermonk@example.com' }

    scenario 'I can edit my own information' do
      visit user_path(user)
      expect(page).to have_content user.email
      click_link I18n.t('user.profile.edit_link')
      within('#edit-user') do
        fill_in 'user_email', with: new_email
      end
      click_button I18n.t('user.profile.update_button')
      expect(page).to have_content I18n.t('user.profile.success')
      expect(page).to have_content new_email
    end

    scenario 'I can not edit other user information' do
      visit user_path(other_user)
      expect(page).to_not have_link I18n.t('user.profile.edit_link')
      visit edit_user_path(other_user)
      expect(page).to have_content I18n.t('access.denied')
    end
  end
end
