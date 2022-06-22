# rubocop:disable Lint/PercentStringArray
SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w[origin-when-cross-origin strict-origin-when-cross-origin]

  google_analytics = %w[*.google-analytics.com *.googletagmanager.com tagmanager.google.com *.googleusercontent.com *.gstatic.com s.ytimg.com https://www.googleadservices.com *.google.co.uk https://www.google.com https://googleads.g.doubleclick.net https://pagead2.googlesyndication.com]
  lid_pixels = %w[pixelg.adswizz.com tracking.audio.thisisdax.com]
  bam_pixels = %w[linkbam.uk]

  config.csp = {
    default_src: %w['none'],
    base_uri: %w['self'],
    block_all_mixed_content: true, # see http://www.w3.org/TR/mixed-content/
    child_src: %w['self' *.youtube.com ct.pinterest.com tr.snapchat.com],
    connect_src: %W['self' ct.pinterest.com www.facebook.com stats.g.doubleclick.net tr.snapchat.com] + google_analytics,
    font_src: %w['self' *.gov.uk fonts.gstatic.com],
    form_action: %w['self' tr.snapchat.com www.facebook.com],
    frame_ancestors: %w['self'],
    frame_src: %w['self' tr.snapchat.com www.facebook.com www.youtube.com *.doubleclick.net *.pinterest.com *.pinterest.co.uk],
    img_src: %W['self' *.gov.uk data: *.googleapis.com ade.googlesyndication.com analytics.twitter.com www.facebook.com ct.pinterest.com t.co www.facebook.com cx.atdmt.com ad.doubleclick.net *.fls.doubleclick.net i.ytimg.com adservice.google.com adservice.google.co.uk] + google_analytics + lid_pixels + bam_pixels,
    manifest_src: %w['self'],
    media_src: %w['self'],
    script_src: %W['self' 'unsafe-inline' 'unsafe-eval' *.googleapis.com *.gov.uk code.jquery.com *.youtube.com *.facebook.net *.pinimg.com sc-static.net static.ads-twitter.com analytics.twitter.com ad.doubleclick.com] + google_analytics,
    style_src: %w['self' 'unsafe-inline' *.gov.uk *.googleapis.com] + google_analytics,
    worker_src: %w['self'],
    upgrade_insecure_requests: !Rails.env.development?, # see https://www.w3.org/TR/upgrade-insecure-requests/
    report_uri: %w[/csp_reports],
  }
end
# rubocop:enable Lint/PercentStringArray
