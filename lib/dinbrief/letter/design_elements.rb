#encoding: utf-8

class Dinbrief::Letter

  #
  # creates a header bounding box on the top of the page and
  # renders some dummy content. If a 'header' method is implemented,
  # it's called, so you can easily define your own header.
  #
  def meta_header
    bounding_box([header_x, header_y],
      :width => header_width,
      :height => header_height
    ) do |pdf|
      if self.respond_to? :header
        header()
      else
        line_width 0.1.pt
        stroke_bounds
        text_box("DIN Brief Letter\na Ruby GEM for Prawn",
          :at => [0.mm, 35.mm],
          :size => 16.pt
        )
        draw_text("© 2011–#{Time.now.year} Peter Horn, metaminded UG",
          :at => [0.mm, 13.mm],
          :size => 10.pt
        )
        text_box(%{To replace this default header by yours,
          just implement a 'header' function in your Dinbrief::Letter
          subclass and draw whatever you like.
          There, you are inside this bordered box with [0,0] being the
          lower left corner.},
          :at => [85.mm, 35.mm],
          :width => 90.mm,
          :align => :left,
          :size => 10.pt,
          :font => "Times-Roman"

        )
      end
    end
  end

  #
  # creates a footer bounding box on the bottom of the page and
  # renders some dummy content. If a 'footer' method is implemented,
  # it's called, so you can easily define your own footer.
  #
  def meta_footer()
    bounding_box([footer_x, footer_y],
      :width => footer_width,
      :height => footer_height
    ) do |pdf|
      if self.respond_to? :footer
        footer()
      else
        line_width 0.1.pt
        stroke_bounds
        text_box(%{To replace this default footer by yours, just implement a 'footer' function in your Dinbrief::Letter
          subclass and draw whatever you like. There, you are inside this bordered box with [0,0] being the lower left corner.},
          :at => [20.mm, 12.mm],
          :width => 140.mm,
          :align => :center,
          :size => 8.pt,
        )
      end
    end
  end
end