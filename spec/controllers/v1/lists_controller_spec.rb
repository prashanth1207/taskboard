require 'rails_helper'

RSpec.describe V1::ListsController, type: :controller do
  describe "create" do
    it "should create list for admin" do
      auth_header_admin
      list_count = List.count
      post :create, params: {title: 'my title'}
      expect(response.code.to_i).to eq(200)
      expect(List.count).to eq(list_count+1)
    end
    it "should not create list for user" do
      auth_header_member
      post :create, params: {title: 'my title'}
      expect(response.code.to_i).to eq(401)
    end
  end

  describe '#assign_members' do
    it 'should allow to assign members by admin' do
      auth_header_admin
      post :assign_members, params: {id: list.id, members: members.map(&:id)}
      expect(response.code.to_i).to eq(200)
    end
    it 'should not allow to assign members by members' do
      auth_header_member
      post :assign_members, params: {id: list.id, members: members.map(&:id)}
      expect(response.code.to_i).to eq(401)
    end

    it 'should not allow to assign member who is the owner' do
      auth_header_admin
      post :assign_members, params: {id: list.id, members: [admin.id] }
      expect(response.code.to_i).to eq(404)
    end
  end
  describe '#unassign_members' do
    it 'should allow to unassign members by admin' do
      auth_header_admin
      post :unassign_members, params: {id: list.id, members: list_members.map(&:id)}
      expect(response.code.to_i).to eq(200)
    end
    it 'should not allow to unassign members by members' do
      auth_header_member
      post :unassign_members, params: {id: list.id, members: list_members.map(&:id)}
      expect(response.code.to_i).to eq(401)
    end
  end

  describe '#show' do
    it 'should show list if the current user is list owner' do
      auth_header_admin
      get :show, params: {id: list.id}
    end
    it 'should show list if the current user is list member' do
      list_members
      request.headers['Authorization'] = list_members.last.auth_token
      get :show, params: {id: list.id}
    end
    it 'should not show list if the current user is not list owner' do
      list_members
      new_admin = Admin.create(email: 'newadmin@gmail.com',username: 'newadmin', password: 'password', password_confirmation: 'password')
      request.headers['Authorization'] = new_admin.auth_token
      get :show, params: {id: list.id}
    end
    it 'should not show list if the current user is not ist member' do
      list_members
      auth_header_member
      get :show, params: {id: list.id}
    end
  end

  describe '#update' do
    it 'should update list if it is the owner' do
      auth_header_admin
      updated_title = 'updated title'
      post :update, params: { id: list.id, title: updated_title }
      expect(response.code.to_i).to eq(200)
      expect(JSON.parse(response.body)['title']).to eq(updated_title)
    end
    it 'should not update list if it is not the owner' do
      auth_header_member
      updated_title = 'updated title'
      post :update, params: {id: list.id, title: updated_title }
      expect(response.code.to_i).to eq(401)
    end
  end
end
