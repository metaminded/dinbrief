# encoding: utf-8

module Dinbrief

  class Letter < Prawn::Document

    def self.letter(filename,options={},&block)
      self.generate(filename, DocumentDefaults.merge(options)) do |letter|
        yield(letter.letter_builder)
        letter.meta_header()
        letter.meta_footer()
        letter.methods.map(&:to_s).select{|m|m.start_with?("typeset_")}.each do |m|
          next if m=='typeset_body'
          letter.send(m)
        end
        letter.typeset_body
        letter.add_page_numbers
      end
    end

    def add_page_numbers
      if show_page_numbers?
        number_pages page_numbering_string, {
          :start_count_at => 1,
          :page_filter    => :all, #[2..9999],
          :at             => [page_numbering_x, page_numbering_y],
          :align          => page_numbering_align,
          :size           => page_numbering_fontsize,
          :width          => page_numbering_width
        }
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
require 'dinbrief/letter/design_elements'