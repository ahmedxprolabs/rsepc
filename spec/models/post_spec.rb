require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(3) }
  it { should validate_presence_of(:body) }

  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end
end
