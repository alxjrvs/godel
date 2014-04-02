require "godel/version"
require 'godel/warnings'
require 'godel/class_methods'

module Godel
  def self.included(klass)
    klass.extend ClassMethods
    klass.cattr_accessor :_incomplete_methods, :_incomplete_attrs
    klass.after_save :clear_godel_cache
    klass.after_create :clear_godel_cache
    klass._incomplete_methods ||= []
    klass._incomplete_attrs ||= []
  end

  def complete?
    !incomplete?
  end

  def incomplete?
    @_incomplete ||= begin
      return false if _incomplete_attrs.empty? && _incomplete_methods.empty?
        warnings.any?
    end
  end

  attr_accessor :warnings

  def warnings
    @_warnings ||= Warnings.new
  end

  private


  def clear_godel_cache
    @_incomplete = nil
    warnings.clear!
    _filter_incomplete_attributes
    _filter_incomplete_methods
  end

  def _filter_incomplete_attributes
    _incomplete_attrs.each do |attr|
      value = self.send(attr)
      warnings.add(attr, "#{self.class} is incomplete without #{attr}") unless value.present?
    end
  end

  def _filter_incomplete_methods
    _incomplete_methods.each do |method|
      self.send(method)
    end
  end
end
