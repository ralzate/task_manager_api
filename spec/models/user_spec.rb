require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:role) }
    it { should validate_inclusion_of(:role).in_array(%w[admin user]) }
  end
  
  describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
  end
  
  describe 'scopes' do
    let!(:admin) { create(:admin) }
    let!(:user) { create(:user) }
    
    it 'returns admins' do
      expect(User.admins).to include(admin)
      expect(User.admins).not_to include(user)
    end
    
    it 'returns regular users' do
      expect(User.regular_users).to include(user)
      expect(User.regular_users).not_to include(admin)
    end
  end
end