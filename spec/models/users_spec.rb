require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.new(
      email: email,
      password: password,
      password_confirmation: password_confirmation
    )
  end

  let(:email) { 'new_email@example.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }

  it { expect(user).to be_valid }
  it { expect(create(:user)).to be_valid }

  describe 'associations' do
    it 'albums' do
      expect(User.reflect_on_association(:albums).macro).to eq :has_many
    end
  end

  describe 'callbacks' do
  end

  describe 'class methods' do
    describe '.null_user' do
      it 'returns a null user duck' do
        expect(User.null_user).to respond_to :id
        expect(User.null_user.id).to eq nil
        expect(User.null_user.email).to eq nil
        expect(User.null_user.username).to eq nil
        expect(User.null_user.authenticate('anything')).to eq false
      end
    end
  end

  describe 'finders' do
    describe '.find_by_email' do
      context 'given users exist' do
        before do
          user.save!
          create(:user)
        end

        it 'finds the correct user by email' do
          expect(User.find_by_email(user.email)).to eq user
        end
      end

      it 'returns a null user if no user is found' do
        expect(User.current_user('invalid')).to be_a User::NullUser
      end
    end

    describe '.current_user' do
      context 'given a user exists' do
        before do
          user.save!
        end

        it 'returns the correct user' do
          expect(User.current_user(user.id)).to eq user
        end
      end

      it 'returns a null user if no user is found' do
        expect(User.current_user('invalid')).to be_a User::NullUser
      end
    end

    describe 'pagination' do
      it 'Returns 6 items' do
        expect(User.per_page).to eq 6
      end
    end
  end

  describe 'instance methods' do
  end

  describe 'validations' do
    context 'when password doesn\'t exist' do
      let(:password) { nil }

      it { expect(user).to_not be_valid }
      it 'dislays a missing value error' do
        user.valid?
        expect(user.errors[:password]).to include('can\'t be blank')
      end
    end

    context 'when email doesn\'t exist' do
      let(:email) { nil }

      it { expect(user).to_not be_valid }
      it 'dislays a missing value error' do
        user.valid?
        expect(user.errors[:email]).to include('can\'t be blank')
      end
    end

    context 'when email is a duplicate' do
      let!(:duplicate_user) do
        User.create(
          email: 'new_email@example.com',
          password: password,
          password_confirmation: password_confirmation
        )
      end

      it { expect(user).to_not be_valid }
      it 'dislays a duplicate value error' do
        user.valid?
        expect(user.errors[:email]).to include('has already been taken')
      end
    end

    context 'when emails are formatted correctly' do
      %w(
        macdev@example.com
        mac+dev@example.com
        mac_dev@example.com
        mac+dev@mail.example.com
      ).each do |correct_email_format|
        let(:email) { correct_email_format }
        it { expect(user).to be_valid }
      end
    end

    context 'when emails are not formatted correctly' do
      %w(
        macdev@example
        macdevexample.com
      ).each do |incorrect_email_format|
        let(:email) { incorrect_email_format }
        it { expect(user).to_not be_valid }
      end
    end
  end
end
