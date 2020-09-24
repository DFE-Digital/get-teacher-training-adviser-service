module TextFormatHelper
  extend ActiveSupport::Concern
  include ActionView::Helpers::TextHelper

  def safe_format(content, wrapper_tag: "p")
    simple_format(strip_tags(content), {}, wrapper_tag: wrapper_tag)
  end

  def safe_html_format(html)
    sanitize html, tags: %w[strong a ul li p b span br], attributes: %w[href class]
  end
end
