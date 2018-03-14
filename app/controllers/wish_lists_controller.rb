class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:show, :edit, :update, :destroy]

  # GET /wish_lists
  # GET /wish_lists.json
  def index
    @wish_list = WishList.all
    if params[:search]
      @wish_list = WishList.search(params[:search])
    else
      @wish_list = WishList.all
    end
  end
  
  # GET /wish_lists/1
  # GET /wish_lists/1.json
  def show
     @wish_list = WishList.find_by_id(params[:id])
  end

  # GET /wish_lists/new
  def new
    if (!logged_in?)
      flash[:danger] = "Please login or signup to access this feature"
      redirect_to root_path
    end
    @wish_list = WishList.new
  end

  # GET /wish_lists/1/edit
  def edit
    @wish_list = WishList.find(params[:id])
    if (!logged_in?)
      if (@wish_list.user != is_admin)
        if (@wish_list.user != current_user)
          flash[:danger] = "Sorry, you are not allowed this opearation"
          redirect_to root_path
        end
      end
    end
  end

  # POST /wish_lists
  # POST /wish_lists.json
  def create
    @wish_list = WishList.new(wish_list_params)
    @wish_list.save
   #  if (@wish_list.save)    # If validations are successfull
    #  flash[:success] = "Wish_list was successfully added"
     # redirect_to wish_list(@wish_list) ## @book is passed in because book_path (show fn) needs the id (can see in rake routes)
  #  else
   #   render 'new'
  #  end
    respond_to do |format|
      if @wish_list.save
        format.html { redirect_to @wish_list, notice: 'Wish list was successfully created.' }
        format.json { render :show, status: :created, location: @wish_list }
      else
        format.html { render :new }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wish_lists/1
  # PATCH/PUT /wish_lists/1.json
  def update
    respond_to do |format|
      if @wish_list.update(wish_list_params)
        format.html { redirect_to @wish_list, notice: 'Wish list was successfully updated.' }
        format.json { render :show, status: :ok, location: @wish_list }
      else
        format.html { render :edit }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wish_lists/1
  # DELETE /wish_lists/1.json
  def destroy
    @wish_list.destroy
    respond_to do |format|
      format.html { redirect_to wish_lists_url, notice: 'Wish list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish_list
      @wish_list = WishList.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wish_list_params
      params.require(:wish_list).permit(:name, :ISBN, :price)
    end
  end
