require 'spec_helper'

describe Piet::Codel do
  include Piet::Codel::Colors

  def int_value(hex)
    hex.to_i(16)
  end

  describe "color constants" do
    specify { RED.color.should ==           int_value("FF0000FF") }
    specify { LIGHT_RED.color.should ==     int_value("FFC0C0FF") }
    specify { DARK_RED.color.should ==      int_value("C00000FF") }
    specify { YELLOW.color.should ==        int_value("FFFF00FF") }
    specify { LIGHT_YELLOW.color.should ==  int_value("FFFFC0FF") }
    specify { DARK_YELLOW.color.should ==   int_value("C0C000FF") }
    specify { GREEN.color.should ==         int_value("00FF00FF") }
    specify { LIGHT_GREEN.color.should ==   int_value("C0FFC0FF") }
    specify { DARK_GREEN.color.should ==    int_value("00C000FF") }
    specify { CYAN.color.should ==          int_value("00FFFFFF") }
    specify { LIGHT_CYAN.color.should ==    int_value("C0FFFFFF") }
    specify { DARK_CYAN.color.should ==     int_value("00C0C0FF") }
    specify { BLUE.color.should ==          int_value("0000FFFF") }
    specify { LIGHT_BLUE.color.should ==    int_value("C0C0FFFF") }
    specify { DARK_BLUE.color.should ==     int_value("0000C0FF") }
    specify { MAGENTA.color.should ==       int_value("FF00FFFF") }
    specify { LIGHT_MAGENTA.color.should == int_value("FFC0FFFF") }
    specify { DARK_MAGENTA.color.should ==  int_value("C000C0FF") }
    specify { WHITE.color.should ==         int_value("FFFFFFFF") }
    specify { BLACK.color.should ==         int_value("000000FF") }
  end

  describe "distance" do

    context "same hue and lightness" do
      it "should return [0, 0] for the same color" do
        RED.distance(RED).should == [0, 0]
      end
    end

    context "same hue" do
      it "should return [0, 1] for 1 step in darker" do
        LIGHT_RED.distance(RED).should == [0, 1]
      end
      it "should return [0, 2] for 2 step in darker" do
        LIGHT_RED.distance(DARK_RED).should == [0, 2]
      end
      it "should return [0, 2] for 1 step in darker (cycle)" do
        DARK_RED.distance(LIGHT_RED).should == [0, 1]
      end
    end

    context "same lightness" do
      it "should return [1, 0] for 1 step in hue" do
        RED.distance(YELLOW).should == [1, 0]
      end
      it "should return [2, 0] for 2 steps in hue" do
        YELLOW.distance(CYAN).should == [2, 0]
      end
      it "should should cycle" do
        MAGENTA.distance(RED).should == [1, 0]
      end
      it "should return [5, 0] for 5 steps in hue" do
        YELLOW.distance(RED).should == [5, 0]
      end
    end

    context "both different" do
      it "should return [1, 1] for 1 step in hue and lightness" do
        RED.distance(DARK_YELLOW).should == [1, 1]
      end

      it "should return [1, 2] for 1 step in hue and 2 in lightness" do
        LIGHT_RED.distance(DARK_YELLOW).should == [1, 2]
      end

      it "should return [5, 2] for 5 steps in hue and 2 in lightness" do
        LIGHT_RED.distance(DARK_MAGENTA).should == [5, 2]
      end
      it "should return [1, 2] for 1 steps in hue and 2 in lightness" do
        LIGHT_MAGENTA.distance(DARK_RED).should == [1, 2]
      end
    end
  end
end