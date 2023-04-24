# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_rating, only: %i[show edit update destroy]
  before_action :set_movie, only: %i[create update edit]

  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1 or /ratings/1.json
  def show; end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit; end

  # POST /ratings or /ratings.json
  def create
    @rating = @movie.ratings.new(rating_params)
    @rating.user = current_user

    respond_to do |format|
      if @rating.save
        format.js { flash[:notice] = 'Rating was successfully added.' }
        format.html { redirect_to movie_url(@movie), notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @rating }
      else
        format.js
        format.html { redirect_to movie_url(@movie), status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update

    respond_to do |format|
      if @rating.update(rating_params)
        format.js { flash[:notice] = 'Rating was successfully updated.' }
        format.html { redirect_to movie_path(@movie), notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.js
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rating
    @rating = Rating.find(params[:id])
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  # Only allow a list of trusted parameters through.
  def rating_params
    params.require(:rating).permit(:star, :movie_id, :user_id)
  end
end
