require 'rails_helper'

RSpec.describe V1::CardsController, type: :controller do
  describe '#autorization' do
    context 'not autorized to access any actions if the current user is not the member of the list' do
      it 'should not let users access any card actions if they are not assigned to the list' do
        auth_header_member
        get :index, params: { list_id: list.id }
        expect(response.code.to_i).to eq(401)
        post :create, params: { list_id: list.id }
        expect(response.code.to_i).to eq(401)
        get :show, params: { list_id: list.id, id: card.id }
        expect(response.code.to_i).to eq(401)
        post :update, params: { list_id: list.id, id: card.id }
        expect(response.code.to_i).to eq(401)
        post :destroy, params: { list_id: list.id, id: card.id }
        expect(response.code.to_i).to eq(401)
      end
    end
  end
  describe '#create' do
    it 'should create new card for admin' do
      auth_header_admin
      prev_count = Card.count
      post :create, params: { list_id: list.id, title: 'my title', description: 'my desc'}
      expect(response.code.to_i).to eq(200)
      expect(Card.count).to eq(prev_count + 1)
    end
  end

  describe '#index' do
    it 'should show all cards created by current user sorted based on comments count desc' do
      auth_header_admin
      cards(admin)
      comment(cards[0], admin)
      2.times { comment(cards[1], admin) }
      3.times { comment(cards[2], admin) }
      get :index, params: { list_id: list.id }
      expect(response.code.to_i).to eq(200)
      cards_resp = JSON.parse(response.body)
      expect(cards_resp[0]['comments_count'].to_i).to eq(3)
      expect(cards_resp[1]['comments_count'].to_i).to eq(2)
      expect(cards_resp[2]['comments_count'].to_i).to eq(1)
    end
  end

  describe '#show' do
    it 'should return card with first 3 comments created' do
      auth_header_admin
      card(admin)
      4.times { comment(card, admin) }
      get :show, params: { list_id: list.id, id: card.id }
      expect(response.code.to_i).to eq(200)
      card_resp = JSON.parse(response.body)
      expect(card_resp['comments'].count).to eq(3)
    end
  end

  describe '#update' do
    it 'should update card if the current_user is creator' do
      auth_header_admin
      card(admin)
      updated_title = 'card_updated'
      updated_desc = 'updated desc'
      post :update, params: { list_id: list.id, id: card.id, title: updated_title, description: updated_desc }
      expect(response.code.to_i).to eq(200)
      card_resp = JSON.parse(response.body)
      expect(card_resp['title']).to eq(updated_title)
      expect(card_resp['description']).to eq(updated_desc)
    end
    it 'should not update card if the current_user is not creator' do
      auth_header_admin
      card(member)
      updated_title = 'card_updated'
      updated_desc = 'updated desc'
      post :update, params: { list_id: list.id, id: card.id, title: updated_title, description: updated_desc }
      expect(response.code.to_i).to eq(401)
    end
  end

  describe '#destroy' do
    it 'should delete card if the current_user is creator' do
      auth_header_admin
      card(admin)
      post :destroy, params: { list_id: list.id, id: card.id}
      expect(response.code.to_i).to eq(200)
    end
    it 'should delete card if the current_user is owner of the list' do
      auth_header_admin
      card(list_members.last)
      post :destroy, params: { list_id: list.id, id: card.id}
      expect(response.code.to_i).to eq(200)
    end
    it 'should not destroy card if the current_user is member and not the creator' do
      auth_header_member
      card(list_members.last)
      post :destroy, params: { list_id: list.id, id: card.id}
      expect(response.code.to_i).to eq(401)
    end
  end
end