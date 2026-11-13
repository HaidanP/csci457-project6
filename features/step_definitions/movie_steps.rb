# Create scenario data directly; these features test filtering and sorting,
# rather than the interface for adding movies.
Given(/^the following movies exist:$/) do |movies_table|
  movies_table.hashes.each do |movie_attributes|
    Movie.create!(movie_attributes)
  end
end

Then(/^(\d+) seed movies should exist$/) do |number_of_movies|
  expect(Movie.count).to eq(number_of_movies.to_i)
end

# Check rendered list text rather than HTML elsewhere on the page.
Then(/^I should see "([^"]*)" before "([^"]*)" in the movie list$/) do |first_title, second_title|
  movie_list = find('#movies')
  expect(movie_list).to have_content(first_title)
  expect(movie_list).to have_content(second_title)

  list_text = movie_list.text
  first_position = list_text.index(first_title)
  second_position = list_text.index(second_title)

  expect(first_position).not_to be_nil
  expect(second_position).not_to be_nil
  expect(first_position).to be < second_position
end

# Checking these ratings deliberately leaves other checkboxes unchanged.
When(/^I check the following ratings: (.+)$/) do |rating_list|
  rating_list.split(',').each do |rating|
    check(rating.strip)
  end
end

# Both positive and negative assertions are restricted to the movie list.
Then(/^I should (not )?see the following movies: (.+)$/) do |negation, movie_list|
  within('#movies') do
    movie_list.split(',').each do |title|
      if negation
        expect(page).not_to have_content(title.strip)
      else
        expect(page).to have_content(title.strip)
      end
    end
  end
end

Then(/^I should see all the movies$/) do
  # Avoid a vacuous pass if a future scenario forgets to create its data.
  expect(Movie.count).to be > 0

  within('#movies') do
    Movie.all.each do |movie|
      expect(page).to have_content(movie.title)
    end
  end
end
