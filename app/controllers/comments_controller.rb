class CommentsController < ApplicationController

  def index
    comments = Comment.all
  end

  def show
    comment = Comment.find_by(id: parms[:id])
    if comment
      render json: comment
    else
      render json: { error: 'Comment not found from SHOW server.' }, status: 404
    end
  end

  def create
    comment = Comment.new(comment: parms[:comment])
    if comment.save
      render json: comment
    else
      render json: { error: "comment can not generate from CREATE" }, status: 400
    end
  end

  def update
    comment = Comment.find(parms[:id])
    comment.update(comment: params[:comment])
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

end
