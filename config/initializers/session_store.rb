# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
    expire_after: 1.hour,
    key: '_contingency_session'
