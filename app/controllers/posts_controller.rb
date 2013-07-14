class PostsController < ApplicationController

  http_basic_authenticate_with name: ENV["ADDSPICE_USERNAME"], password: ENV["ADDSPICE_PASSWORD"], except: [:index, :show]
 
  def index
    @post = Post.limit(3).order("created_at DESC")
  end
  
  
  def new
    @post = Post.new
  end
 
    def create
    @post = Post.new(params[:post].permit(:title, :text, :tag_list))
 
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end
  
  
  def show
    @post = Post.find(params[:id])
  end
  
  
  def edit
    @post = Post.find(params[:id])
  end
  
  
  def update
    @post = Post.find(params[:id])
 
    if @post.update(params[:post].permit(:title, :text, :tag_list))
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
 
    redirect_to posts_path
  end

#This new approach below prevents an attacker from setting the model's attributes by manipulating the hash passed to the model. 
  private
    def post_params
      params.require(:post).permit(:title, :text, :tag_list)
    end

end




