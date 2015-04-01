class CommentsController < ApplicationController

  def index
    @comment = Comment.new
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.js   {}
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "index" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def liked
    @comment = Comment.find(params[:id])
    @comment.likes.create
    respond_to do |format|
        format.js   {}
        format.json { render json: @comment, status: :created, location: @comment }

    end
  end

private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
