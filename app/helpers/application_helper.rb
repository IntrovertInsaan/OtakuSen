# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def pagy_nav_tailwind(pagy)
    html_parts = []
    html_parts << %(<nav class="flex items-center justify-center space-x-2 mt-6" role="navigation" aria-label="pagination">)

    # Prev button
    if pagy.prev
      html_parts << link_to("← Prev", url_for(params.to_unsafe_h.merge(page: pagy.prev)), class: "btn btn-ghost", data: { turbo_scroll: false })
    else
      html_parts << %(<button class="btn btn-ghost" disabled>← Prev</button>)
    end

    # Page links
    pagy.series.each do |item|
      case item
      when Integer
        html_parts << link_to(item, url_for(params.to_unsafe_h.merge(page: item)), class: "btn btn-ghost", data: { turbo_scroll: false })
      when String
        html_parts << "<button class='btn btn-active'>#{item}</button>"
      when :gap
        html_parts << '<button class="btn btn-disabled">...</button>'
      end
    end

    # Next button
    if pagy.next
      html_parts << link_to("Next →", url_for(params.to_unsafe_h.merge(page: pagy.next)), class: "btn btn-ghost", data: { turbo_scroll: false })
    else
      html_parts << %(<button class="btn btn-ghost" disabled>Next →</button>)
    end

    html_parts << "</nav>"
    html_parts.join(" ").html_safe
  end
end
