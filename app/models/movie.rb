class Movie < ApplicationRecord
  def self.all_ratings
    # Return unique ratings from the database, sorted alphabetically
    distinct.pluck(:rating).sort
  end

  def self.with_ratings(ratings)
    return all unless ratings.present?   # do nothing if no valid ratings given
    where(rating: ratings)
  end
end
