class TodosController < ApplicationController

  before_filter :authenticate_user!

  # GET /todos
  # GET /todos.json
  def index
    # these two at the top because they both return an ActiveRecord Object
    @todos = Todo.where(:user_id => current_user.id)
    @todos = @todos.paginate(:page => params[:page], :per_page => 5)
    
    # the following returns an Array
    @todos = @todos.find(:all, :include => :category, :order => "categories.priority")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    params[:todo][:user_id] = current_user.id
    @todo = Todo.new(params[:todo].except(:category))

    handle_category(params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def handle_category(params)
    my_category = Category.where(params[:todo][:category])

    if my_category.count > 0
      unless @todo.category.map(&:id).include?(my_category[0].id)
        @todo.category = my_category[0]
      end
    else
      @todo.category = Category.create(params[:todo][:category])
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])
    params[:todo][:user_id] = current_user.id
    respond_to do |format|
      if @todo.update_attributes(params[:todo].except(:category)) && @todo.category.update_attributes(params[:todo][:category])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end
end
