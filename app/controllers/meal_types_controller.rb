class MealTypesController < ApplicationController
  before_action :set_meal_type, only: %i[ show edit update destroy ]

  # GET /meal_types or /meal_types.json
  def index
    @meal_types = MealType.all
  end

  # GET /meal_types/1 or /meal_types/1.json
  def show
  end

  # GET /meal_types/new
  def new
    @meal_type = MealType.new
  end

  # GET /meal_types/1/edit
  def edit
  end

  # POST /meal_types or /meal_types.json
  def create
    @meal_type = MealType.new(meal_type_params)

    respond_to do |format|
      if @meal_type.save
        format.html { redirect_to meal_type_url(@meal_type), notice: "Meal type was successfully created." }
        format.json { render :show, status: :created, location: @meal_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_types/1 or /meal_types/1.json
  def update
    respond_to do |format|
      if @meal_type.update(meal_type_params)
        format.html { redirect_to meal_type_url(@meal_type), notice: "Meal type was successfully updated." }
        format.json { render :show, status: :ok, location: @meal_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_types/1 or /meal_types/1.json
  def destroy
    @meal_type.destroy

    respond_to do |format|
      format.html { redirect_to meal_types_url, notice: "Meal type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_type
      @meal_type = MealType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_type_params
      params.require(:meal_type).permit(:name, :color, :price)
    end
end
