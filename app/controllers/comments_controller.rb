class CommentsController < ApplicationController
  def create
    #takes newely created comment.id and matches it with post_id in the Post model
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:comment))

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

end
