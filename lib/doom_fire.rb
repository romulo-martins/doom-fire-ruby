# frozen_string_literal: true

require 'gosu'
require_relative 'fire_engine'
require_relative 'color'

WIDTH  = 400
HEIGHT = 400
PIXEL  = 5

FIRE_WIDTH  = WIDTH / PIXEL
FIRE_HEIGHT = HEIGHT / PIXEL

class DoomFire < Gosu::Window
  def initialize
    super WIDTH, HEIGHT, false, 1000 / 15
    self.caption = 'Doom Fire'

    @engine = FireEngine.new(FIRE_WIDTH, FIRE_HEIGHT)
    @engine.start
  end

  def update
    @engine.calculate_propagation
  end

  def draw
    FIRE_HEIGHT.times do |row|
      FIRE_WIDTH.times do |col|
        color = @engine.get_color(row, col)
        draw_rect(
          (col * PIXEL), (row * PIXEL),
          PIXEL, PIXEL,
          Gosu::Color.rgb(color[:r], color[:g], color[:b])
        )
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::KbUp     then @engine.increase_decay
    when Gosu::KbDown   then @engine.decrease_decay
    when Gosu::KbLeft   then @engine.move_left
    when Gosu::KbRight  then @engine.move_right
    when Gosu::KbSpace  then @engine.move_center
    when Gosu::KbEscape then close
    end
  end
end
