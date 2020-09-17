module ApplicationHelper
  def analytics_body_tag(attributes = {}, &block)
    attributes = attributes.symbolize_keys

    analytics = {
      "analytics-gtm-id" => ENV["GOOGLE_TAG_MANAGER_ID"],
      "analytics-hotjar-id" => ENV["HOTJAR_ID"],
      "analytics-snapchat-id" => ENV["SNAPCHAT_ID"],
      "analytics-pinterest-id" => ENV["PINTEREST_ID"],
      "analytics-facebook-id" => ENV["FACEBOOK_ID"],
      "analytics-twitter-id" => ENV["TWITTER_ID"],
      "pinterest-action" => "page",
      "snapchat-action" => "track",
      "snapchat-event" => "PAGE_VIEW",
      "facebook-action" => "track",
      "facebook-event" => "PageView",
      "twitter-action" => "track",
      "twitter-event" => "PageView",
    }.symbolize_keys

    attributes[:data] ||= {}
    attributes[:data] = attributes[:data].merge(analytics)

    attributes[:data][:controller] =
      "gtm pinterest snapchat facebook hotjar twitter #{attributes[:data][:controller]}"

    tag.body attributes, &block
  end

  def prefix_title(title)
    if title
      "Get an adviser: #{title}"
    else
      "Get an adviser"
    end
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
    link_to(teacher_training_adviser_step_path(step.key), { class: "govuk-link" }) do
      safe_html_format("Change <span class='visually-hidden'> #{step.key.humanize(capitalize: false)}</span>")
    end
  end

  

end
