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

  def filter_link_params(add_params = {})
    # 1. Whitelist all the parameters we ever want to use for filtering.
    #    We just need to add :view to this list.
    allowed_keys = [ :category_id, :tag, :search, :view ]

    # 2. Start with the current URL's parameters, but only the ones we've whitelisted.
    current_params = params.to_unsafe_h.slice(*allowed_keys)

    # 3. Merge in the new parameters for the link we're creating.
    merged_params = current_params.merge(add_params)

    # 4. Clean up any filters that were intentionally cleared.
    merged_params.compact_blank
  end
end
