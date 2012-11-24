OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'LhQG1sRofUg4kDWi18Iz2w', '58iVpxv5gHTeRfMj3Mi8wE0OaVPCcbwVhSnsojVteY'
  provider :github, 'ce090164ed116df14330', '6da6287f48d9b7715d7792dbce4d2b23a8890b43'
end
