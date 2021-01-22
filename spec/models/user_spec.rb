require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } 

  it { is_expected.to validate_presence_of(:email) } #is_expcted.to já entende que é o user
  it { expect(user).to validate_uniqueness_of(:email).case_insensitive  }
  it { expect(user).to validate_confirmation_of(:password)  }
  it { expect(user).to validate_uniqueness_of(:auth_token)  }

  describe '#info' do # no ruby uma prática comum para metodos das classes é utilizar o # e colocar o nome do metodo igual o da classe
    it 'returns email, created_at and a token' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')  #Defino um valor padrão para o token para esse teste

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end
  
end
