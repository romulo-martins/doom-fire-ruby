# frozen_string_literal: true

class FireEngine
  attr_reader :fire_pixels

  def initialize(width = 10, height = 10)
    @width = width
    @height = height
    @fire_pixels = []
    @total_pixels = height * width
    end

  def start
    create_data_structure
    create_source
  end

  def create_data_structure
    @total_pixels.times { @fire_pixels << 0 }
  end

  def create_source
    @width.times do |col|
      pixel_index = (@total_pixels - 1) - col
      @fire_pixels[pixel_index] = 36
    end
  end

  def calculate_propagation
    @height.times do |row|
      @width.times do |col|
        pixel_index = col + (@width * row)
        update_intesity_pixel(pixel_index)
      end
    end
  end

  def console_debug
    @height.times do |row|
      @width.times do |col|
        pixel_index = col + (@width * row)
        fire_intensity = @fire_pixels[pixel_index]
        color = @palete[fire_intensity]
        print " #{fire_intensity} "
      end
      puts
    end
    puts
  end

  private

  def compute_new_intensity(pixel_index)
    decay = rand(1..3)
    fire_intensity = @fire_pixels[pixel_index] - decay
    fire_intensity >= 0 ? fire_intensity : 0
  end

  def update_intesity_pixel(pixel_index)
    below_pixel_index = pixel_index + @width
    return if below_pixel_index >= @total_pixels

    new_intensity = compute_new_intensity(below_pixel_index)
    @fire_pixels[pixel_index] = new_intensity
  end
end
