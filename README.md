# Mongoid::Trashable

`Mongoid::Paranoia` can be annoying in two main ways, dealing with unique indexes and scoping. This gem serves as an alternative where instead of marking a document as deleted with a `deleted_at` timestamp, a copy of the document is moved into a trash collection. This provides a convenient way to display trashed documents to the user as well - simply render an index page of trash with a button to restore by each.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid-trashable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-trashable

## Usage

```ruby
require 'mongoid/trashable'

class MyModel
  include Mongoid::Document
  include Mongoid::Trashable
  field :name
end

foo = MyModel.create(name: 'Foo')
puts MyModel.unscoped.count # => 1
foo.destroy

puts MyModel.unscoped.count # => 0
puts Mongoid::Trash.count # => 1

trash = Mongoid::Trash.first
trash.restore

puts MyModel.unscoped.count # => 1
puts Mongoid::Trash.count # => 0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mongoid-trashable.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

