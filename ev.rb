require 'rufus-scheduler'
require 'tzinfo'
require 'tzinfo/data'
# TZInfo::DataSource.set(:zoneinfo, "C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/tzinfo-data-1.2017.2")
ENV['TZ'] = 'America/New_York'
scheduler = Rufus::Scheduler.new

scheduler.every '3s' do
    puts " everu 1"
end

scheduler.join
# require 'tzinfo'
# z = TZInfo::Timezone.get('Asia/Shanghai') rescue 'no Shanghai 0'
# p z
# require 'tzinfo/data'
# z = TZInfo::Timezone.get('Asia/Shanghai') rescue 'no Shanghai 1'
# p z