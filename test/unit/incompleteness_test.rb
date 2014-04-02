require_relative '../test_helper'

class IncompletenessTest < MiniTest::Unit::TestCase

  def test_that_included_models_respond_to_methods
    assert @test_class.respond_to? :incomplete?
    assert @test_class.respond_to? :complete?
  end

  def test_that_incomplete_models_report_correctly
    assert @test_class.incomplete?, "Freshly created model with no attributes should be incomplete"
    refute @test_class.complete?, "Freshly created models with no attributes should not be complete"
  end

  def test_that_incomplete_models_may_be_made_complete
    assert @test_class.incomplete?, "Model is new and has no attributes, should be incomplete."
    @test_class.update_attributes(foo: "foo", baz: "baz", pug: 52, stuff: 666)
    assert @test_class.complete?, "Model has satisfied the given avenues of completeness, and should be complete"
  end

  def setup
    @test_class = TestClass.create
  end

  def teardown
    TestClass.destroy_all
  end

end
