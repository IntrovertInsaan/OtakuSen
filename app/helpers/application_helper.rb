module ApplicationHelper
  include Pagy::Frontend

  def pagy_nav_tailwind(pagy)
    html = %(<nav class="flex items-center justify-center space-x-2 mt-6" role="navigation" aria-label="pagination">)

    # Prev button
    if pagy.prev
      html << link_to("← Prev", url_for(page: pagy.prev), class: "px-3 py-1 bg-gray-200 text-gray-700 rounded hover:bg-gray-300")
    else
      html << %(<span class="px-3 py-1 bg-gray-100 text-gray-400 rounded cursor-not-allowed">← Prev</span>)
    end

    # Page links
    pagy.series.each do |item|
      case item
      when Integer
        html << link_to(item, url_for(page: item), class: "px-3 py-1 bg-white border border-gray-300 text-gray-700 rounded hover:bg-gray-100")
      when String
        html << %(<span class="px-3 py-1 bg-blue-500 text-white rounded">#{item}</span>)
      when :gap
        html << %(<span class="px-3 py-1 text-gray-400">...</span>)
      end
    end

    # Next button
    if pagy.next
      html << link_to("Next →", url_for(page: pagy.next), class: "px-3 py-1 bg-gray-200 text-gray-700 rounded hover:bg-gray-300")
    else
      html << %(<span class="px-3 py-1 bg-gray-100 text-gray-400 rounded cursor-not-allowed">Next →</span>)
    end

    html << "</nav>"
    html.html_safe
  end
end
