require 'rails_helper'

RSpec.describe Album, type: :model do
  subject(:album) do
    Album.new(
      name: name,
      user: user
    )
  end
  let(:user) { create(:user) }
  let(:name) { 'Summer Fun' }

  it { expect(album).to be_valid }
  it { expect(create(:album)).to be_valid }

  describe 'associations' do
    it 'user' do
      expect(Album.reflect_on_association(:user).macro).to eq :belongs_to
    end
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
    context 'when name doesn\'t exist' do
      let(:name) { nil }

      it { expect(album).to_not be_valid }
      it 'dislays a missing value error' do
        album.valid?
        expect(album.errors[:name]).to include('can\'t be blank')
      end
    end

    context 'when name is a duplicate' do
      let!(:duplicate_album) do
        Album.create(name: name, user: user)
      end

      it { expect(album).to_not be_valid }
      it 'dislays a duplicate value error' do
        album.valid?
        expect(album.errors[:name]).to include('has already been taken')
      end
    end

    context 'given an other user has a duplicate album name' do
      let(:other_user) { create(:user) }

      let!(:duplicate_album) do
        Album.create(name: name, user: other_user)
      end

      it { expect(album).to be_valid }
    end
  end
end
