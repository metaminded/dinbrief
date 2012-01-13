#encoding: utf-8

module Dinbrief
  class LetterBuilder

    def initialize(letter=nil)
      @letter = letter
    end

    [
      :subject, :header, :return_address, :address,
      :yoursign, :yourmessage, :oursign, :ourmessage,
      :name, :phone, :fax, :email,
      :date
    ].each do |nam|
      define_method nam do |s|
        instance_variable_set("@#{nam}", s)
      end
    end

    def body(b=nil, &block)
      @body = block_given? ? block : b
    end

    def info(b=nil, &block)
      @info = block_given? ? block : b
    end

  end
end