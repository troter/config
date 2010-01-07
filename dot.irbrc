# .irbrc
require 'irb/completion'
require 'pp'
require 'rubygems'

IRB.conf[:SAVE_HISTORY] = 100000

begin
  require 'win32console'
rescue LoadError
end

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
end
