# encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'

module Dinbrief

  def self.letter(*args)
    Letter.letter(*args)
  end

end

puts __FILE__

require 'dinbrief/version'
require 'dinbrief/constants'
require 'dinbrief/letter_builder'
require 'dinbrief/draw_methods'
