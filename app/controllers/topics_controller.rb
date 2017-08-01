class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topics,only:[:show, :updata, :destroy, :edit]

  def index
    @topics = Topic.all
  end

  def show
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
    if @topic.save
      redirect_to topics_path,notice:"topicを投稿しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def updata
    if @topic.updata(topic_params)
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
