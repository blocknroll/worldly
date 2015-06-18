Rails.application.config.middleware.use OmniAuth::Builder do
  # client ID, client Secret from github
  provider :github, ENV['github_id'], ENV['github_secret']
end

# never push client id or secret to heroku
