class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])

  end

  def index
    @movies = Movie.all
    @movies.sort_by!(&:title)
    #@movies = Movie.find(:all, :order => "title")
  end

  def new
    # default: render 'new' template
  end

  def create
     if params[:commit] == "Cancel"
      redirect_to movies_path
    else
  	  @movie = Movie.create!(params[:movie])
  	  flash[:notice] = "#{@movie.title} was successfully created."
  	  redirect_to movie_path(@movie)
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if params[:commit] == "Cancel"
      redirect_to movie_path(@movie)
    else
  	  @movie.update_attributes!(params[:movie])
  	  respond_to do |client_wants|
    	  client_wants.html do
      	  flash[:notice] = "#{@movie.title} was successfully updated."
      	  redirect_to movie_path(@movie)  
    	  end
    	  client_wants.xml  {  render :xml => @movie.to_xml    }
  	  end
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
