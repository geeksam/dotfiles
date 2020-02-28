unless defined?(Kernel.__breadcrumb__)
  module Kernel
    def __breadcrumb__(obj = nil)
      if defined?(Rails)
        return obj unless Rails.env.test? || Rails.env.development?
      end
      return obj unless $debug

      case obj
      when nil    ; msg = nil
      when String ; msg = obj
      else        ; msg = obj.inspect
      end

      breadcrumb = ">>> #{caller.first}"
      breadcrumb << "\n--> #{msg}" if msg.present?

      if defined?(Rails)
        Rails.logger.debug breadcrumb
        puts '', breadcrumb if Rails.env.test?
      else
        puts '', breadcrumb
      end

      return obj
    end
  end
end

