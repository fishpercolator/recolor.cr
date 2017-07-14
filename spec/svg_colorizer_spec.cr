require "./spec_helper"

def subject(svg : String)
  SvgColorizer.new(%{<?xml version="1.0" encoding="utf-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">#{svg}})
end

describe "SvgColorizer" do
  
  describe "#colorize" do
    context "filled circle" do
      svg = subject %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" /></svg>}
      it "adds a fill to the root element" do
        svg.colorize("#8080ff").should match(%r{<svg [^>]*fill="#8080ff"})
      end
    end
    context "circle with existing fill in root element" do
      svg = subject %{<svg fill="#ff0000" width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" /></svg>}
      it "adds a fill to the root element" do
        svg.colorize("#8080ff").should match(%r{<svg [^>]*fill="#8080ff"})
      end
      it "removes the existing fill" do
        svg.colorize("#8080ff").should_not match(%r{fill="#ff0000"})
      end
    end
    context "circle with its own fill defined" do
      svg = subject %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse fill="#008000" cx="60" cy="60" rx="50" ry="50" /></svg>}
      it "updates the existing fill on the child element" do
        svg.colorize("#8080ff").should match(%r{<ellipse [^>]*fill="#8080ff"})
      end
      it "removes the old fill" do
        svg.colorize("#8080ff").should_not match(%r{<ellipse [^>]*fill="#008000"})
      end
    end
    context "hollow circle" do
      svg = subject %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" stroke="black" stroke-width="5" fill="none"/></svg>}
      it "updates the stroke value" do
        svg.colorize("#8080ff").should match(%r{<ellipse [^>]*stroke="#8080ff"})
      end
      it "leaves the empty fill alone" do
        svg.colorize("#8080ff").should match(%r{<ellipse [^>]*fill="none"})
      end
    end
    context "circle coloured with CSS" do
      svg = subject %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <style type="text/css">ellipse { fill: goldenrod; }</style><ellipse cx="60" cy="60" rx="50" ry="50" /></svg>}
      it "fixes the CSS" do
        svg.colorize("#8080ff").should match(%r{<style.*fill: #8080ff;.*</style>})
      end
    end
    context "circle coloured with inline CSS" do
      svg = subject %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" style="fill:#ff0000"/></svg>}
      it "fixes the inline CSS" do
        svg.colorize("#8080ff").should match(%r{style="fill: #8080ff;"})
      end
    end
  end
  
  describe "#colorize_as_data" do
    it "returns the correct data URI" do
      svg = subject %{<svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" /></svg>}
      svg.colorize_as_data("#8080ff").should eq("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjAvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMtU1ZHLTIwMDEwOTA0L0RURC9zdmcxMC5kdGQiPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEyMCIgaGVpZ2h0PSIxMjAiIHZpZXdCb3g9IjAgMCAxMjAgMTIwIiBmaWxsPSIjODA4MGZmIj4gPGVsbGlwc2UgY3g9IjYwIiBjeT0iNjAiIHJ4PSI1MCIgcnk9IjUwIi8+PC9zdmc+Cg==")
    end
  end
  
end
