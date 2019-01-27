module V1
  class CardsController < ApplicationController
    before_action :set_list, :check_accessibility
    before_action :set_card, only: %I[show update destroy]

    include CardDoc
    def index
      cards = @list.cards.where(user_id: current_user.id)
      render json: cards.order(comments_count: :desc)
    end

    def show
      render json: { card: @card, comments: @card.comments.order(created_at: :asc).limit(3) }
    end

    def create
      card = current_user.cards.new(card_params)
      card.list_id = @list.id
      card.save!
      render json: card
    end

    def update
      return access_denied unless @card.owner?(current_user.id)
      @card.update(card_params)
      render json: @card
    end

    def destroy
      return access_denied unless @card.owner?(current_user.id) || @list.owner?(current_user.id)
      @card.destroy
      render json: { status: :success }
    end

    private

    def set_list
      @list = List.find(params[:list_id])
    end

    def check_accessibility
      return access_denied unless @list.showable?(current_user.id)
    end

    def set_card
      @card = @list.cards.find(params[:id])
    end

    def card_params
      params.permit(:title, :description)
    end
  end
end
