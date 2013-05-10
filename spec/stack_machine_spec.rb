require "spec_helper"

describe StackMachine do

  let(:machine) { StackMachine.new }

  describe ".process" do
    it "pushes one digit onto the stack " do
      machine.process("1").should == 1
    end

    it "pushes two digits onto the stack " do
      machine.process("13").should == 3
    end

    it "performs addition of two digits" do
      machine.process("13+").should == 4
    end

    it "performs both addition and multiplication" do
      machine.process("13+62*7+*").should == 76
    end

    it "halts on error during processing" do
      machine.process("11++").should == -1
    end

    it "raises an error on unrecognized operation" do
      expect { machine.process("|") }.to raise_error(StackMachine::UnrecognizedOperation)
    end
  end
end
