class Movie < ApplicationRecord
  belongs_to :director

  scope :ordered, -> { order(rating: :desc) }

  # def self.search_by_title_and_synopsis(term)
  #   sql_query = "title ILIKE :query OR synopsis ILIKE :query"
  #   ordered.where(sql_query, query: "%#{term}%")
  # end

  # def self.search_movies_and_director(term)
  #   sql_query = " \
  #       movies.title ILIKE :query \
  #       OR movies.synopsis ILIKE :query \
  #       OR directors.first_name ILIKE :query \
  #       OR directors.last_name ILIKE :query \
  #     "
  #     joins(:director).where(sql_query, query: "%#{term}%")
  # end

  # def self.full_search(term)
  #   sql_query = " \
  #       movies.title @@ :query \
  #       OR movies.synopsis @@ :query \
  #       OR directors.first_name @@ :query \
  #       OR directors.last_name @@ :query \
  #     "
  #     joins(:director).where(sql_query, query: "%#{term}%")
  # end

  include PgSearch
  multisearchable against: [ :title, :synopsis ]

  pg_search_scope :search_by_title_and_synopsis,
    against: {
      title: 'A',
      synopsis: 'B'
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  pg_search_scope :global_search,
    against: {
      title: 'A',
      synopsis: 'B'
    },
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def category
    "Movie"
  end

  def background_cover
    "background-image: url(#{cover}), #{linear_gradient}"
  end

  private

  def linear_gradient
    "linear-gradient(99deg, #{theme_color} 0%, #{theme_color} 64%, #{lighten_theme_color} 100%);"
  end

  def lighten_theme_color
    theme_color.gsub("1)", '0.8)')
  end
end
