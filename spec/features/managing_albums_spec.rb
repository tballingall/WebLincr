require 'feature_helper'

RSpec.feature 'Managing Albums', speed: 'slow' do
  context 'As an authenticated user' do
    let(:user) { create_current_user }
    let(:album_name) { 'Summer Fun' }

    scenario 'I can add a new album to my account' do
      visit user_path(user)
      click_link I18n.t('album.new.link')
      within('#new-album') do
        fill_in 'album_name', with: album_name
      end
      click_button I18n.t('album.fields.submit')
      expect(page).to have_content I18n.t('album.create.success')
      expect(page).to have_content album_name
    end

    scenario 'I can not add an album with errors' do
      visit new_user_album_path(user)
      within('#new-album') do
        fill_in 'album_name', with: ''
      end
      click_button I18n.t('album.fields.submit')
      expect(page).to have_content I18n.t('album.errors.intro')
    end

    context 'given a album' do
      let!(:album) { create(:album, user: user) }
      let(:new_album_name) { 'I\'m a new album name' }

      scenario 'the album shows on my profile page' do
        visit user_path(user)
        click_link album.name
        expect(page).to have_content album.name
      end

      scenario 'I can edit the album' do
        visit album_path(album)
        click_link I18n.t('album.update.link')
        within('#edit-album') do
          fill_in 'album_name', with: new_album_name
        end
        click_button I18n.t('album.fields.submit')
        expect(page).to have_content I18n.t('album.update.success')
        expect(page).to have_content new_album_name
      end

      scenario 'I can not update an album with errors' do
        visit edit_album_path(album)
        within('#edit-album') do
          fill_in 'album_name', with: ''
        end
        click_button I18n.t('album.fields.submit')
        expect(page).to have_content I18n.t('album.errors.intro')
      end
    end

    context 'given a second user' do
      let(:other_user) { create(:user) }
      let(:album) { create(:album, user: other_user) }

      scenario 'I can not add albums to other users profiles' do
        visit user_path(other_user)
        expect(page).to_not have_link I18n.t('album.new.link')
        visit new_user_album_path(other_user)
        expect(page).to have_content I18n.t('access.denied')
      end

      scenario 'I can not edit anothe user\'s albums' do
        visit album_path(album)
        expect(page).to_not have_link I18n.t('album.update.link')
        visit edit_album_path(album)
        expect(page).to have_content I18n.t('access.denied')
      end
    end
  end
end
