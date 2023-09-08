module Pipe
  def self.next(klass, ignore_call: false)
    raise "Invalid call of #{klass.class} class in the pipe" unless klass.respond_to?(:call)

    unless ignore_call
      sleep 1
      klass.call
    end

    klass
  end

  def next(klass, ignore_call: false)
    Pipe.next(klass, ignore_call: ignore_call)
  end
end

class Step1
  include Pipe

  def call
    puts "#{self.class} must need to implement to call next"
  end
end

class Step2
  include Pipe

  def call
    puts "#{self.class} must need to implement to call next"
  end
end

class Step3
  include Pipe

  def call
    puts "#{self.class} must need to implement to call next"
  end
end

class LastStep
  def call
    puts "#{self.class} is the last step in the pipe and it doesn't need to call or implement next"
  end
end

pipe = Pipe.next(Step1.new)
           .next(Step2.new)
           .next(Step3.new)
           .next(
             Pipe.next(Step1.new)
                 .next(Step2.new)
                 .next(
                   Pipe.next(Step1.new), ignore_call: true), ignore_call: true)
           .next(LastStep.new)
