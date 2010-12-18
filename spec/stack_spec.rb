require 'spec_helper'

describe Piet::Stack do
  describe "creating" do
    specify { subject.dp.should == :right }
    specify { subject.cc.should == :left }
  end

  describe "pushing" do
    specify { subject.push(:first).should == [:first] }
  end

  describe "popping" do
    before(:each) do
      subject.push(:first)
    end
    specify { subject.pop.should == :first }
  end

  describe "adding" do
    before(:each) do
      subject.push(1)
      subject.push(2)
    end
    specify { subject.add.should == [3]}
  end

  describe "subtracting" do
    before(:each) do
      subject.push(7)
      subject.push(5)
    end
    specify { subject.subtract.should == [2] }
  end

  describe "multiplying" do
    before(:each) do
      subject.push(7)
      subject.push(5)
    end
    specify { subject.multiply.should == [35] }
  end

  describe "dividing" do
    before(:each) do
      subject.push(35)
      subject.push(5)
    end
    specify { subject.divide.should == [7]}
  end

  describe "modding" do
    before(:each) do
      subject.push(32)
      subject.push(5)
    end
    specify { subject.mod.should == [2] }
  end

  describe "notting" do
    it "should push 0 for non-zero" do
      subject.push(4)
      subject.not.should == [0]
    end

    it "should push 1 for 0" do
      subject.push(0)
      subject.not.should == [1]
    end
  end

  describe "greater" do
    it "should put 1 when a > b" do
      subject.push(6)
      subject.push(5)
      subject.greater.should == [1]
    end

    it "should put 0 when a < b" do
      subject.push(5)
      subject.push(6)
      subject.greater.should == [0]
    end
  end

  describe "pointer" do
    context "when 1" do
      before(:each) do
        subject.push(1)
      end
      it "should pop a value" do
        subject.pointer.should == []
      end
      it "should rotate clockwise from right" do
        subject.dp = :right
        subject.pointer
        subject.dp.should == :down
      end
      it "should rotate clockwise from down" do
        subject.dp = :down
        subject.pointer
        subject.dp.should == :left
      end
      it "should rotate clockwise from left" do
        subject.dp = :left
        subject.pointer
        subject.dp.should == :up
      end
      it "should rotate clockwise from left" do
        subject.dp = :up
        subject.pointer
        subject.dp.should == :right
      end
    end

    context "when 5" do
      before(:each) do
        subject.push(6)
      end
      it "should pop a value" do
        subject.pointer.should == []
      end
      it "should rotate clockwise" do
        subject.pointer
        subject.dp.should == :left
      end
    end
    context "when negative" do
      before(:each) do
        subject.push(-1)
      end
      it "should pop a value" do
        subject.pointer.should == []
      end
      it "should rotate counter-clockwise from right" do
        subject.dp = :right
        subject.pointer
        subject.dp.should == :up
      end
    end
  end

  describe "switching" do
    it "pops the top value" do
      subject.push(1)
      subject.cc = :right
      subject.switch.should == []
    end

    it "toggles cc 1 time" do
      subject.push(1)
      subject.cc = :right
      subject.switch
      subject.cc.should == :left
    end

    it "toggles cc 4 times" do
      subject.push(4)
      subject.cc = :right
      subject.switch
      subject.cc.should == :right
    end

    it "toggles cc -4 times" do
      subject.push(-4)
      subject.cc = :right
      subject.switch
      subject.cc.should == :right
    end
  end

  describe "duplicating" do
    it "pushes a copy of the top number onto the stack" do
      subject.push(4)
      subject.sdup.should == [4, 4]
    end
  end

  describe "rolling" do
    def roll(stack)
      stack.each { |x| subject.push(x) }
      subject.roll
    end
    context "a positive number of times" do
      it "rolls 5, 2 levels deep" do
        roll([1, 2, 3, 4, 5, 2, 1]).should == [1, 2, 5, 3, 4]
      end
      it "rolls 5 and 4, 2 levels deep" do
        roll([1, 2, 3, 4, 5, 2, 2]).should == [1, 2, 4, 5, 3]
      end
    end

    context "a negative number of times" do
      it "rolls 3, to the front" do
        roll([1, 2, 3, 4, 5, 2, -1]).should == [1, 2, 4, 5, 3]
      end
      it "rolls 4, 3 to the front" do
        roll([1, 2, 3, 4, 5, 2, -2]).should == [1, 2, 5, 3, 4]
      end
    end

    it "should ignore roll if the depth is negative" do
      roll([1, -2, 1]).should == [1]
    end
  end

  describe "outting" do
    let(:output) { Output.new }
    subject {
      Piet::Stack.new(output)
    }
    before(:each) do
      subject.push(72)
    end
    it "should output character" do
      subject.out_char
      output.to_s.should == "H"
    end
    it "should output numbers" do
      subject.out_num
      output.to_s.should == "72"
    end
  end

  describe "inning" do
    subject {
      Piet::Stack.new(nil, @input)
    }
    it "should read characters" do
      @input = Input.new("H")
      subject.in_char.should == [72]
    end
    it "should read numbers" do
      @input = Input.new("74")
      subject.in_num.should == [74]
    end
  end
end

class Output
  def puts(args)
    stream << args
  end

  def to_s
    stream
  end

  private
  def stream
    @stream ||= ""
  end
end

class Input
  def initialize(*stream)
    @stream = stream
  end

  def gets
    stream.shift
  end

  private
  def stream
    @stream
  end
end
