class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update destroy ]
  before_action :must_sign_in, except: [:index, :show, :user_rating]
  before_action :must_be_admin, except: [:index, :show, :user_rating]

  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  def user_rating
    @average_score = Rating.where(meal_id: params[:id]).average(:score)
    @rating = Rating.where(user_id: current_user&.id, meal_id: params[:id]).first_or_initialize
    render partial: "ratings/user_rating", layout: false
  end

  # GET /ratings/1 or /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings or /ratings.json
  def create
    @rating = Rating.new(rating_params)

    if @rating.save
      @average_score = Rating.where(meal_id: @rating.meal_id).average(:score)
      render partial: "ratings/user_rating", layout: false
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    if @rating.update(rating_params)
      @average_score = Rating.where(meal_id: @rating.meal_id).average(:score)
      render partial: "ratings/user_rating", layout: false
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to ratings_url, notice: "Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:meal_id, :user_id, :score)
    end
end
