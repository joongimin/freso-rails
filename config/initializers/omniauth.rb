Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "Zmjpe9RcCINmoQPAaV01Gg", "uoFI7WvmF0HELJ00KVMgFuaKVYFGGFw4KV6bVdwSss"
  provider :nuvo, "26324ecdb8519234aca3bda832a7dd91c46c0bb5efc657b413e15af0c024e38e", "2de234dbefbb4bc69812ce2bcc6e6b36e8aa4a15f9b9de4461896594512d5e22",
    {
      :client_options => {
        :site => 'https://d1.xnuvo.com',
        :authorize_path => '/oauth/authorize'
      }
    }
end