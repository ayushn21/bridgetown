module Fremont
  module SSH
    def execute_on_server(script)
      Net::SSH.start(*Config.current.ssh_params) do |session|
        session.open_channel do |channel|
          channel.on_data do |_, data|
            puts data
          end
          channel.exec script
        end
        session.loop
      end
    end
  end
end

