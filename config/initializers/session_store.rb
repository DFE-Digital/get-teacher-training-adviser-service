# Changing the session store causes it
# to become nil between Capybara requests.
return if Rails.env.test?

Rails.application.config.session_store :cache_store,
                                       key: "_#{Rails.application.class.parent_name}_session",
                                       expire_after: 1.day
