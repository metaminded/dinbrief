#encoding: utf-8

class Dinbrief::Letter
  #
  # typeset info block (sign, name, phone...)
  #
  def typeset_info
    bounding_box([info_block_x, info_block_y],
      :width => info_block_width,
      :height => info_block_height
    ) do
      #stroke_bounds
      i = lb_get(:info)
      case i
      when String
        text i, :size => info_block_fontsize
      when Proc
        i.(self)
      else
        info = [:yoursign, :yourmessage, :oursign, :ourmessage,
        :name, :phone, :fax, :email].map do |nam|
          iv = lb_get nam
          iv ? "#{InfoTranslations[nam]}: #{iv}" : nil
        end.compact.join("\n")
        return unless info
        text info,
          :size => info_block_fontsize
      end
    end
    date = lb_get(:date) || Time.now.strftime("%d.%m.%Y")
    text_box("#{InfoTranslations[:date]}: #{date}",
      :at => [date_x, date_y],
      :size => date_fontsize
    )
  end

  #
  # typeset rerturn address above address field
  #
  def typeset_return_address
    return unless lb_get(:return_address)
    bounding_box([return_address_x, return_address_y],
      :width => return_address_width,
      :height => 5.mm
    ) do
      text(lb_get(:return_address),
        :size => return_address_fontsize,
        :align => return_address_align
      )
    end
    return unless show_return_address_rule?
    line_width return_address_rule_linewidth
    line(
      [return_address_rule_x, return_address_rule_y],
      [return_address_rule_x + return_address_rule_width, return_address_rule_y]
    )
    stroke
  end

  #
  # draw the fold- and punchmarks
  #
  def typeset_marks
    line_width(0.2)
    if show_fold_tics?
      line([fold_mark_x, fold_mark_1_y], [fold_mark_x+fold_mark_width, fold_mark_1_y])
      line([fold_mark_x, fold_mark_2_y], [fold_mark_x+fold_mark_width, fold_mark_2_y])
    end
    if show_punch_tic?
      line([punch_mark_x, punch_mark_y], [punch_mark_x+punch_mark_width, punch_mark_y])
    end
    stroke
  end

  #
  # typeset the recipients address
  #
  def typeset_address
    raise "An address should be given." unless lb_get(:address)
    bounding_box([address_x, address_y],
      :width => address_width,
      :height => address_height,
      :valign => address_valign,
    ) do
      text(lb_get(:address),
        :size => address_fontsize
      )
    end
  end

  def typeset_subject
    return unless lb_get(:subject)
    text_box(lb_get(:subject),
      :at => [subject_x, subject_y],
      :size => subject_fontsize,
      :style => subject_style
    )
  end

  def typeset_body
    gbody = lb_get(:body)
    raise "A body should be given." unless gbody
    move_cursor_to bounds.height
    move_down body_preskip
    if gbody.respond_to?(:call)
      font_size(body_fontsize)
      #font_style(body_style)
      gbody.call(self)
    else
      text(gbody.strip,
        :size => body_fontsize,
        :style => body_style
      )
    end
  end
end