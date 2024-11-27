module Fremont
  module SSH
    def execute_on_server(script, user: nil)
      ssh_params = Config.current["ssh"]

      ip = ssh_params["ip"]
      user ||= ssh_params["user"]

      Net::SSH.start(ip, user, **ssh_params.except("ip", "user")) do |session|
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

# Net::SSH.start('116.203.220.190', 'admin')
# Net::SSH.start('116.203.220.190', 'admin', keys: [ "" ], port: 22) do |session|
