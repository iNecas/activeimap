module ActiveImap
  class Connection
    def initialize(config, options = {})
      @imap = Net::IMAP.new(config.server_host, config.server_port, config.server_ssl)
      @imap.login(config.imap_user, config.imap_password)    
    end
    
    def logout_and_disconnect
      begin
        @imap.logout
        @imap.disconnect
      rescue
      end
    end
    
    def folders(options = {})
      imap = ActiveImap::Folder.all self
    end
    
    def fetchData *args
      @imap.fetch *args
    end
    
    # Send all calls not in this class to Net::IMAP
    def method_missing(method, *args)
      @imap.send(method, *args)
    end
  end
end