# frozen_string_literal: true

module IconHelper
  # Usage: <%= icon("menu", class: "h-6 w-6") %>
  def icon(name, **options)
    inline_svg_tag("icons/#{name}.svg", **options)
  end
end
