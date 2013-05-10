require 'gtk2'

module Iamwriter
	class IamTextView < Gtk::TextView

		@@min_writing_area	= 400
	
		def initialize(parent_window)
			super()

			@parent_window 		= parent_window
			self.wrap_mode		= Gtk::TextTag::WRAP_WORD
			
			adjust_all
		end

		def adjust_all
			get_parent_window_width

			set_writing_area

			adjust_font_size
			adjust_margins
		end

		def get_parent_window_width
			@parent_window_width	= @parent_window.size[0]
		end

		def set_writing_area
			@writing_area = @@min_writing_area
			if @parent_window_width > 1024
				@writing_area = Integer(@parent_window_width * 0.8) 
			end
		end


		def adjust_font_size
			font_size = 20
			if @parent_window_width < 1024
				font_size = 13
			end

			#puts font_size
			self.modify_font(Pango::FontDescription.new("monospace #{font_size}"))

		end

		def adjust_margins
			new_margin		= IamTextView.calc_margin_size(@parent_window_width, @writing_area)
			self.right_margin	= new_margin
			self.left_margin	= new_margin
		end


		def self.calc_margin_size(window_width, writing_area)
			combined_margin_size = window_width - writing_area
			if combined_margin_size <= 0
				
			end
			combined_margin_size / 2
		end
	end
end
