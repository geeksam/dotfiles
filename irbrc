unless defined?(Kernel.__breadcrumb__)
  module Kernel
    def __breadcrumb__(obj = nil)
      return obj unless $debug

      case obj
      when nil    ; msg = nil
      when String ; msg = obj
      else        ; msg = obj.inspect
      end

      breadcrumb = ">>> #{caller.first}"
      breadcrumb << "\n--> #{msg}" if msg.present?

      Rails.logger.debug breadcrumb if defined?(Rails)
      puts '', breadcrumb

    ensure
      return obj
    end
  end
end


IRB.conf[:USE_AUTOCOMPLETE] = false




# If local dir has an .irbrc (or equivalent), load that too
irbrc_candidate_names = %w[ .irbrc irb.rc _irbrc $irbrc ] # yoinked from Ruby core docs for the `IRB` module
local_irbrc = irbrc_candidate_names \
  .lazy \
  .map { |e| File.join(Dir.pwd, e) } \
  .detect { |e| File.exist?(e) }

if local_irbrc && local_irbrc != __FILE__
  puts
  puts "##### #{__FILE__} detected local IRB config file at #{local_irbrc}.  Loading..."
  load local_irbrc
  puts
end
