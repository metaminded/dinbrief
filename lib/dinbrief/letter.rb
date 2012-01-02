# encoding: utf-8

module Dinbrief

  class Letter < Prawn::Document

    def self.letter(*args)
      Dinbrief::Letter.generate(*args) do |letter|
        puts letter.class
        yield(letter.letter_builder)
        letter.methods.map(&:to_s).select{|m|m.start_with?("typeset_")}.each do |m|
          puts(m)
          letter.send(m)
        end
      end
    end

    def letter_builder()
      @letter_builder ||= LetterBuilder.new(self)
    end

    def lb_get(nam)
      @letter_builder.instance_variable_get("@#{nam}")
    end
  end
end


require 'dinbrief/letter/constants'
require 'dinbrief/letter/typeset_methods'
