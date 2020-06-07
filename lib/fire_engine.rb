# frozen_string_literal: true

require_relative 'color'

class FireEngine
  attr_reader :fire_pixels

  LEFT = -1
  CENTER = 0
  RIGHT = 1

  MIN_DECAY = 3

  def initialize(width = 10, height = 10)
    @width = width
    @height = height
    @fire_pixels = []
    @total_pixels = height * width
    @palete = Color::PALETE
    @move = CENTER
    @decay_intensity = MIN_DECAY
  end

  def start
    create_data_structure
    create_source
  end

  def create_data_structure
    (@total_pixels - 1).times { @fire_pixels << 0 }
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

  def move_center
    @move = CENTER
  end

  def move_left
    @move = LEFT
  end

  def move_right
    @move = RIGHT
  end

  def increase_decay
    @decay_intensity -= 1 if @decay_intensity > 0
  end

  def decrease_decay
    @decay_intensity += 1
  end

  def get_color(row, col)
    pixel_index = col + (FIRE_WIDTH * row)
    fire_intensity = fire_pixels[pixel_index]
    @palete[fire_intensity]
  end

  private

  def compute_new_intensity(pixel_index)
    decay = rand(0..@decay_intensity)
    fire_intensity = @fire_pixels[pixel_index] - decay
    fire_intensity >= 0 ? fire_intensity : 0
  end

  def update_intesity_pixel(pixel_index)
    below_pixel_index = pixel_index + @width
    return if below_pixel_index >= @total_pixels

    new_intensity = compute_new_intensity(below_pixel_index)
    decay = rand(1..3)
    case @move
    when LEFT then
      new_pixel_index = pixel_index - decay
      pixel_index = new_pixel_index > 0 ? new_pixel_index : pixel_index
    when RIGHT
      pixel_index += decay
    end
    @fire_pixels[pixel_index] = new_intensity
  end
end
