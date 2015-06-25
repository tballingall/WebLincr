require 'feature_helper'

RSpec.feature 'User create' do
  context 'As a non-credentialed user' do
    describe 'I can view a list of users' do
      before(:all) do
        @users = []
        7.times do |n|
          @users[n] = create(:user)
        end
      end

      before(:each) { visit users_path }

      scenario 'and the list should be paginated.' do
        expect(page).to have_content @users[0].email
        expect(page).to have_content @users[5].email
        expect(page).to_not have_content @users[6].email
        click_link '2'
        expect(page).to_not have_content @users[0].email
        expect(page).to_not have_content @users[5].email
        expect(page).to have_content @users[6].email
      end

      scenario 'I can click the user\'s name to view a user profile page' do
        click_link @users[0].email
        expect(page)
          .to have_content I18n.t('user.profile.title', email: @users[0].email)
      end

      context 'given an admin' do
        let!(:admin) { create(:admin) }

        scenario 'I can see which users are admins' do
          expect(page.find("##{dom_id(@users[0])}"))
            .to_not have_content I18n.t('user.admin_flag')
          click_link '2'
          expect(page.find("##{dom_id(admin)}"))
            .to have_content I18n.t('user.admin_flag')
        end
      end
    end
  end
end
