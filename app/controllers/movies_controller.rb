class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[ show edit update destroy ]
  before_action :search
  # GET /movies or /movies.json
  def index

    if params.include?(:release_date)
      @movies=Movie.filter_by_date(params[:release_date])
    else
      @movies=@q.result
    end

  end

  # GET /movies/1 or /movies/1.json
  def show

    @rating=Rating.new
    @review=Review.new

    default_ratings = Hash[(1..5).reverse_each.map { |n| [n, 0] }]
    @ratings = default_ratings.merge @movie.ratings.group(:star).count
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
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
      params.require(:movie).permit(:name, :release_date)
    end

  def search
    @q=Movie.ransack(params[:q])
  end
end
