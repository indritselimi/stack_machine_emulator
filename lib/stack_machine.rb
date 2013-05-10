class StackMachine

  def initialize
    @stack = []
  end

  def process(word)
    halt_on_error do
      run(word)
    end
  end

  UnrecognizedOperation = Class.new(ArgumentError)
  ProcessingError = Class.new(RuntimeError)

  private

  def run(word)
    word.chars.each do |char|
      if digit?(char)
        @stack.push(char.to_i)
      else
        @stack.push(operator(char).apply(@stack))
      end
    end
    @stack.pop
  end

  def halt_on_error
    begin
      yield
    rescue ProcessingError
      -1
    end
  end

  def digit?(char)
    char =~ /\d/
  end

  class << (ADDITION = Object.new)
    def apply(stack)
      fail ProcessingError.new if stack.size < 2

      stack.pop + stack.pop
    end

    def symbol
      "+"
    end
  end

  class << (MULTIPLICATION = Object.new)
    def apply(stack)
      fail ProcessingError.new if stack.size < 2

      stack.pop * stack.pop
    end

    def symbol
      "*"
    end
  end

  def operator(symbol)
    op = [ADDITION, MULTIPLICATION].detect { |op| op.symbol == symbol }
    fail UnrecognizedOperation.new(symbol) if op.nil?
    op
  end
end