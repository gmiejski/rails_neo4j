# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
BD2Neo4j::Application.config.secret_key_base = '37add30f2dc91f8f87a2fd7e1661d116a92ec3f16ae73807bba66d039fe3f0ef1b8d787548de26c528a400985a94277f3db8d902939746fea7914576f69ab752'
