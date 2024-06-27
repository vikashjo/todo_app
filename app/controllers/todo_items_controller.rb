class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, only: %i[ show edit update destroy ]

  # GET /todo_items or /todo_items.json
  def index
    @todo_items = @todo_list.todo_items
  end

  # GET /todo_items/1 or /todo_items/1.json
  def show
    @todo_item = @todo_list.todo_items.where(id: params[:id])
  end

  # GET /todo_items/new
  def new
    @todo_item = @todo_list.todo_items.new
  end

  # GET /todo_items/1/edit
  def edit
  end

  # POST /todo_items or /todo_items.json
  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)

    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to [@todo_list, @todo_item], notice: "Todo item was successfully created." }
        format.json { render :show, status: :created, location: [@todo_list,@todo_item] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1 or /todo_items/1.json
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to [@todo_list, @todo_item], notice: "Todo item was successfully updated." }
        format.json { render :show, status: :ok, location: [@todo_list, @todo_item] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1 or /todo_items/1.json
  def destroy
    @todo_item.destroy!

    respond_to do |format|
      format.html { redirect_to todo_list_todo_items_url(@todo_list), notice: "Todo item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_item_params
      params.require(:todo_item).permit(:description, :completed, :completed_at, :todo_list_id)
    end
end
