# Part 2 — Use acceptance tests to implement the new behavior

The director feature has two success scenarios and one scenario for missing data. Focus on one scenario at a time. Use its name or the line number of its `Scenario:` line to select it.

```sh
bundle exec cucumber features/movies_by_director.feature --name 'add director to existing movie'
```

## Edit a movie's director

1. Find the existing `I go to` definition in `features/step_definitions/web_steps.rb`. It calls `path_to` in `features/support/paths.rb`. Extend that helper to recognize the edit and details page phrases in the director feature. Look up the movie by its exact title and use the Rails route helpers. Preserve the mappings used by Project 5.
2. Add a labeled **Director** field to the shared movie form, `app/views/movies/_form.html.erb`. Keep the scaffold's existing **Update Movie** submit button. The revised scenario uses that label.
3. Allow `:director` in the controller's `movie_params` so both `create` and `update` can save it. Show the saved director on the details page. The details view already renders `_movie.html.erb`, which is also used on the index. Decide whether to show director in that shared partial or on the details page alone.
4. Implement the step that checks the saved director. Add the step in a new file such as `features/step_definitions/director_steps.rb`. Requery the movie by title and assert the saved value. The following step checks that the user sees the director on the details page.

## Find other movies by the same director

From the details page, the user follows **Find Movies With Same Director**. The new page lists other movies with the same director. Exclude the current movie and movies by other directors.

- Add a GET member route under `resources :movies` in `config/routes.rb`. For example, `GET /movies/:id/similar` lets the action identify the source movie. Check the actual helper with `bin/rails routes -g similar`.
- Add the link to `app/views/movies/show.html.erb`. Connect it to the new action. The controller already has a `set_movie` callback for some member actions. If your action uses it, add the new action to the callback's list.
- Put the query for matching movies in the `Movie` model. A method on a movie instance or a class method can work. The controller calls it and passes the results to a new view. Use the database to match director values and exclude the source movie by ID.
- Extend `path_to` to recognize the Similar Movies page phrase. Use the named route helper. Give the results page a **Similar Movies** heading and display the matching titles.
- Run this scenario and check both the included and excluded movies. Scope the title checks to the results list if you add other page content that could mention those titles.

See [Adding member routes in the Rails Routing Guide](https://guides.rubyonrails.org/v8.1/routing.html#adding-member-routes).

## Handle a movie without a director

Keep the same link available for a movie with missing director information. In the new action, treat a nil, empty, or whitespace-only director as missing. Redirect to the movies list and show the message in the scenario. The index already renders `notice`, so you can pass the message as a redirect notice.

Run the whole suite to check the new behavior and the original filtering and sorting behavior.

```sh
bundle exec cucumber
```

Next [Part 3 — Measure and improve code coverage](Part-3--Code-Coverage.md).
