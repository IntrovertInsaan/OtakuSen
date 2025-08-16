# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def pagy_nav_tailwind(pagy)
    # This new version builds an array of HTML parts instead of modifying a single string.
    # It also uses DaisyUI's "btn" and "join" component classes for perfect theming.
    html_parts = []

    html_parts << '<div class="join">'

    # Prev button
    if pagy.prev
      html_parts << link_to("«", url_for(params.to_unsafe_h.merge(page: pagy.prev)), class: "join-item btn")
    else
      html_parts << '<button class="join-item btn" disabled>«</button>'
    end

    # Page links
    pagy.series.each do |item|
      case item
      when Integer
        html_parts << link_to(item, url_for(params.to_unsafe_h.merge(page: item)), class: "join-item btn")
      when String
        html_parts << "<button class='join-item btn btn-active'>#{item}</button>"
      when :gap
        html_parts << '<button class="join-item btn btn-disabled">...</button>'
      end
    end

    # Next button
    if pagy.next
      html_parts << link_to("»", url_for(params.to_unsafe_h.merge(page: pagy.next)), class: "join-item btn")
    else
      html_parts << '<button class="join-item btn" disabled>»</button>'
    end

    html_parts << "</div>"

    html_parts.join.html_safe
  end
end
