require 'spec_helper'

describe Piet::Codel do
  def int_value(hex)
    hex.to_i(16)
  end
  describe "color constants" do
    specify { Piet::Codel::RED.color.should ==            int_value("FF0000FF") }
    specify { Piet::Codel::LIGHT_RED.color.should ==      int_value("FFC0C0FF") }
    specify { Piet::Codel::DARK_RED.color.should ==       int_value("C00000FF") }
    specify { Piet::Codel::YELLOW.color.should ==         int_value("FFFF00FF") }
    specify { Piet::Codel::LIGHT_YELLOW.color.should ==   int_value("FFFFC0FF") }
    specify { Piet::Codel::DARK_YELLOW.color.should ==    int_value("C0C000FF") }
    specify { Piet::Codel::GREEN.color.should ==          int_value("00FF00FF") }
    specify { Piet::Codel::LIGHT_GREEN.color.should ==    int_value("C0FFC0FF") }
    specify { Piet::Codel::DARK_GREEN.color.should ==     int_value("00C000FF") }
    specify { Piet::Codel::CYAN.color.should ==           int_value("00FFFFFF") }
    specify { Piet::Codel::LIGHT_CYAN.color.should ==     int_value("C0FFFFFF") }
    specify { Piet::Codel::DARK_CYAN.color.should ==      int_value("00C0C0FF") }
    specify { Piet::Codel::BLUE.color.should ==           int_value("0000FFFF") }
    specify { Piet::Codel::LIGHT_BLUE.color.should ==     int_value("C0C0FFFF") }
    specify { Piet::Codel::DARK_BLUE.color.should ==      int_value("0000C0FF") }
    specify { Piet::Codel::MAGENTA.color.should ==        int_value("FF00FFFF") }
    specify { Piet::Codel::LIGHT_MAGENTA.color.should ==  int_value("FFC0FFFF") }
    specify { Piet::Codel::DARK_MAGENTA.color.should ==   int_value("C000C0FF") }
    specify { Piet::Codel::WHITE.color.should ==          int_value("FFFFFFFF") }
    specify { Piet::Codel::BLACK.color.should ==          int_value("000000FF") }
  end

  describe "distance" do

    context "same hue and lightness" do
      it "should return [0, 0] for the same color" do
        Piet::Codel::RED.distance(Piet::Codel::RED).should == [0, 0]
      end
    end

    context "same hue" do
      it "should return [0, 1] for 1 step in darker" do
        Piet::Codel::LIGHT_RED.distance(Piet::Codel::RED).should == [0, 1]
      end
      it "should return [0, 2] for 2 step in darker" do
        Piet::Codel::LIGHT_RED.distance(Piet::Codel::DARK_RED).should == [0, 2]
      end
      it "should return [0, 2] for 1 step in darker (cycle)" do
        Piet::Codel::DARK_RED.distance(Piet::Codel::LIGHT_RED).should == [0, 1]
      end
    end

    context "same lightness" do
      it "should return [1, 0] for 1 step in hue" do
        Piet::Codel::RED.distance(Piet::Codel::YELLOW).should == [1, 0]
      end
      it "should return [2, 0] for 2 steps in hue" do
        Piet::Codel::YELLOW.distance(Piet::Codel::CYAN).should == [2, 0]
      end
      it "should should cycle" do
        Piet::Codel::MAGENTA.distance(Piet::Codel::RED).should == [1, 0]
      end
      it "should return [5, 0] for 5 steps in hue" do
        Piet::Codel::YELLOW.distance(Piet::Codel::RED).should == [5, 0]
      end
    end

    context "both different" do
      it "should return [1, 1] for 1 step in hue and lightness" do
        Piet::Codel::RED.distance(Piet::Codel::DARK_YELLOW).should == [1, 1]
      end

      it "should return [1, 2] for 1 step in hue and 2 in lightness" do
        Piet::Codel::LIGHT_RED.distance(Piet::Codel::DARK_YELLOW).should == [1, 2]
      end

      it "should return [5, 2] for 5 steps in hue and 2 in lightness" do
        Piet::Codel::LIGHT_RED.distance(Piet::Codel::DARK_MAGENTA).should == [5, 2]
      end
      it "should return [1, 2] for 1 steps in hue and 2 in lightness" do
        Piet::Codel::LIGHT_MAGENTA.distance(Piet::Codel::DARK_RED).should == [1, 2]
      end
    end
  end
end