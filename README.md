# Godel
##Validations, Except they don't do anything.

In Rails apps, it is possible that a model might want another state above 'valid' or 'invalid'. Unreliable inputs may put you in a situation where you can not guarantee the integrity of every entry in your database, but strict validations might cause you to lose fuzzy data.

This gem gives another 'state' about validity, "completeness". A model can require certain attributes or methods to be present in order to be 'complete', giving you another powerful tool when solidfying the integrity of your data.

## Installation

Add this line to your application's Gemfile:

    gem 'godel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install godel

## Usage

include Godel in any model you'd like to measure completeness in.

    include Godel

You can define attributes required for completeness with the 'completes' command. you can also use
"incomplete_without".

    completes :foo, :bar, :baz

You can also define methods required for completeness. In these methods, create a warning (analagous to 'errors' in validations) should it be incomplete.

    completes_method :must_have_name_or_email

    ...

    private

    def must_have_name_or_email
      if name.blank? && email.blank?
        warnings.add(:name_or_email, "Needs either Name or Email")
      end

    end


You can query the completeness of a method with the #complete? or #incomplete? method, and you can see the relevant warnings with the #warnings method. 


    class ReadmeClass
      completes :foo
      completes_method :must_have_bar_over_five

      private

      def must_have_bar_over_five
        if bar < 5
          warnings.add(:bar_over_five, "Bar must be > 5")
        end
      end
    end

    readme = ReadmeClass.create
    readme.incomplete?
      # => true
    readme.warnings
      # => #<Godel::Warnings::0x007efc7f7b11a0 @messages={:foo => "ReademeClass is incomplete without foo", :bar_over_five => "Bar must be > 5"}

    readme.update_attributes(foo: "Foo")

    readme.incomplete?
      # => true
    readme.warnings
      # => #<Godel::Warnings::0x007efc7f7b11a0 @messages={:bar_over_five => "Bar must be > 5"}

    readme.update_attributes(bar: 6)

    readme.incomplete?
      # => false
    readme.warnings
      # => #<Godel::Warnings::0x007efc7f7b11a0 @messages={}

    readme.complete?
      #=> true

## Development Goals

  - api matching rails validation syntax
  - decouple from rails (allow completeness on PORO's)

## Contributing 

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
[MIT](http://opensource.org/licenses/MIT)

## Special Thanks
Special thanks to [Terrible Labs](http://www.terriblelabs.com) and [The District Management Council](http://www.dmcouncil.org/), for providing solutions and problems, respectively.

