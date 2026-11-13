# Part 1 — Add a director field to movies

The first failure should come from the Background in `features/movies_by_director.feature`. The Project 5 step uses `Movie.create!` to load each row. The new rows supply a `director` attribute, which the existing movies table does not have.

1. Generate a migration that adds a string column named `director` to `movies`.

   ```sh
   bin/rails generate migration AddDirectorToMovies director:string
   ```

2. Read the generated file under `db/migrate/`. Check that it adds the intended column. Keep director optional so existing movies and the Project 5 test data remain valid.
3. Apply the migration in development and test.

   ```sh
   bin/rails db:migrate
   RAILS_ENV=test bin/rails db:migrate
   ```

4. Rerun the director feature.

   ```sh
   bundle exec cucumber features/movies_by_director.feature
   ```

The Background should now create the movies successfully. Active Record reads the table schema, so adding the column makes the attribute available on `Movie` records. The next failures should be farther into the scenarios. For example, the existing `path_to` helper does not yet recognize a movie's edit or details page by title.

Keep the migration and the generated update to `db/schema.rb` with your work.

Next [Part 2 — Use acceptance tests to implement the new behavior](Part-2--Use-Acceptance-Tests-to-get-new-scenarios-passing.md).
