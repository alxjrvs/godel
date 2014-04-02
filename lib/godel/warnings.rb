module Godel
  class Warnings
    attr_accessor :messages

    def initialize
      @messages = {}
    end

    def values
      messages.values
    end

    def add(symbol, message = nil)
      message ||= "is missing"
      messages[symbol] = message
    end

    def any?
      messages.any?
    end

    def empty?
      messages.empty?
    end

    def blank?
      messages.blank?
    end

    def to_a
      full_messages
    end

    def full_messages
      array = []
      messages.each {|k,v| array << "#{k.to_s.titleize} #{v}"}
    end

    def clear!
      self.messages = {}
    end
  end
end
