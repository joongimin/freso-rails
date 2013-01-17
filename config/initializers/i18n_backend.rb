TRANSLATION_STORE = $redis = Redis::Namespace.new("freso/translations", :redis => Redis.new)
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)

module I18n
  module Backend
    KeyValue.class_eval do
      def initialized?
        true
      end

    protected
      def translations
        trans = {}
        store.keys.delete_if{|k| k.include?("#")}.each do |k|
          trans_pointer = trans
          key_array = k.split(".")
          last_key = key_array.delete_at(key_array.length-1)
          key_array.each do |current|
            if !trans_pointer.has_key?(current.to_sym)
              trans_pointer[current.to_sym] = {}
            end
            trans_pointer = trans_pointer[current.to_sym]
          end
          trans_pointer[last_key.to_sym] = store[k]
        end
        return trans
      end

      def init_translations
      end
    end

    Chain.class_eval do
      def initialized?
        backends.each do |backend|
          return false if !backend.initialized?
        end
        return true
      end

    protected

      def translations
        trans = {}
        backends.reverse.each do |backend| # reverse so that the top most will be merged-in
          backend.instance_eval do
            trans.deep_merge!(translations)
          end
        end
        return trans
      end

      def init_translations
        backends.each do |backend|
          backend.instance_eval do
            init_translations
          end
        end
      end
    end
  end
end