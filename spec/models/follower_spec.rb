require 'rails_helper'
RSpec.describe Follower, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:follower_id) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Callback' do
    it 'is expected that falsify_friend callback is run before create' do
      follower = Follower.new(user_id: 1)
      expect(follower.friend).to eq(false)
    end
  end
end
