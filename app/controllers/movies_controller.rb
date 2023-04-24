# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :search
  # GET /movies or /movies.json
  def index
    @movies = if params.include?(:release_date) && (params[:release_date] != '')
                Movie.filter_by_date(params[:release_date]).paginate(page: params[:page])
              else
                @q.result.paginate(page: params[:page])
              end
  end

  # GET /movies/1 or /movies/1.json
  def show
    @review = Review.new
    @reviews = @movie.reviews.includes(:user)
    @rating = current_user.ratings.find_by(movie_id: @movie.id) || Rating.new(movie: @movie)
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)
    respond_to do |format|
      if @movie.save
        format.js { flash[:notice] = 'Movie was successfully created.' }
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.js { flash[:notice] = 'Movie was successfully updated.' }
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.js
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.js { flash[:notice] = 'Movie was successfully deleted.' }
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:name, :release_date, :image)
  end

  def search
    @q = Movie.ransack(params[:q])
  end
end
