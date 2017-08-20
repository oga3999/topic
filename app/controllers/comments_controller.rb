class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice:'コメントを投稿しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
  end

  def update
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {redirect_to topic_path(@topic), notice:'コメントを編集しました'}
      else
        format.html {redirect_to topic_path(@topic), alert:'コメントの編集に失敗しました'}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.js{render :index}
      else
        format.html{render :index}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:topic_id, :content)
  end
end
