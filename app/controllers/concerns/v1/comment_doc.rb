module V1
  module CommentDoc
    extend Apipie::DSL::Concern

    def_param_group :comment do
      property :id, Integer, desc: 'id of the record'
      property :content, String, desc: 'desc of the comment'
      property :user_id, Integer, desc: 'created user id'
      property :commentable_id, Integer, desc: 'id of the card/comment'
      property :commentable_type, Integer, desc: 'Card/Comment'
      property :created_at, String, desc: 'date of creation'
      property :updated_at, String, desc: 'last modified date'
    end

    api :GET, 'comments', 'gets all the comment to the card/comment'
    returns array_of: :comment, code: 200, desc: 'gets all the comment to the card/comment'
    def index; end

    api :POST, 'comments', 'Create new comment'
    param :content, String, desc: 'desc of the comments'
    property :commentable_id, Integer, desc: 'id of the card/comment'
    property :commentable_type, Integer, desc: 'Card/Comment'
    returns :comment, code: 200, desc: 'comment'
    def create; end

    api :GET, 'comments/:id', 'Show comment'
    returns :comment, code: 200, desc: 'comment'
    def show; end

    api :PUT, 'comments/:id', 'Update comment'
    param :content, String, desc: 'desc of the comments'
    returns :comment, code: 200, desc: 'comment'
    def update; end

    api :DELETE, 'comments/:id', 'Destroy comment'
    returns code: 200, desc: 'comment'
    def destroy; end
  end
end
