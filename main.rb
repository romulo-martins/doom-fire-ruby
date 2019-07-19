require_relative 'lib/fire'

def start
	fire = Fire.new(60, 30)
	fire.create_data_structure
	fire.create_source
	fire.render
	 
	1000.times { fire.calculate_propagation }
end

start