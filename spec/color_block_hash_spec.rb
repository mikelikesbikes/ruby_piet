require 'color_block_hash'

describe Piet::ColorBlockHash do

  def graph_value(x, y)
    graph = Piet::ColorBlockHash.from_array(@graph)
    coord = [x, y]
    graph[coord]
  end

  describe "creating from array" do
    it "should accept an array" do
      expect{ Piet::ColorBlockHash.from_array([]) }.to_not raise_error
    end
  end

  describe "a 1x1 image" do
    it "should return 1 for [0, 0]" do
      @graph = [["a"]]
      graph_value(0, 0).should == 1
    end
  end

  describe "a 2x1 image" do
    describe "[a, b]" do
      before(:each) do
        @graph = [["a", "b"]]
      end
      specify { graph_value(0, 0).should == 1 }
      specify { graph_value(1, 0).should == 1 }
    end

    describe "[a, a]" do
      before(:each) do
        @graph = [["a", "a"]]
      end
      specify { graph_value(0, 0).should == 2 }
      specify { graph_value(1, 0).should == 2 }
    end
  end

  describe "a 2x2 image" do
    describe "[[a, b], [c, d]]" do
      before(:each) do
        @graph = [["a", "b"], ["c", "d"]]
      end
      specify { graph_value(0, 0).should == 1 }
      specify { graph_value(1, 0).should == 1 }
      specify { graph_value(0, 1).should == 1 }
      specify { graph_value(1, 1).should == 1 }
    end

    describe "[[a, a], [b, b]]" do
      before(:each) do
        @graph = [["a", "a"], ["b", "b"]]
      end
      specify { graph_value(0, 0).should == 2 }
      specify { graph_value(1, 0).should == 2 }
      specify { graph_value(0, 1).should == 2 }
      specify { graph_value(1, 1).should == 2 }
    end

    describe "[[a, a], [a, b]]" do
      before(:each) do
        @graph = [["a", "a"], ["a", "b"]]
      end
      specify { graph_value(0, 0).should == 3 }
      specify { graph_value(1, 0).should == 3 }
      specify { graph_value(0, 1).should == 3 }
      specify { graph_value(1, 1).should == 1 }
    end
  end

  describe "a 3x3 image" do
    describe "[[x, a, x], [a, a, a], [x, a, x]]" do
      before(:each) do
        @graph = [%w{x a x}, %w{a a a}, %w{x a x}]
      end
      specify { graph_value(0, 0).should == 1 }
      specify { graph_value(1, 0).should == 5 }
      specify { graph_value(2, 0).should == 1 }
      specify { graph_value(0, 1).should == 5 }
      specify { graph_value(1, 1).should == 5 }
      specify { graph_value(2, 1).should == 5 }
      specify { graph_value(0, 2).should == 1 }
      specify { graph_value(1, 2).should == 5 }
      specify { graph_value(2, 2).should == 1 }
    end

    describe "[[x, x, x], [x, x, a], [x, a, x]]" do
      before(:each) do
        @graph = [%w{x x x}, %w{x x a}, %w{x a x}]
      end
      specify { graph_value(0, 0).should == 6 }
      specify { graph_value(1, 0).should == 6 }
      specify { graph_value(2, 0).should == 6 }
      specify { graph_value(0, 1).should == 6 }
      specify { graph_value(1, 1).should == 6 }
      specify { graph_value(2, 1).should == 1 }
      specify { graph_value(0, 2).should == 6 }
      specify { graph_value(1, 2).should == 1 }
      specify { graph_value(2, 2).should == 1 }
    end
  end
end