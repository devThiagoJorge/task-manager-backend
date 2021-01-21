require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } 

  it { is_expected.to validate_presence_of(:email) } #is_expcted.to já entende que é o user
  it { expect(user).to validate_uniqueness_of(:email).case_insensitive  }
  it { expect(user).to validate_confirmation_of(:password)  }
end
