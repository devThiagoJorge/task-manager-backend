require 'rails_helper'

RSpec.describe 'Users Api', type: :request do
    let!(:user) { create(:user) } 
    let(:user_id) { user.id } 

    before { host! 'api.taskmanager.test' }

    describe 'GET /users/:id' do
        before do 
            headers = { 'Accept' => 'application/api.taskmanager.v1' }
            get "/users/#{user_id}", params: {}, headers: headers
        end

        context 'when the user exist' do
            it 'returns the user' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:id]).to equal(user_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the user does not exist' do
            let(:user_id) { 10000 } 
            it 'returns status code 200' do
                expect(response).to have_http_status(404)
            end
        end
        
    end

    describe 'POST /users' do
        before do 
            headers = { 'Accept ' => 'application/vnd.taskmanager.v1' }
            post '/users', params: { user: user_params }, headers: headers
        end

        context 'when the body of request are valid' do
            let(:user_params) { FactoryGirl.attributes_for(:user) } 

            it 'return status code 201' do
                expect(response).to  have_http_status(201)
            end
            
            it 'returns json data for the new user' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eq(user_params[:email])
            end
        end
        
        context 'when the body of request are invalid' do
            let(:user_params) { attributes_for(:user, email: 'inavalid_email@') } 

            it 'return status code 422' do
                expect(response).to  have_http_status(422)
            end

            it "returns the json data for the errors" do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response).to have_key(:errors)
            end
        end
    end
end