class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topics,only:[:show, :updata, :destroy, :edit]

  def index
    @topics = Topic.all
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
  end

  def new
    if params[:back]
      @topic = Topic.new(topic_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path,notice:"topicを投稿しました！"
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice:"topicを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice:"topicを削除しました！"
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :content)
  end

  def set_topics
    @topic = Topic.find(params[:id])
  end
end
