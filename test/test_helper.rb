require 'rubygems'

using_git = File.exist?(File.expand_path('../../.git/', __FILE__))
require 'bundler/setup' if using_git

require File.expand_path('../../lib/godel.rb', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'active_record'
require 'byebug'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :test_classes, force: true do |t|
    t.string :foo
    t.string :baz
    t.integer :pug
    t.integer :stuff
  end

end
class TestClass < ActiveRecord::Base
  include Godel

  complete_with :foo, :baz
  complete_if :either_pug_or_stuff

  private

  def either_pug_or_stuff
    if pug.blank? && stuff.blank?
      warnings.add(:pug_or_stuff, "Needs either Pug or Stuff to be complete")
    end
  end
end




