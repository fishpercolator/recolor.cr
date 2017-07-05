require "./spec_helper"

def subject(svg : String)
  SvgColorizer.new(%{<?xml version="1.0" encoding="utf-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">#{svg}})
end

describe "SvgColorizer" do
  
  describe "#colorize" do
    context "filled circle" do
      it "adds a fill to the root element" do
        filled_circle = subject( %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" /></svg>})
        filled_circle.colorize("#8080ff").should match(%r{<svg [^>]*fill="#8080ff"})
      end
    end
  end
  
end
