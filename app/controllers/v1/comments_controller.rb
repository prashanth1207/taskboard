module V1
  class CommentsController < ApplicationController
    before_action :set_comment, only: %I[show update destroy]

    include CommentDoc
    def index
      comments = Comment.where(commentable_id: params[:resource_id])
      render json: comments.page(params[:page], params[:per_page]).order(created_at: :asc)
    end

    def show
      render json: { comment: @comment, replies: @comment.replies.order(created_at: :asc) }
    end

    def create
      card_or_comment = create_comment
      unless card_or_comment
        return render json: { errors: ['cant find source for the comment'] }, status: :unprocessable_entity
      end
      comment = Comment.new(create_params.merge(user_id: current_user.id))
      comment.save!
      render json: comment
    end

    def update
      return access_denied unless owner?
      @comment.update(update_params)
      render json: @comment
    end

    def destroy
      return access_denied unless owner? || @comment.commented_card.list.owner?(current_user.id)
      @comment.destroy
      render json: { status: :success }
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.permit(:content)
    end

    def create_params
      @create_params ||= params.permit(:content, :commentable_id, :commentable_type)
    end

    def update_params
      params.permit(:content)
    end

    def owner?
      @comment.user_id == current_user.id
    end

    def create_comment
      return unless create_params[:commentable_type]
      klass_name = create_params[:commentable_type].capitalize
      return unless [Card.name, Comment.name].include?(klass_name)
      klass_name.constantize.find(create_params[:commentable_id])
    end
  end
end
