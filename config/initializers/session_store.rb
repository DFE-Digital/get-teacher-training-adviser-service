Rails.application.config.session_store :cache_store,
key: "_#{Rails.application.class.parent_name.downcase}_session",
redis: {
  expire_after: 1.day,
  key_prefix: "hello:session:"
}