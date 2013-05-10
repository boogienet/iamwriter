require_relative "./iamwriter/version"
require_relative "./iamtextview"
require 'gtk2'

module Iamwriter

	class IamWindow < Gtk::Window

		@textbox
		@control = true
		@open_file = ""

		def initialize
			super
    
		        set_title "I am writer" 

       			# initialize file
			@open_file = ""
 
			set_default_size 700, 580
			set_window_position Gtk::Window::POS_CENTER
      
        		init_ui
			init_accel
 
        		signal_connect "destroy" do 
				quit_writer	
			end

			signal_connect "configure_event" do
				@textbox.adjust_all
				false	
			end

			show_all
			# start maximized
			# self.maximize
		end
 
		def init_accel
			ag = Gtk::AccelGroup.new
			# ctrl-o, open a file
			ag.connect(Gdk::Keyval::GDK_O, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
				file_open
			}
			# ctrl-f, maximize
			ag.connect(Gdk::Keyval::GDK_F, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
				self.maximize
			}
			# ctrl-s, save
			ag.connect(Gdk::Keyval::GDK_S, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
				file_save
			}
			# ctrl-q, quit
			ag.connect(Gdk::Keyval::GDK_Q, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
				quit_writer	
			}
			#ctrl-5, debug information
			ag.connect(Gdk::Keyval::GDK_5, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
				debug
			}
			#ctrk-6, adjust!
			ag.connect(Gdk::Keyval::GDK_6, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
				@textbox.adjust_all
			}
			self.add_accel_group(ag)
		end 
  
		def debug
			puts "@open_file #{@open_file}"
			puts "textbuffer.modified? #{@textbox.buffer.modified?}"
			puts "window size #{self.size}"
		end
 
		def init_ui
   			container	= Gtk::HBox.new
			scrolled_win	= Gtk::ScrolledWindow.new
			@textbox	= IamTextView.new(self)

			container.set_spacing(50)

			scrolled_win.add(@textbox)
			scrolled_win.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_ALWAYS)
			container.pack_start(scrolled_win)
			add(container)
		end

		def quit_writer
			# want to save regardless, if the buffer has been touched
			if @textbox.buffer.modified?
				file_save	
			end
			Gtk.main_quit
		end
	
		def file_open
			dialog = Gtk::FileChooserDialog.new("Open File",
							   self,
							   Gtk::FileChooser::ACTION_OPEN,
							   nil,
							   [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL],
							   [Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT])
			if dialog.run == Gtk::Dialog::RESPONSE_ACCEPT
				@open_file = dialog.filename
				contents = File.read(@open_file)
				@textbox.set_buffer(Gtk::TextBuffer.new.set_text(contents))
				@textbox.buffer.set_modified(false)
				puts "modified? #{@textbox.buffer.modified?}"
			end
			dialog.destroy
		end
		
		def file_save
			unless !@open_file.empty?
				dialog = Gtk::FileChooserDialog.new("Save File",
								   self,
								   Gtk::FileChooser::ACTION_SAVE,
								   nil,
								   [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL],
								   [Gtk::Stock::SAVE, Gtk::Dialog::RESPONSE_ACCEPT])
				if dialog.run == Gtk::Dialog::RESPONSE_ACCEPT
					@open_file = dialog.filename
				end
				dialog.destroy
			end

			contents = @textbox.buffer.text

			# get a temporary filename
			unless !@open_file.empty?
				@open_file = "tmp.txt"
			end
			File.write(@open_file, contents)
			
		end
	end


end
