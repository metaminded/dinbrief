# encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'

class Dinbrief < Prawn::Document

  DocumentDefaults = {                # The following options are available (with the default values marked in [])
    :page_size          => 'A4',      # One of the Document::PageGeometry sizes [LETTER]
    :page_layout        => :portrait, # Either :portrait or :landscape
    :left_margin        => 2.cm,      # Sets the left margin in points [0.5 inch]
    :right_margin       => 2.cm,      # Sets the right margin in points [0.5 inch]
    :top_margin         => 2.cm,      # Sets the top margin in points [0.5 inch]
    :bottom_margin      => 3.cm,      # Sets the bottom margin in points [0.5 inch]
    :skip_page_creation => false,     # Creates a document without starting the first page [false]
    :compress           => false,     # Compresses content streams before rendering them [false]
    :optimize_objects   => false,     # Reduce number of PDF objects in output, at expense of render time [false]
    :background         => nil,       # An image path to be used as background on all pages [nil]
    :info               => nil,       # Generic hash allowing for custom metadata properties [nil]
    :template           => nil        # The path to an existing PDF file to use as a template [nil]
  }
  
  MeasurementDefaults = {
    # Folding Marks
    :fold_mark_1_y    => 105.mm,
    :fold_mark_2_y    => 210.mm,
    :fold_mark_x      => 5.mm,
    :fold_mark_width  => 10.mm,
    :punch_mark_y     => 192.mm,
    :punch_mark_x     => 5.mm,
    :punch_mark_width => 10.mm,

    # Return Address Field
    :return_address_x          => 20.mm,
    :return_address_y          => 297.mm - 27.mm,
    :return_address_rule_x     => 20.mm,
    :return_address_rule_y     => 297.mm - 27.mm - 5.mm,
    :return_address_rule_width => 85.mm,
    :return_address_rule_linewidth => 5.pt,
    :return_address_fontsize   => 8.pt,
    :return_address_align      => :center,

    # Address Field
    :address_x          => 25.mm,
    :address_y          => 297.mm - 27.mm - 5.mm - 2.mm,
    :address_width      => 80.mm,
    :address_height     => 28.mm,
    :address_fontsize   => 11.pt,
    :address_valign     => :top,
    
    # Header
    :info_block_x        => 125.mm,
    :info_block_y        => 297.mm - 27.mm - 5.mm,
    :info_block_width    => 75.mm,
    :info_block_fontsize => 10.pt,
    
    # Date
    :date_x        => 125.mm,
    :date_y        => 297.mm - 72.mm,
    :date_fontsize => 10.pt,
    
    # Subject
    :subject_x     => 1
  }

  MeasurementDefaults.each do |n,v|
    nn = n.to_s
    define_method(nn) do
      return (MeasurementDefaults[n]-DocumentDefaults[:left_margin]) if nn.end_with?('_x')
      return (MeasurementDefaults[n]-DocumentDefaults[:bottom_margin]) if nn.end_with?('_y')
      MeasurementDefaults[n]
    end
  end

  LetterDefaults = {
    :show_fold_tics           => true,
    :show_punch_tic           => true,
    :show_return_address_rule => true
  }
  
  LetterDefaults.each do |n,v|
    nn = n.to_s
    define_method(nn) do LetterDefaults[n] end
    if nn.start_with?("show_")
      define_method("#{nn}?") do LetterDefaults[n] end
      define_method("#{nn}!") do LetterDefaults[n] = true end
      define_method("hide_#{nn[5..-1]}!") do LetterDefaults[n] = false end
    end
  end
  
  InfoTranslations = {
    :yoursign     => 'Ihr Zeichen',
    :yourmessage  => 'Ihre Nachricht vom',
    :oursign      => 'Unser Zeichen',
    :ourmessage   => 'Unsere Nachricht vom',
    :name         => 'Name',
    :phone        => 'Telefon',
    :fax          => 'Telefax',
    :email        => 'E-Mail',
    :date         => 'Datum'
  }
  
  def self.letter(*args)
    self.generate(*args) do |letter|
      yield(letter)
      letter.draw_info
      letter.draw_return_address
      letter.draw_address
      letter.draw_body
    end
  end

  def initialize(opts={})
    super(DocumentDefaults.merge(opts))
  end

  [
    :body, :subject, :header, :return_address, :address,
    :yoursign, :yourmessage, :oursign, :ourmessage, 
    :name, :phone, :fax, :email,
    :date
  ].each do |nam|
    define_method nam do |s|
      instance_variable_set("@#{nam}", block_given? ? block : s)
    end
  end

  def draw_info
    info = [:yoursign, :yourmessage, :oursign, :ourmessage, 
    :name, :phone, :fax, :email].map do |nam|
      iv = instance_variable_get("@#{nam}")
      iv ? "#{InfoTranslations[nam]}: #{iv}" : nil
    end.compact.join("\n")
    return unless info
    text_box(info, 
      :at => [info_block_x, info_block_y], 
      :size => info_block_fontsize
    )
    date = @date || Time.now.strftime("%d.%m.%Y")
    text_box("#{InfoTranslations[:date]}: #{date}",
      :at => [date_x, date_y],
      :size => date_fontsize
    )
  end
  
  def draw_return_address
    return unless @return_address
    text_box(@return_address, 
      :at => [return_address_x, return_address_y], 
      :size => return_address_fontsize
    )
    # TODO: Fix the not-drawing of the line
    line(
      [return_address_rule_x, return_address_rule_y],
      [return_address_rule_x + return_address_rule_width, return_address_rule_y] #, 
      #:line_width => return_address_rule_linewidth
    ) if show_return_address_rule?
  end
  
  def draw_address
    raise "An address should be given." unless @address
    text_box(@address, 
      :at => [address_x, address_y], 
      :width => address_width, 
      :height => address_height, 
      :valign => address_valign,
      :size => address_fontsize
    )
  end
  
  def draw_body
    
  end
end
