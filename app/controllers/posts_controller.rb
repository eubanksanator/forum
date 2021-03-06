class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all.order('created_at DESC')
  end


  def show
  end


  def new
    @post = current_user.posts.new
  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      redirect_to root_path
    end
  end


  def edit
  end


  def update
    if @post.update(post_params)
      redirect_to (@post)
    else
      render 'edit'
    end
  end


  def destroy
    @post.destroy

    redirect_to root_path
  end

  def upvote
    @post = Post.find(params[:id])
    @post.liked_by current_user
    redirect_to posts_path
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_from current_user
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
