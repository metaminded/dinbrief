# encoding: utf-8

module Dinbrief

  class Letter < Prawn::Document

    def self.letter(*args)
      self.generate(*args) do |letter|
        yield(letter.letter_builder)
        letter.draw_info
        letter.draw_return_address
        letter.draw_address
        letter.draw_body
      end
    end

    attr_accessor :letter_builder

    def initialize(opts={})
      super(DocumentDefaults.merge(opts))
      @letter_builder = LetterBuilder.new(self)
    end

    def lb_get(nam)
      @letter_builder.instance_variable_get(nam)
    end
  end
end


require 'dinbrief/version'
require 'dinbrief/constants'
require 'dinbrief/letter_builder'
require 'dinbrief/draw_methods'
