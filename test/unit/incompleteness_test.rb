require_relative '../test_helper'

class IncompletenessTest < MiniTest::Unit::TestCase

  def test_that_included_models_respond_to_methods
    byebug
    assert test_class.respond_to? :incomplete?
    assert test_class.respond_to? :complete?
  end

  def test_that_incomplete_models_report_correctly
    byebug
    assert test_class.incomplete?, "Freshly created model with no attributes should be incomplete"
    refute test_class.complete?, "Freshly created models with no attributes should not be complete"
  end

  def test_class
    @_test_class ||= TestClass.create
  end
end
