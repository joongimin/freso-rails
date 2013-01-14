Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :nuvo, "5632dc5b2bff993a82050f842fce7f037d933311cade8ee566a656436720fe6c", "3b29c9719a407ea363c4af50e41d8f397b29809d444499b64f24498c4c349669",
      {
        :client_options => {
          :site => 'http://dev3.xnuvo.com:3000',
          :authorize_path => '/oauth/authorize'
        }
      }
  elsif Rails.env.test?
    provider :nuvo, "26324ecdb8519234aca3bda832a7dd91c46c0bb5efc657b413e15af0c024e38e", "2de234dbefbb4bc69812ce2bcc6e6b36e8aa4a15f9b9de4461896594512d5e22",
      {
        :client_options => {
          :site => 'https://d1.xnuvo.com',
          :authorize_path => '/oauth/authorize'
        }
      }
  else
    provider :nuvo, "26324ecdb8519234aca3bda832a7dd91c46c0bb5efc657b413e15af0c024e38e", "2de234dbefbb4bc69812ce2bcc6e6b36e8aa4a15f9b9de4461896594512d5e22",
      {
        :client_options => {
          :site => 'https://d1.xnuvo.com',
          :authorize_path => '/oauth/authorize'
        }
      }
  end
end