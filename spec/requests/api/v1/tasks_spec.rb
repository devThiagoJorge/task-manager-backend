require 'rails_helper'

RSpec.describe 'Task API', type: :request do

    let!(:user) { create(:user) } 
    let(:headers)  do
        {
            'Accept' => 'application/api.taskmanager.v1',
            'Content-Type' => Mime[:json].to_s, 
            'Authorization' => user.auth_token
        }
    end
    
    before { host! 'api.taskmanager.test' }

    describe 'GET /tasks' do
      before do
        create_list(:task, 5, user_id: user.id)
        get '/tasks', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 tasks to database' do
          expect(json_body[:tasks].count).to eq(5)
      end
    end

    describe 'GET /tasks/:id' do
      let(:task) { create(:task, user_id: user.id) }
      before do
        get "/tasks/#{task.id}", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for tasks' do
          expect(json_body[:title]).to eq(task.title)
      end
    end
   
    
end
