require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } 

  it { is_expected.to validate_presence_of(:email) } #is_expcted.to já entende que é o user
  it { expect(user).to validate_uniqueness_of(:email).case_insensitive  }
  it { expect(user).to validate_confirmation_of(:password)  }
  it { expect(user).to validate_uniqueness_of(:auth_token)  }

  describe '#info' do # no ruby uma prática comum para metodos das classes é utilizar o # e colocar o nome do metodo igual o da classe
    it 'returns email, created_at and a token' do
      user.save! #ele tenta salvar e retorna um true or false, mas nesse caso serve também para trackear, ou seja ele salva o status inicial e mantém até o fim da requisição para saber se no fim teve alteração na model.
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')  #Defino um valor padrão para o token para esse teste

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end
  describe '#generate_authentication_token!' do #Altera o estado do objeto
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xyzTOKEN')
    end

    it 'generates another token when the current already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('abcdefg123token', 'newtoken12345678')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token) 
    end
    

    
  end
end
