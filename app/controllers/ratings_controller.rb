class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update destroy ]
  before_action :must_sign_in, except: [:index, :user_rating]

  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  def user_rating
    @all_ratings = Rating.all.includes(:user).where(meal_id: params[:id])
    @average_score = @all_ratings.sum(&:score) / @all_ratings.count.to_f if @all_ratings.count > 0
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
      @all_ratings = Rating.all.includes(:user).where(meal_id: @rating.meal_id).to_a.push(@rating).uniq(&:id).sort_by(&:updated_at)
      @average_score = @all_ratings.sum(&:score) / @all_ratings.count.to_f
      render partial: "ratings/user_rating", layout: false
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    can_edit

    if @rating.update(rating_params)
      @all_ratings = Rating.all.includes(:user).where(meal_id: @rating.meal_id).to_a.push(@rating).uniq(&:id).sort_by(&:updated_at)
      @average_score = @all_ratings.sum(&:score) / @all_ratings.count.to_f
      render partial: "ratings/user_rating", layout: false
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    can_edit

    @rating.destroy
    @rating = Rating.new(meal_id: @rating.meal_id, user_id: current_user&.id)
    @all_ratings = Rating.includes(:user).where(meal_id: @rating.meal_id).to_a.uniq(&:id).sort_by(&:updated_at)
    @average_score = @all_ratings.sum(&:score) / @all_ratings.count.to_f if @all_ratings.count > 0
    render partial: "ratings/user_rating", layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:meal_id, :score).merge(user_id: current_user&.id)
    end

    def can_edit
      unless @rating.user == current_user
        redirect_to root_path, notice: "You can only edit your own ratings."
      end
    end

    def set_average_score
      @average_score = Rating.where(meal_id: @rating.meal_id).average(:score)
    end
end
