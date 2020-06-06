require 'gosu'
require_relative 'engine'
require_relative 'color'

WIDTH = 400
HEIGHT = 280
TILE = 5

FIRE_WIDTH = WIDTH / TILE
FIRE_HEIGHT = HEIGHT / TILE

class DoomFire < Gosu::Window
  def initialize
    super WIDTH, HEIGHT, false, 1000/15
    self.caption = "Doom Fire"

    @palete = Color::PALETE
    @engine = FireEngine.new(FIRE_WIDTH, FIRE_HEIGHT)
    @engine.start
  end
  
  def update
    @engine.calculate_propagation
  end
  
  def draw
    FIRE_HEIGHT.times do |row|
      FIRE_WIDTH.times do |col|
        color = get_color row, col
        draw_rect(
          (col * TILE), (row * TILE), 
          TILE, TILE, 
          Gosu::Color.rgb(color[:r], color[:g], color[:b])
        )
			end
    end
  end
  
  private 
  
  def get_color row, col
    pixel_index = col + (FIRE_WIDTH * row)
    fire_intensity = @engine.fire_pixels[pixel_index]
    @palete[fire_intensity]
  end
end

DoomFire.new.show
