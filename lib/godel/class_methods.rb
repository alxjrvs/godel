module ClassMethods
  def completes(*args)
    args.map(&:to_sym).each {|arg| _incomplete_attrs << arg}
  end
  alias_method :incomplete_without, :completes

  def completes_method(method)
    _incomplete_methods << method.to_sym
  end
  alias_method :incomplete_unless, :completes_method


  private

end
