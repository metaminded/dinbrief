#encoding: utf-8

class Dinbrief::Letter

  DocumentDefaults = {                # The following options are available (with the default values marked in [])
    :page_size          => 'A4',      # One of the Document::PageGeometry sizes [LETTER]
    :page_layout        => :portrait, # Either :portrait or :landscape
    :left_margin        => 25.mm,      # Sets the left margin in points [0.5 inch]
    :right_margin       => 20.mm,      # Sets the right margin in points [0.5 inch]
    :top_margin         => 30.mm,      # Sets the top margin in points [0.5 inch]
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
    :fold_mark_1_y    => 87.mm,
    :fold_mark_2_y    => -105.mm,
    :fold_mark_x      => 5.mm,
    :fold_mark_width  => 5.mm,
    :punch_mark_y     => 148.5.mm,
    :punch_mark_x     => 5.mm,
    :punch_mark_width => 5.mm,

    # Return Address Field
    :return_address_x          => 20.mm,
    :return_address_y          => -45.mm - 10.mm,
    :return_address_rule_x     => 20.mm,
    :return_address_rule_y     => -45.mm - 14.mm,
    :return_address_rule_width => 85.mm,
    :return_address_rule_linewidth => 0.5.pt,
    :return_address_fontsize   => 8.pt,
    :return_address_align      => :center,
    :return_address_width      => 85.mm,

    # Address Field
    :address_x          => 25.mm,
    :address_y          => -45.mm - 17.mm,
    :address_width      => 80.mm,
    :address_height     => 28.mm,
    :address_fontsize   => 10.pt,
    :address_valign     => :center,

    # Info Block
    :info_block_x        => 125.mm,
    :info_block_y        => -45.mm,
    :info_block_width    => 75.mm,
    :info_block_fontsize => 9.pt,

    # Date
    :date_x        => 125.mm,
    :date_y        => -87.mm,
    :date_fontsize => 10.pt,

    # Subject
    :subject_x        => 25.mm,
    :subject_y        => - 105.mm + 2.mm,
    :subject_fontsize => 11.pt,
    :subject_style    => :bold,

    # Body
    :body_fontsize => 10.pt,
    :body_style    => nil,
    :body_preskip  => 105.mm - 30.mm + 6.mm,

    # Header
    :header_x      => 20.mm,
    :header_y      => 297.mm,
    :header_width  => 210.mm-30.mm,
    :header_height => 45.mm,

    # Footer
    :footer_x      => 20.mm,
    :footer_y      => 22.mm,
    :footer_width  => 210.mm-30.mm,
    :footer_height => 12.mm,

    # Page Numbering
    :page_numbering_string => "<page>/<total>",
    :page_numbering_x      => 180.mm,
    :page_numbering_y      => 26.mm,
    :page_numbering_width  => 10.mm,
    :page_numbering_align  => :right,
    :page_numbering_fontsize => 10.pt
  }

  MeasurementDefaults.each do |n,v|
    nn = n.to_s
    define_method(nn) do
      v = MeasurementDefaults[n]
      if nn.end_with?('_x')
        (v < 0 ? 210.mm : 0) + v - DocumentDefaults[:left_margin]
      elsif nn.end_with?('_y')
        (v < 0 ? 297.mm : 0) + v - DocumentDefaults[:bottom_margin]
      else
        v
      end
    end
  end

  LetterDefaults = {
    :show_fold_tics           => true,
    :show_punch_tic           => true,
    :show_return_address_rule => true,
    :show_page_numbers        => true
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

end