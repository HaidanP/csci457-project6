# Part 3 — Measure and improve code coverage

Line coverage measures the proportion of executable lines that ran during a test run. A covered line can still contain a bug. Use the report to find behavior your scenarios leave untested, then add assertions about what users should observe.

## Enable SimpleCov

Add this gem inside the existing `:test` group in `Gemfile`, then run `bundle install`.

```ruby
gem "simplecov", require: false
```

In `features/support/env.rb`, put the following immediately above `require 'cucumber/rails'`. This starts coverage before Cucumber boots Rails and loads the application. Keep the existing Cucumber and database setup below it.

```ruby
require "simplecov"

SimpleCov.start "rails" do
  track_files "app/**/*.rb"

  # This project does not use WebSockets, background jobs, or mail.
  add_filter %r{/app/(channels/application_cable/(channel|connection)|jobs/application_job|mailers/application_mailer)\.rb$}
end
```

Run the entire Cucumber suite and open `coverage/index.html` in your browser. Use the overall **line coverage** reported by the Rails profile for the full suite. A run of a single feature is useful for debugging, but use a fresh full-suite run for the final report.

## Reach 90% line coverage

For full credit on the coverage portion, reach at least **90% line coverage**. Click a file in the report to see uncovered lines. Look for behaviors you can exercise with a meaningful assertion. For example, use the new-movie form and confirm the saved movie appears, or delete a movie and confirm it is gone from the list. Build each scenario's own test data so it works independently.

The Rails controller also has response branches for things such as unsuccessful saves and JSON requests. Use the report to decide what needs attention. Keep the report configuration consistent and rerun the full suite after adding tests.

```sh
bundle exec cucumber
```

[SimpleCov documentation](https://github.com/simplecov-ruby/simplecov)

Next [Part 4 — Submit the project](Part-4--Submission.md).
