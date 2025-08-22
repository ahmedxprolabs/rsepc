require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content).is_at_least(2) }

  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end
end
