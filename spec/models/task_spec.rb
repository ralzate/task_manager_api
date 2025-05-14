require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(%w[pending in_progress completed]) }
  end
  
  describe 'associations' do
    it { should belong_to(:user) }
  end
  
  describe 'due date validation' do
    let(:user) { create(:user) }
    
    it 'is valid with a future due date' do
      task = build(:task, user: user, due_date: 1.day.from_now)
      expect(task).to be_valid
    end
    
    it 'is invalid with a past due date' do
      task = build(:task, user: user, due_date: 1.day.ago)
      expect(task).not_to be_valid
      expect(task.errors[:due_date]).to include("can't be in the past")
    end
  end  
end