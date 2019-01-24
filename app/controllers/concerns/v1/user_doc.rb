module V1
  module UserDoc
    extend Apipie::DSL::Concern

    def_param_group :users_output do
      property :id, Integer, desc: 'id of the record'
      property :username, String, desc: 'username of the user'
      property :email, String, desc: 'email id of the user'
      property :type, String, desc: 'Admin/Member'
      property :created_at, String, desc: 'date of creation'
      property :updated_at, String, desc: 'last modified date'
    end

    def_param_group :users_input do
      property :username, String, desc: 'username of the user'
      property :email, String, desc: 'email id of the user'
      property :password, String, desc: 'password of the user'
      property :password_confirmation, String, desc: 'password confirmation'
    end

    api :GET, 'users', 'Lists all the users'
    returns array_of: :users_output, code: 200, desc: 'list of all users'
    def index; end

    api :POST, 'sign_up', 'Create new user'
    param_group :users_input
    returns code: 200, desc: 'created user auth token'
    def create; end

    api :POST, 'login', 'Login existing user'
    param :email, String, desc: 'page number'
    param :password, String, desc: 'page limit (default: 20)'
    returns code: 200, desc: 'user auth token'
    def login; end
  end
end