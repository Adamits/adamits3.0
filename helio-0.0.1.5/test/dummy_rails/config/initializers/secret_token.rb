# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
token = "722b3a9b0f2389ffebe99a88d8411ec1cb673436e10a7fc82f63ab8e7bf9e5e208568b31d5e84b885859eff6a88b11d0cb9a1e095e0c307db7fed1010c3e3a8e"

if Dummy::Application.config.respond_to?(:secret_key_base=)
  Dummy::Application.config.secret_key_base = token
else
  Dummy::Application.config.secret_token = token
end
