require 'ruby-progressbar'

class Pomodoro
  def initialize
    @t = Time.now
    @end_time = Time.now + 1500 # seconds in 25 min
    @a = ProgressBar.create(:total => 1500, :format => '%t %a |%b>>%i| %p%%')
    @seconds_elapsed = 0
  end

  def start
    while Time.now < @end_time
      @a.increment
      sleep 1 && @seconds_elapsed += 1
      case @seconds_elapsed
      when 10
        # Good luck warning
        Growl.notify_warning "Work hard like a tomato"
      when 1200
        # 5 minute warning
        Growl.notify_warning "5 minute warning"
      when 1440
        # 1 minute warning
        Growl.notify_warning "1 minute warning"
      end

    end

    if Time.now < @end_time
      # send something to growl
      # prompt user for annotation content for taskwarrior
      # consider asking user if pomo was successful
      #
    end

  end # start

# TODO
# - integrate growl notifications for each 5 min passed? or 10 and 5 min remaining?
# - integrate it into annotating to taskwarrior tasks, perhaps via a 'tp' alias
#    that will take a numeric argument and then automatically annotates to task warrior
# - allow for custom annotations to taskwarrior item via a gets prompt at end of timer
# 

end

if File.identical?(__FILE__, $0)
  a = Pomodoro.new
  a.start
end
