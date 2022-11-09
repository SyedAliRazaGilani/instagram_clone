# frozen_string_literal:true

require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:mobilenumber) }
    it 'Image is valid' do
      image = File.new("#{Rails.root}/spec/factories/images/ali.jpeg")
      expect(build(:user, avatar: image)).to be_valid
    end
  end

  describe 'Active Storage' do
    subject { create(:user).avatar }
    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
  end

  describe 'Associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).through(:posts) }
    it { should have_many(:stories) }
    it { should have_many(:followers) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
