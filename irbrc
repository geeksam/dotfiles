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




# If local dir has an .irbrc (or equivalent), load that too
irbrc_candidate_names = %w[ .irbrc irb.rc _irbrc $irbrc ] # yoinked from Ruby core docs for the `IRB` module
local_irbrc = irbrc_candidate_names \
  .lazy \
  .map { |e| File.join(Dir.pwd, e) } \
  .detect { |e| File.exist?(e) }

if local_irbrc
  tilde = ->(filename) { filename.gsub(Dir.home, "~") }
  global_irc = tilde.(__FILE__)
  puts
  puts "##### #{global_irc} detected local IRB config file at #{tilde.(local_irbrc)}.  Loading..."
  load local_irbrc
  puts
end
