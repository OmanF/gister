# Gister

## What?

Yet another GitHub Gist API library.

## Configuration

All relevant configuration is done via the `config.exs` file:
* If no `User-agent` is required, pass in an empty list, `[]`.
* The `parse_response` default option controls whether the response will be pretty-printed to the console or not.
  *  Note that, due to `IO.puts` result of `:ok`, when this options is on, the responses **can't** be piped further.
  * As a result, this option is better used in interactive, REPL usage (for example, to ease debugging).
* The `auth_method` can be set to either `:basic` or `:token`.
  * Note that **any** other value is interperted as *no authorization required*.
* To get the same logging scheme as in the repository, need to create the `log` folder and the files inside it, as well as setting the `config.exs` and `loggix.exs` files like in the repository.

## Thanks

* The structure and implementation of this library were inspired by [Gistex](https://github.com/MrYawe/gistex).
* Of course, check out `mix.exs` to view dependencies packages, without which this library would not exist.

#### Reminder to self

Not exceedingly complex, structure-wise, a lot of work has been put into this, so, this is a keeper.
