# Fatbundle

Create a single fat bundle with all your gem dependencies in one Ruby script.

Turns out, this is mostly what `bundle install --standalone` does already, except that fatbundle creates a single executable, whereas bundler creates a directory with files in it. Read more about the bundler standalone mode at [Andre Arko's blog](http://andre.arko.net/2014/06/27/rails-in-05-seconds/).


## Installation

Do not add this gem to your bundle, instead install it globally and run it like a regular command. Fatbundle will automatically load Bundler for you to load your gem dependencies.

    $ gem install fatbundle

## Usage

Create your script and describe dependencies as a regular applicaiton in `Gemfile`, and then run `bundle install`.

    $ bundle install

Now you can run `fatbundle` to package your file and all gem dependencies.

    $ fatbundle script.rb > script.packed.rb

The generated file contains all the gem files in pure Ruby with an embedded bootstrap loader, so you don't need any gems or even bundler to run on the other computer. You just need a Ruby runtime.

## Limitation

Gems with C-extension cannot be packaged properly, so they'll be ignored with warnings.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/miyagawa/fatbundle.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Author

Tatsuhiko Miyagawa

## Acknowledgements

This gem is inspired by [FatPacker](https://metacpan.org/pod/App::FatPacker) for CPAN and FatJar for Java. Initial prototype was coded during lunch at RubyConf 2015 with yoshiori and k0kubun.
