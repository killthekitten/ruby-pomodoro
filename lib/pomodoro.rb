require 'ruby-progressbar'
require 'growl'

class Pomodoro

  def initialize(options)
    options[:length] = 1500 if options[:length] == 0
    @t = Time.now
    @end_time = Time.now + options[:length]
    @a = ProgressBar.create(:total => options[:length], :format => '%t %a |%b>>%i| %p%%')
    @seconds_elapsed = 0
    @interval = 1
  end

  def start
    while Time.now < @end_time
      trap_interrupt
      @a.refresh
      sleep @interval #&&
      @seconds_elapsed += @interval
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

      @interval.times { @a.increment }

    end

    if Time.now < @end_time
      gather_task_annotation
      # send something to growl
      # prompt user for annotation content for taskwarrior
      # consider asking user if pomo was successful
      private

      def gather_task_annotation
        print "What did you accomplish? (annotated to Task)"
        input = gets.chomp
        a = %x{task #{@task_number} annotate '#{input}'}
      end
      #
    end

  end # start
  
  def trap_interrupt
    Signal.trap('INT') do
      exit!(1) if @wants_to_quit
      @wants_to_quit = true
      $stderr.puts
      $stderr.puts 'Exiting... Interrupt again to exit immediately.'
    end
  end

# TODO
# - integrate growl notifications for each 5 min passed? or 10 and 5 min remaining?
# - integrate it into annotating to taskwarrior tasks, perhaps via a 'tp' alias
#    that will take a numeric argument and then automatically annotates to task warrior
# - allow for custom annotations to taskwarrior item via a gets prompt at end of timer
# 

end

def usage
  $stderr.puts <<-USAGE
ruby-pomodoro:
>$ ruby  #{__FILE__.sub(/.rb$/,'')} <SECONDS>
    USAGE
  $stderr.puts 'You did not have Growl installed!' unless Growl.installed?
end

if File.identical?(__FILE__, $0)
  ARGV[0]== '-h' ? usage : Pomodoro.new(length: ARGV[0].to_i).start
end
