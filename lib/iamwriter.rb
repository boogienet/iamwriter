require_relative "./iamwriter/version"
require_relative "./iamwindow"
require 'gtk2'

module Iamwriter

end

Gtk.init
    window = Iamwriter::IamWindow.new
Gtk.main
