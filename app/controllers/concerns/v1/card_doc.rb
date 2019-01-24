module V1
  module CardDoc
    extend Apipie::DSL::Concern

    def_param_group :card do
      property :id, Integer, desc: 'id of the record'
      property :title, Integer, desc: 'title of the card'
      property :desciption, String, desc: 'desc of the card'
      property :list_id, Integer, desc: 'list it belongs to'
      property :user_id, Integer, desc: 'created user id'
      property :created_at, String, desc: 'date of creation'
      property :updated_at, String, desc: 'last modified date'
    end

    api :GET, 'lists/:list_id/cards', 'card where admin created or member assigned by admin'
    returns array_of: :card, code: 200, desc: 'card where admin created or member assigned by admin'
    def index; end

    api :POST, 'lists/:list_id/cards', 'Create new card'
    param :title, String, desc: 'title of the cards'
    param :description, String, desc: 'desc of the cards'
    returns :card, code: 200, desc: 'List'
    def create; end

    api :GET, 'lists/:list_id/cards/:id', 'Show card'
    returns :card, code: 200, desc: 'card'
    def show; end

    api :PUT, 'lists/:list_id/cards/:id', 'Update card'
    param :title, String, desc: 'title of the cards'
    returns :card, code: 200, desc: 'card'
    def update; end

    api :DELETE, 'lists/:list_id/cards/:id', 'Destroy card'
    returns code: 200, desc: 'List'
    def destroy; end
  end
end
