#encoding: utf-8

class Dinbrief
  def draw_info
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

  def draw_return_address
    return unless lb_get(:return_address)
    text_box(lb_get(:return_address),
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
    raise "An address should be given." unless lb_get(:address)
    text_box(lb_get(:address),
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