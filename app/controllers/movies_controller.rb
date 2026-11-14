#Haidan Parajuli csci 457

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy similar ]

  # GET /movies or /movies.json
  def index
    # All possible ratings
    @all_ratings = Movie.all_ratings

    # --- Step 1: Check for new filter/sort params ---
    ratings_param = params[:ratings]
    sort_param    = params[:sort_by]

    # --- Step 2: Handle first-time or plain visits (no params) ---
    if ratings_param.nil? && sort_param.nil?
      # If we have session values, redirect using them
      if session[:ratings] || session[:sort_by]
        redirect_to movies_path(
          ratings: session[:ratings],
          sort_by: session[:sort_by]
        ) and return
      else
        # Nothing in session yet → default to showing all
        @ratings_to_show = @all_ratings
        @sort_by = nil
      end
    else
      # --- Step 3: Params were provided (user interaction) ---
      @ratings_to_show = ratings_param&.keys || @all_ratings
      @sort_by = sort_param

      # Store the current settings in session for later
      session[:ratings] = ratings_param
      session[:sort_by] = sort_param
    end

    # --- Step 4: Build the query ---
    @movies = Movie.with_ratings(@ratings_to_show)
    @movies = @movies.order(@sort_by) if @sort_by.present?
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  #GET /movies/1/similar
  #bounces back to the list with a notice if there's nothing to match on
  def similar
    if @movie.director_missing?
      redirect_to movies_path, notice: "'#{@movie.title}' has no director info"
    else
      @movies = @movie.others_by_same_director
    end
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
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @movie.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @movie.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path, status: :see_other, notice: "Movie was successfully destroyed." }
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
      params.require(:movie).permit(:title, :rating, :description, :director, :release_date)
    end
end
