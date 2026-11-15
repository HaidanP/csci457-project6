#Haidan Parajuli csci 457

class Movie < ApplicationRecord
  def self.all_ratings
    # Return unique ratings from the database, sorted alphabetically
    distinct.pluck(:rating).sort
  end

  def self.with_ratings(ratings)
    return all unless ratings.present?   # do nothing if no valid ratings given
    where(rating: ratings)
  end

  #true when director is nil, empty or just spaces, blank? covers all three
  def director_missing?
    director.blank?
  end

  #lets the db do the matching on director and drops this movie by id
  def others_by_same_director
    Movie.where(director: director).where.not(id: id)
  end
end
