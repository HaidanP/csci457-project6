#Haidan Parajuli csci 457

class AddDirectorToMovies < ActiveRecord::Migration[8.1]
  #nullable on purpose so older movies and the project 5 data still save fine
  def change
    add_column :movies, :director, :string
  end
end
