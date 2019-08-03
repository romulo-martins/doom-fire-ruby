require 'rainbow'
require_relative 'color'

class Fire 
	def initialize(width=0, height=0)
		@width = width
		@height = height
		@pixels_array = []
		@number_of_pixels = height * width 
		@palete = load_palete
	end

	def create_data_structure
		@number_of_pixels.times { @pixels_array << 0 }
	end

	def create_source
		@width.times do |col|
			pixel_index =  @number_of_pixels - col - 1
			@pixels_array[pixel_index] = 36
		end	
	end

	def calculate_propagation
		@height.times do |row|
			@width.times do |col|
				pixel_index = (col) + (@width * row)
				update_intesity_pixel(pixel_index)
			end
		end
		render
	end	

	def render
		@height.times do |row|
			@width.times do |col|
				pixel_index = (col) + (@width * row)
				fire_intensity = @pixels_array[pixel_index]
				color = @palete[fire_intensity]
				print Rainbow(" ").background(color[:r], color[:g], color[:b])
			end
			puts
		end
		sleep 0.1
		system("clear") || system("cls")
	end

	private 

	def load_palete
		Color::PALETE
	end

	def compute_new_intensity(pixel_index)
		decay = rand(1..3)
		fire_intensity = @pixels_array[pixel_index - decay] - decay 
		fire_intensity >= 0 ? fire_intensity : 0
	end	

	def update_intesity_pixel(pixel_index)
		below_pixel_index = pixel_index + @width
		return if below_pixel_index >= @width * @height

		new_intensity =  compute_new_intensity(below_pixel_index)
		@pixels_array[pixel_index] = new_intensity
	end	

end