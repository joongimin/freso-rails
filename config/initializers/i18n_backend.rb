TRANSLATION_STORE = $redis = Redis::Namespace.new("freso/translations", :redis => Redis.new)
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)