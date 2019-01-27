require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'autherization tests on index' do
    before do
      request.headers['Authorization'] = 'ramdomstring'
    end
    it 'should respond with unauthorized status' do
      get :index
      expect(response.code.to_i).to eq(401)
      expect(JSON.parse(response.body)['error']).to eq("Access denied")
    end
  end

  describe '#create' do
    let(:member_params) do
      {email: 'member@gmail.com', username: 'member', password: 'password',password_confirmation: 'password', type: 'Member'}
    end
    context 'when logged in as admin' do
      it 'should create new user' do
        members_count = Member.count
        post :create, params: member_params, as: :json
        expect(response.code.to_i).to eq(200)
        expect(Member.count).to eq(members_count+1)
      end
    end
  end

  describe '#signin' do
    let(:user) do
      User.create({email: 'member@gmail.com', username: 'member', password: 'password',password_confirmation: 'password', type: 'Member'})
    end
    it 'should signin and return the auth_token' do
      post :login, params: {email: user.email, password: 'password'}
      expect(response.code.to_i).to eq(200)
      expect(JSON.parse(response.body)["auth_token"]).to eq(user.auth_token)
    end
    it 'should not signin and return the error message' do
      post :login, params: {email: user.email, password: 'password11'}
      expect(response.code.to_i).to eq(200)
      expect(JSON.parse(response.body)["errors"]).to eq(["Invalid email/password"])
    end
  end
end
