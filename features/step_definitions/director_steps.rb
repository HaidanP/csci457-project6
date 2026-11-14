#Haidan Parajuli csci 457

#goes back to the db instead of trusting the page so we know the update really got saved
Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |title, director|
  expect(Movie.find_by!(title: title).director).to eq(director)
end
