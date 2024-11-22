# BlackFriday

Add Black Friday sales to your Rails app.

[![Ruby](https://github.com/excid3/black_friday/actions/workflows/main.yml/badge.svg)](https://github.com/excid3/black_friday/actions/workflows/main.yml)

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add black_friday
```

## Usage

### Date helpers

Black Friday provides some helpers for dates. You can also pass in the year which can be helpful for making reports for previous years.

```ruby
BlackFriday.thanksgiving #=> Thu, 28 Nov 2024
BlackFriday.black_friday #=> Fri, 29 Nov 2024
BlackFriday.cyber_monday #=> Mon, 2 Dec 2024

BlackFriday.thanksgiving(2029) #=> Thu, 22 Nov 2029
```

### Adding Sales

Sales are handy to set the date/time range for a sale. The `add_sale` block should return a `Range`.

```ruby
BlackFriday.add_sale do
  thanksgiving.monday.beginning_of_day..cyber_monday.end_of_day
end

BlackFriday.add_sale :labor_day do
  # First Monday in September
  sep_1st = Date.new(Date.today.year, 9, 1)
  labor_day = sep_1st.monday? ? sep_1st : sep_1st.next_occurring(:monday)
  start_day = labor_day - 3.days

  start_day.beginning_of_day..labor_day.end_of_day
end
```

You can then check if a sale is active:

```ruby
BlackFriday.active?
#=> true/false

# Or specific sale(s)
BlackFriday.active?(:black_friday, :labor_day)
#=> true/false
```

To check the active sales:

```ruby
BlackFriday.current_sale #=> :black_friday

# For multiple sales at once
BlackFriday.current_sales #=> [:black_friday]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/black_friday. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/black_friday/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BlackFriday project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/black_friday/blob/main/CODE_OF_CONDUCT.md).
