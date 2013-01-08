Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "Zmjpe9RcCINmoQPAaV01Gg", "uoFI7WvmF0HELJ00KVMgFuaKVYFGGFw4KV6bVdwSss"
  provider :nuvo, "5632dc5b2bff993a82050f842fce7f037d933311cade8ee566a656436720fe6c", "3b29c9719a407ea363c4af50e41d8f397b29809d444499b64f24498c4c349669",
    {
      :client_options => {
        :site => 'http://d1.xnuvo.com',
        :authorize_path => '/oauth/authorize'
      }
    }
end