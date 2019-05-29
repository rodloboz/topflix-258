class SearchesController < ApplicationController
  # def show
  #   # if user doesnt provide search term
  #   if params[:search][:query].empty?
  #     @movies = Movie.ordered
  #   else
  #   # show all
  #     @movies = Movie.ordered.where(title: params[:search][:query])
  #   end
  # end

  # def show
  #   if params[:search][:query].empty?
  #     @movies = Movie.ordered
  #   else
  #     @movies = Movie.ordered.where("title ILIKE ?", "%#{params[:search][:query]}%")
  #   end
  # end

  # def show
  #   if params[:search][:query].present?
  #     @movies = Movie.search_by_title_and_synopsis(params[:search][:query])
  #   else
  #     @movies = Movie.ordered
  #   end
  # end

  # def show
  #   term = params[:search][:query]
  #   if term.empty?
  #     @movies = Movie.ordered
  #   else
  #     @movies = Movie.search_movies_and_director(term)
  #   end
  # end

  # def show
  #   term = params[:search][:query]
  #   if term.empty?
  #     @movies = Movie.ordered
  #   else
  #     @movies = Movie.full_search(term).ordered
  #   end
  # end

  # def show
  #   term = params[:search][:query]
  #   if term.empty?
  #     @movies = Movie.ordered
  #   else
  #     # @movies = Movie.search_by_title_and_synopsis(term)
  #     @movies = Movie.global_search(term)
  #   end
  # end

  def show
    term = params[:search][:query]
    if term.empty?
      @movies = Movie.ordered
    else
      # @movies = Movie.search_by_title_and_synopsis(term)
      @movies = PgSearch.multisearch(term).map(&:searchable)
    end
  end
end















