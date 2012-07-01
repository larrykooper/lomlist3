module ItemsHelper
  def safe_item_desc(item)
    item_desc_cleaned = Sanitize.clean(item.item_desc, :elements => HTML_ELEMENTS_ALLOWED, :attributes => HTML_ATTRIBUTES_ALLOWED, 
    :protocols => HTML_PROTOCOLS_ALLOWED)
    raw(item_desc_cleaned)
  end

end
