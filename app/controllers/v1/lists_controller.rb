module V1
  class ListsController < ApplicationController
    before_action :set_list, only: %I[show update destroy assign_members unassign_members list_members]

    include ListDoc
    def index
      lists = []
      if current_user.admin?
        lists = current_user.created_lists
      elsif current_user.member?
        lists = current_user.lists
      end
      render json: lists.page(params[:page], params[:per_page])
    end

    def show
      return access_denied unless @list.showable?(current_user.id)
      render json: @list
    end

    def create
      return access_denied unless current_user.admin?
      list = current_user.created_lists.new(list_params)
      list.save!
      render json: list
    end

    def update
      return access_denied unless owner?
      @list.update(list_params)
      render json: @list
    end

    def destroy
      return access_denied unless owner?
      @list.destroy
      render json: { status: :success }
    end

    def assign_members
      return access_denied unless owner?
      @list.assign_members(member_params)
      render json: { status: :success }
    end

    def unassign_members
      return access_denied unless owner?
      @list.unassign_members(member_params)
      render json: { status: :success }
    end

    def list_members
      render json: @list.members
    end

    private

    def list_params
      params.permit(:title)
    end

    def set_list
      @list = List.find(params[:id])
    end

    def owner?
      @list.owner?(current_user.id)
    end

    def member_params
      params.require(:members)
    end
  end
end
