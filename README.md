# Project 6 — Use BDD to add a feature to RottenPotatoes

In Project 5, you wrote Cucumber scenarios for filtering and sorting behavior that already existed. In this project, you'll start with failing scenarios and use them to guide a new feature. A user should be able to record a movie's director and find other movies by that director. If the director is unknown, the app should return the user to the movie list with a helpful message.

Work in short cycles. Run one scenario, read its first failure, make the smallest change that addresses it, and run it again. Keep the Project 5 scenarios as regression tests.

## Set up the project

1. Start with the canonical **Project 5 solution** provided in this archive, or use your own. Open a terminal in the app root, where `Gemfile` and `bin/rails` live.
2. Keep the existing `features/` directory and Cucumber setup. You will need the `features/movies_by_director.feature` distributed with these instructions. Use the Project 5 definitions in `movie_steps.rb` and `web_steps.rb`.
3. Install the bundled dependencies and prepare both local SQLite databases.

   ```sh
   ruby -v
   bundle config set --local without production
   bundle install
   bin/rails db:prepare
   RAILS_ENV=test bin/rails db:migrate
   ```
4. Confirm the original Project 5 scenarios pass.

   ```sh
   bundle exec cucumber features/filter_movie_list.feature features/sort_movie_list.feature
   ```

5. Copy the director feature into `features/` if it is not already there, then run it by itself.

   ```sh
   bundle exec cucumber features/movies_by_director.feature
   ```

   Expect a failure in the Background. Read the first exception and identify which movie attribute the test data provides that your database does not yet support. 

For a manual check, start `bin/rails server` and open <http://localhost:3000/movies>. If an existing development database has no movies, run `bin/rails db:seed` first. Cucumber uses the test environment and runs without a separate server or browser for these scenarios.

## Parts

1. [Add a director field to movies](docs/Part-1--Add-a-Director-field-to-Movies.md)
2. [Use acceptance tests to implement the new behavior](docs/Part-2--Use-Acceptance-Tests-to-get-new-scenarios-passing.md)
3. [Measure and improve code coverage](docs/Part-3--Code-Coverage.md)
4. [Submit the project](docs/Part-4--Submission.md)
