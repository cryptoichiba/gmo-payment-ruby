module GMO
  module Payment

    module SecureAPIMethods
      def initialize(options = {})
        @host      = options[:host]
        @locale    = options.fetch(:locale, GMO::Const::DEFAULT_LOCALE)
        unless @host
          raise ArgumentError, "Initialize must receive a hash with :host! (received #{options.inspect})"
        end
      end
      attr_reader :host, :locale

      def secure_exec_tran(options = {})
        name = "SecureTran.idPass"
        required = [:pa_res, :md]
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response, locale)
            end
          end
        end
    end
  end
end
