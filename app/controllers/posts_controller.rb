class PostsController < ApplicationController

  http_basic_authenticate_with name: ENV["ADDSPICE_USERNAME"], password: ENV["ADDSPICE_PASSWORD"], except: [:index, :show]
 
  def index
    @posts = Post.all.reverse
  end
  
  
  def new
    @post = Post.new
  end
 
  
  def create
    @post = Post.new(params[:post].permit(:title, :text))
 
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
 
    if @post.update(params[:post].permit(:title, :text))
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
      params.require(:post).permit(:title, :text)
  end

end




