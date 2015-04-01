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

  # def like 
  #   @comment = Comment.find(params[:id])
  #   @comment.likes += 1
  #   @comment.save
  # end
  # could have added a likes column to comments as an integer and did @comment.likes +=1 instead
  # of doing a whole other table

private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
