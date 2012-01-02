#encoding: utf-8

class Dinbrief::Letter
  def typeset_info
    info = [:yoursign, :yourmessage, :oursign, :ourmessage,
    :name, :phone, :fax, :email].map do |nam|
      iv = lb_get nam
      iv ? "#{InfoTranslations[nam]}: #{iv}" : nil
    end.compact.join("\n")
    return unless info
    text_box(info,
      :at => [info_block_x, info_block_y],
      :size => info_block_fontsize
    )
    date = lb_get(:date) || Time.now.strftime("%d.%m.%Y")
    text_box("#{InfoTranslations[:date]}: #{date}",
      :at => [date_x, date_y],
      :size => date_fontsize
    )
  end

  def typeset_return_address
    return unless lb_get(:return_address)
    text_box(lb_get(:return_address),
      :at => [return_address_x, return_address_y],
      :size => return_address_fontsize
    )
    return unless show_return_address_rule?
    line_width return_address_rule_linewidth
    line(
      [return_address_rule_x, return_address_rule_y],
      [return_address_rule_x + return_address_rule_width, return_address_rule_y]
    )
    stroke
  end

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

  def typeset_address
    raise "An address should be given." unless lb_get(:address)
    text_box(lb_get(:address),
      :at => [address_x, address_y],
      :width => address_width,
      :height => address_height,
      :valign => address_valign,
      :size => address_fontsize
    )
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
    move_down 85.mm
    text lb_get(:body)
  end

end