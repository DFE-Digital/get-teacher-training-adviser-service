module ApplicationHelper
  def analytics_body_tag(attributes = {}, &block)
    attributes = attributes.symbolize_keys

    analytics = {
      "analytics-gtm-id".to_sym => ENV["GOOGLE_TAG_MANAGER_ID"],
      "analytics-hotjar-id".to_sym => ENV["HOTJAR_ID"],
      "analytics-snapchat-id".to_sym => ENV["SNAPCHAT_ID"],
      "analytics-pinterest-id".to_sym => ENV["PINTEREST_ID"],
      "analytics-facebook-id".to_sym => ENV["FACEBOOK_ID"],
    }

    attributes[:data] ||= {}
    attributes[:data] = attributes[:data].merge(analytics)

    attributes[:data][:controller] =
      "gtm hotjar snapchat pinterest facebook #{attributes[:data][:controller]}"

    tag.body attributes, &block
  end

  def govuk_form_for(*args, **options, &block)
    merged = options.dup
    merged[:builder] = GOVUKDesignSystemFormBuilder::FormBuilder
    merged[:html] ||= {}
    merged[:html][:novalidate] = true

    form_for(*args, **merged, &block)
  end

  def back_link(path = :back, text: "Back", **options)
    options[:class] = "govuk-back-link #{options[:class]}".strip

    link_to text, path, **options
  end

  def link_to_change_answer(step)
    link_to "Change", teacher_training_adviser_step_path(step.key), { class: "govuk-link" }
  end
end
