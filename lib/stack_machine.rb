class StackMachine

  UnrecognizedOperation = Class.new(ArgumentError)
  ProcessingError = Class.new(RuntimeError)

  def initialize
    @stack = new_internal_stack
  end

  def process(word)
    halt_on_error do
      run(word)
    end
  end

  private

  def new_internal_stack
    stack = []
    (class << stack;self end).define_method :pop! do
      fail ProcessingError if empty?
      self.pop
    end
    stack
  end

  def halt_on_error
    begin
      yield
    rescue ProcessingError
      -1
    end
  end

  def run(word)
    word.chars.each do |char|
      if digit?(char)
        @stack.push(char.to_i)
      else
        @stack.push(operator(char).apply(@stack))
      end
    end
    @stack.pop!
  end

  def digit?(char)
    char =~ /\d/
  end


  class BinaryOperator
    FUNCTION = ->(op, lh, rh) { lh.send(op, rh) }

    def apply(stack)
      FUNCTION[symbol, stack.pop!, stack.pop!]
    end

    def symbol
      fail "define me"
    end
  end

  class << (ADDITION = BinaryOperator.new)
    def symbol
      "+"
    end
  end

  class << (MULTIPLICATION = BinaryOperator.new)
    def symbol
      "*"
    end
  end

  def operator(symbol)
    fail_if_none = lambda { fail UnrecognizedOperation.new(symbol) }
    [ADDITION, MULTIPLICATION].detect(fail_if_none) { |op| op.symbol == symbol }
  end
end