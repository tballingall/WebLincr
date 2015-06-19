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

  describe 'associations' do
  end

  describe 'callbacks' do
  end

  describe 'class methods' do
  end

  describe 'finders' do
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