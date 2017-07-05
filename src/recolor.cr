require "kemal"
require "./recolor/*"

get "/" do
  xml = %{<?xml version="1.0" encoding="utf-8"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"><svg width="120" height="120" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg"> <ellipse cx="60" cy="60" rx="50" ry="50" /></svg>}
  %{<img src="#{SvgColorizer.new(xml).colorize_as_data("green")}">}
end

Kemal.run
