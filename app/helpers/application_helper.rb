module ApplicationHelper
  def analytics_body_tag(attributes = {}, &block)
    attributes = attributes.symbolize_keys

    analytics = {
      "analytics-gtm-id".to_sym => ENV["GOOGLE_TAG_MANAGER_ID"],
      "analytics-hotjar-id".to_sym => ENV["HOTJAR_ID"],
    }

    attributes[:data] ||= {}
    attributes[:data] = attributes[:data].merge(analytics)

    attributes[:data][:controller] =
      "gtm hotjar #{attributes[:data][:controller]}"

    tag.body attributes, &block
  end
end
