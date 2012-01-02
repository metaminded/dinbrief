# encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'

class Dinbrief < Prawn::Document

  def self.letter(*args)
    self.generate(*args) do |letter|
      yield(letter.letter_builder)
      letter.draw_info
      letter.draw_return_address
      letter.draw_address
      letter.draw_body
    end
  end

  attr_reader :letter_builder

  def initialize(opts={})
    super(DocumentDefaults.merge(opts))
    @letter_builder = LetterBuilder.new(self)
  end

  def lb_get(nam)
    @letter_builder.instance_variable_get(nam)
  end
end

puts __FILE__

require 'lib/dinbrief/constants.rb'
require 'lib/dinbrief/letter_builder.rb'
require 'lib/dinbrief/draw_methods.rb'
# encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'

class Dinbrief < Prawn::Document

  def self.letter(*args)
    self.generate(*args) do |letter|
      yield(letter.letter_builder)
      letter.draw_info
      letter.draw_return_address
      letter.draw_address
      letter.draw_body
    end
  end

  attr_reader :letter_builder

  def initialize(opts={})
    super(DocumentDefaults.merge(opts))
    @letter_builder = LetterBuilder.new(self)
  end

  def lb_get(nam)
    @letter_builder.instance_variable_get(nam)
  end
end

puts __FILE__

require 'lib/dinbrief/constants.rb'
require 'lib/dinbrief/letter_builder.rb'
require 'lib/dinbrief/draw_methods.rb'
# encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'

class Dinbrief < Prawn::Document

  def self.letter(*args)
    self.generate(*args) do |letter|
      yield(letter.letter_builder)
      letter.draw_info
      letter.draw_return_address
      letter.draw_address
      letter.draw_body
    end
  end

  attr_reader :letter_builder

  def initialize(opts={})
    super(DocumentDefaults.merge(opts))
    @letter_builder = LetterBuilder.new(self)
  end

  def lb_get(nam)
    @letter_builder.instance_variable_get(nam)
  end
end

puts __FILE__

require 'lib/dinbrief/constants.rb'
require 'lib/dinbrief/letter_builder.rb'
require 'lib/dinbrief/draw_methods.rb'
