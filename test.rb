require 'mixlib/shellout'
require 'thread'
require 'rufus-scheduler'
require 'tzinfo'
require 'tzinfo/data'
ENV['TZ'] = 'America/New_York'
scheduler = Rufus::Scheduler.new

module ProcessingAppManager
    class ProcessingAppEvent
        def initialize
            @cycle = 0
            thrInit = Thread.new do
                    # cmd.timeout=20
                puts "running the first one:"
                @cmd = Mixlib::ShellOut.new("C:\\Users\\armin\\Documents\\processing\\processing-java.exe --sketch=C:\\Users\\armin\\OneDrive\\ncode_projects\\summerstreet\\master_script_v5 --run")
                @cmd.run_command
            end
        end
        
        def go
            begin
                # thrInit.join
                thrPID = Thread.new do
                    sleep(4)
                    @pids_captured = Array.new
                    @cmdp = Mixlib::ShellOut.new('tasklist /v /fi "IMAGENAME eq java.exe" /fo list | findstr "PID"')
                    @cmdp.run_command
                    @pids = @cmdp.stdout.split("\n")
                    @pids.each do |pid|
                        puts pid
                        # pid.is_string
                        begin
                            pd = pid.to_s.match(/(\d.*)/).to_s.chomp
                            puts pd
                            @pids_captured.push(pd)
                        rescue => exception
                            puts pid
                            puts "excepted"
                        end
                    end

                    # @pidcaptured = @cmdp.stdout.match(/(\d.*)/).to_s.chomp
                    puts "captured pid ", @pids_captured
                end
                thrPID.join
                # thrInit.join
                thr = Thread.new do
                    # cmd.timeout=59
                    sleep(5)
                    puts "starting the second one"
                    @cmd4 = Mixlib::ShellOut.new("C:\\Users\\armin\\Documents\\processing\\processing-java.exe --sketch=C:\\Users\\armin\\OneDrive\\ncode_projects\\summerstreet\\master_script_v5 --run")
                    @cmd4.run_command
                end
                # thr.join
                # thrPID.join
                thrEnd = Thread.new do
                    sleep(50)
                    puts "killing the first one"
                    @pids_captured.each do |pidcaptured| 
                        puts pidcaptured
                        @cmd2 = Mixlib::ShellOut.new("taskkill /T /F /pid #{pidcaptured}")
                        @cmd2.run_command
                    end
                    # @cmd3 = Mixlib::ShellOut.new("C:\\Users\\armin\\Documents\\processing\\processing-java.exe --sketch=C:\\Users\\armin\\OneDrive\\ncode_projects\\summerstreet\\master_script_v5 --run")
                    # @cmd3.run_command
                end
                thrEnd.join
                puts "joining the kill"
            # end
            rescue => exception
                puts "rescuing someting"
            end

            puts "end! "
        end
  

    end

end

p = ProcessingAppManager::ProcessingAppEvent.new


scheduler.every '60m' do
    p.go
end

scheduler.join