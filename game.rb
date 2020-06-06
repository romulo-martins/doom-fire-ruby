require 'gosu'
require_relative 'engine'
require_relative 'color'

WIDTH = 50
HEIGHT = 50
TILE = 10

class DoomFire < Gosu::Window
  def initialize
    super (WIDTH * TILE), (HEIGHT * TILE)
    self.caption = "Doom Fire"

    @palete = Color::PALETE
    @engine = FireEngine.new(WIDTH, WIDTH)
    @engine.start
  end
  
  def update
    @engine.calculate_propagation
  end
  
  def draw
    fire_pixels = @engine.fire_pixels
    HEIGHT.times do |row|
			WIDTH.times do |col|
				pixel_index = col + (WIDTH * row)
				fire_intensity = fire_pixels[pixel_index]
				color = @palete[fire_intensity]
        draw_rect(
          (col * TILE), (row * TILE), 
          TILE, TILE, 
          Gosu::Color.rgb(color[:r], color[:g], color[:b])
        )
			end
    end
  end
end

DoomFire.new.show
