class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
 
  # GET/posts
  # posts/index.html.erb which displays all posts
  def index
    @posts = Post.all
  end

  # GET /posts/new
  # posts/new.html.erb which shows and HTML form to create a new post
  def new
    @post = Post.new
  end

  # POST /posts
  # posts/index.html.erb  
  # This saves information to the database after after new post is created from new.html.erb
  # redirects to index page where new post will appear
  def create
    @post = Post.new(post_params)
 
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new 
    end
  end
 
  # GET /posts/1   
  #posts/show.html.erb
  # this will show an individual post for an newly created or updated post
  # will also contain the comment form to create a new comment and show comments
  def show
    @comment = Comment.new
  end
 
  # GET /posts/1/edit   
  # edit.html.erb
  # This is an HTML form for editing a post
  def edit
  end

 
  # PATCH/PUT /posts/1
  # posts/show.html.erb
  # save the information from edit.html.erb to the database and updates a specific post
  # it will then render the show.html.erb page
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /posts/1
  # posts/show.html.erb
  # The deletes a specific post and removes it from the database
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
 
    # Strong parameters, to only allow specific attributes to be updated and saved to database.
    def post_params
      params.require(:post).permit(:title, :content)
    end
 
end
