require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?(object)' do
    let(:users) { create_list(:user, 2) }
    let(:question) { create(:question, user: users.first) }

    it 'user is an author of question' do
      expect(users.first).to be_author_of(question)
    end

    it 'user is not an author of question' do
      expect(users.last).to_not be_author_of(question)
    end
  end
end
