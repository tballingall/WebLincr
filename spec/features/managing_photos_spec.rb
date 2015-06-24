require 'feature_helper'

RSpec.feature 'Managing Photos', speed: 'slow' do
  context 'given I am authenticated' do
    let!(:user) { create_current_user }
    let(:picture_name) { 'Lake Sunset' }
    context 'and I have an album' do
      let(:album) { create(:album, user: user) }

      scenario 'I can add a first image to that album' do
        visit album_path(album)
        click_link I18n.t('album.picture.add_link')
        within('#new-picture') do
          attach_file 'picture_image', 'spec/support/files/professoctocat.png'
          fill_in 'picture_name', with: picture_name
          fill_in 'picture_color', with: 'Blue'
          fill_in 'picture_description', with: 'Lorem stuff'
          select '2001', from: 'picture_year'
        end
        click_button I18n.t('album.picture.fields.submit')
        expect(page).to have_content I18n.t('album.picture.success')
        expect(page).to have_content picture_name
        expect(page).to have_xpath "//img[contains(@src, \"professoctocat\")]"
      end

      scenario 'I can see errors with bad data' do
        visit new_album_picture_path(album)
        within('#new-picture') do
          attach_file 'picture_image', 'spec/support/files/professoctocat.png'
          fill_in 'picture_name', with: ''
          fill_in 'picture_color', with: 'Blue'
          fill_in 'picture_description', with: 'Lorem stuff'
          select '2001', from: 'picture_year'
        end
        click_button I18n.t('album.picture.fields.submit')
        expect(page).to have_content I18n.t('album.picture.errors.intro')
      end

      context 'given another user with an album' do
        let!(:album) { create(:album) }

        scenario 'I can not add photos' do
          visit album_path(album)
          expect(page).to_not have_link I18n.t('album.picture.add_link')
          visit edit_album_path(album)
          expect(page).to have_content I18n.t('access.denied')
        end

        context 'given a photo' do
          let!(:picture) { create(:picture, album: album) }

          scenario 'I can not set an image primary' do
            visit album_path(album)
            expect(page).to_not have_link I18n.t('album.picture.make_primary')
          end
        end
      end

      context 'given I have a photo in the album' do
        let!(:picture) { create(:picture, album: album) }
        let(:new_file) { 'spec/support/files/professoctocat2.png' }
        let(:new_image) { "//img[contains(@src, \"professoctocat2\")]" }
        let(:original_image) do
          "//img[contains(@src, \"#{picture.image_name}\")]"
        end

        scenario 'That image will be the album primary' do
          visit user_path(user)
          expect(page).to have_xpath original_image
        end

        scenario 'I can add a second image and make it primary' do
          visit user_path(user)
          expect(page).to have_xpath original_image
          expect(page).to_not have_link I18n.t('album.picture.make_primary')
          visit new_album_picture_path(album)
          within('#new-picture') do
            attach_file 'picture_image', new_file
            fill_in 'picture_name', with: picture_name
            select '2001', from: 'picture_year'
            fill_in 'picture_color', with: 'Blue'
          end
          click_button I18n.t('album.picture.fields.submit')
          expect(page).to have_content I18n.t('album.picture.success')
          expect(page).to have_xpath original_image
          expect(page).to have_xpath new_image
          within("##{dom_id(Picture.last)}") do
            click_link I18n.t('album.picture.make_primary')
          end
          expect(page).to have_content I18n.t('album.picture.success')
          visit user_path(user)
          expect(page).to have_xpath new_image
        end
      end
    end
  end
end
