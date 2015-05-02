class PostsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
  	@post = Post.new
    3.times {@post.images.build}
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    @user = User.find(@post.user_id)
  end

  def index
    @states = State.all
    @cities = City.where("state_id = ?", State.first.id)
    @areas = Area.where("city_id = ?", City.first.id)
	  @posts = current_user.getPosts
  end

  def update_cities
    @cities = City.where("state_id = ?", params[:state_id])
    respond_to do |format|
      format.js
    end
  end

  def update_areas
    @areas = Area.where("city_id = ?", params[:city_id])
    respond_to do |format|
      format.js
    end
  end

  def search 
    #andWords = params[:q].split("\s*").join(".*")
    orWords = params[:q].split("\s*").join("|")
    #@bestResult = Post.where("title REGEXP '#{andWords}'")
    @goodResult = Post.where("title REGEXP '#{orWords}'")
  end

  def locate
  end
  

  def create
  	@post = Post.new(post_params)
    @post.user_id = current_user.id
  	respond_to do |format|
  		if @post.save
  			format.html { redirect_to @post, notice:  'Post was successfully created.' }
  			format.json { render :show, status: :create, location: @post}
  		else 
  			format.html { render :new}
  			format.json { render json: @post.error, status: :unprocessable_entity}
  		end
  	end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit(:title, :description, images_attributes: [:post_id, :picture])
    end
end
