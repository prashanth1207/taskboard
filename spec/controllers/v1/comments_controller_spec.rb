require 'rails_helper'

RSpec.describe V1::CommentsController, type: :controller do
  describe '#create' do
    it 'should be able to create comment on card' do
      auth_header_admin
      post :create, params: {content: 'my comment', commentable_type: card.class.name, commentable_id: card.id}
      expect(response.code.to_i).to eq(200)
    end
    it 'should be able to create reply on a comment' do
      auth_header_admin
      c = comment(card,admin)
      post :create, params: {content: 'my comment', commentable_type: c.class.name, commentable_id: c.id}
      expect(response.code.to_i).to eq(200)
    end
  end

  describe '#index' do
    it 'should be able to show all comments on a card' do
      auth_header_admin
      20.times { comment(card, admin) }
      get :index, params: { resource_id: card.id, page: 1, per_page: 10 }
      expect(response.code.to_i).to eq(200)
      result = JSON.parse(response.body)
      expect(result.count).to eq(10)
    end
    it 'should be able to show all comments on a commnet' do
      auth_header_admin
      c = comment(card, admin)
      20.times { comment(c, admin) }
      get :index, params: { resource_id: c.id, page: 2, per_page: 10 }
      expect(response.code.to_i).to eq(200)
      result = JSON.parse(response.body)
      expect(result.count).to eq(10)
    end
  end

  describe '#show' do
    it 'should show all the replies to the comments' do
      auth_header_admin
      c = comment(card, admin)
      20.times { comment(c, admin) }
      get :show, params: { id: c.id }
      expect(response.code.to_i).to eq(200)
      result = JSON.parse(response.body)
      expect(result['replies'].count).to eq(20)
    end
    it 'show show all the replies to the reply' do
      auth_header_admin
      c = comment(card, admin)
      reply = comment(c, admin)
      20.times { comment(reply, admin) }
      get :show, params: { id: reply.id }
      expect(response.code.to_i).to eq(200)
      result = JSON.parse(response.body)
      expect(result['replies'].count).to eq(20)
    end
  end

  describe '#update' do
    it 'should update comment if the current_user is creator' do
      auth_header_admin
      card(admin)
      updated_content = 'updated desc'
      post :update, params: { id: comment(card,admin).id, content: updated_content}
      expect(response.code.to_i).to eq(200)
      card_resp = JSON.parse(response.body)
      expect(card_resp['content']).to eq(updated_content)
    end
    it 'should not update comment if the current_user is not creator' do
     auth_header_admin
      card(admin)
      updated_content = 'updated desc'
      post :update, params: { id: comment(card,member).id, content: updated_content}
      expect(response.code.to_i).to eq(401)
    end
  end

  describe '#destroy' do
    it 'should delete comment if the current_user is creator' do
      auth_header_admin
      card(admin)
      post :destroy, params: { id: comment(card,admin).id}
      expect(response.code.to_i).to eq(200)
    end
    it 'should delete comment if the current_user is owner of the list' do
      auth_header_admin
      card(list_members.last)
      post :destroy, params: { id: comment(card,list_members.last).id }
      expect(response.code.to_i).to eq(200)
    end
    it 'should not destroy comment if the current_user is member and not the creator' do
      auth_header_member
      card(list_members.last)
      post :destroy, params: { id: comment(card,list_members.last).id}
      expect(response.code.to_i).to eq(401)
    end
  end
end
