module V1
  module ListDoc
    extend Apipie::DSL::Concern

    def_param_group :list do
      property :id, Integer, desc: 'id of the record'
      property :title, String, desc: 'title of the list'
      property :owner_id, Integer, desc: 'creator user id of the list'
      property :created_at, String, desc: 'date of creation'
      property :updated_at, String, desc: 'last modified date'
    end

    def_param_group :users_output do
      property :id, Integer, desc: 'id of the record'
      property :username, String, desc: 'username of the user'
      property :email, String, desc: 'email id of the user'
      property :type, String, desc: 'Admin/Member'
      property :created_at, String, desc: 'date of creation'
      property :updated_at, String, desc: 'last modified date'
    end

    api :GET, 'lists', 'list where admin created or member assigned by admin'
    returns array_of: :list, code: 200, desc: 'list where admin created or member assigned by admin'
    def index; end

    api :POST, 'lists', 'Create new user'
    param :title, String, desc: 'title of the lists'
    returns :list, code: 200, desc: 'List'
    def create; end

    api :GET, 'lists/:id', 'Show list'
    returns :list, code: 200, desc: 'List'
    def show; end

    api :PUT, 'lists/:id', 'Update List'
    param :title, String, desc: 'title of the lists'
    returns :list, code: 200, desc: 'List'
    def update; end

    api :DELETE, 'lists/:id', 'Destroy list'
    returns code: 200, desc: 'List'
    def destroy; end

    api :POST, 'lists/:id/assign_members', 'assign memebers y admin of the list'
    param :members, Array, desc: 'members to be assigned'
    returns code: 200, desc: 'Success message'
    def assign_members; end

    api :POST, 'lists/:id/unassign_members', 'assign memebers y admin of the list'
    param :members, Array, desc: 'members to be unassigned'
    returns code: 200, desc: 'Success message'
    def unassign_members; end

    api :GET, 'lists/:id/list_members', 'Show list'
    returns array_of: :users_output, code: 200, desc: 'List of users assigned to the list'
    def list_members; end
  end
end
