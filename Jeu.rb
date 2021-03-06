require "gtk3"
require "optparse"
require "fileutils"
Gtk.init
class Jeu
	def initialize()
		@window = Gtk::Window.new
		@grille = Gtk::Grid.new
		@grille.set_border_width(10)
		h = 8
		l = 11
		@window.add(@grille)
		@traith = Array.new(l*(h+1))
		@traitv = Array.new(h*(l+1))
		signaux()

		@traith.each_index { |index|
			box = Gtk::EventBox.new()
			box.set_size_request(32,8)
			box.signal_connect('button_release_event'){|widget,event|
				if(event.state.button1_mask?)
					puts "CLICK GAUCHE !"
					clique = :CLIC_GAUCHE
				elsif(event.state.button2_mask?)
					puts "CLICK MOLETTE !"
				elsif(event.state.button3_mask?)
					puts "CLICK DROIT !"
					clique = :CLIC_DROIT
				end
				puts"clicked h "+index.to_s
				if(index%(h+1)==0)
					#jouer( (index/(h+1)).to_i, 0, :HAUT , clique)
					puts"case bas,"+(index/(h+1)).to_i.to_s+", 0"
				else
					#jouer( (index/(h+1)).to_i, index%(h+1)-1, :BAS , clique)
					puts"case haut, "+ (index/(h+1)).to_i.to_s + (index%(h+1)-1).to_s 
				end
				
			}
			@traith[index] = box
		} 
		
		@traitv.each_index { |index|
			box = Gtk::EventBox.new()
			box.set_size_request(8,32)
			box.signal_connect('button_release_event'){|widget,event|
				if(event.state.button1_mask?)
					puts "CLICK GAUCHE !"
					clique = :CLIC_GAUCHE
				elsif(event.state.button2_mask?)
					puts "CLICK MOLETTE !"
				elsif(event.state.button3_mask?)
					puts "CLICK DROIT !"
					clique = :CLIC_DROIT
				end
				puts"clicked v "+index.to_s
				if(index < h)
					puts"case droite, 0 ,"+index.to_s
					#jouer(0, index, :GAUCHE, clique)
				else
					puts"case gauche,"+((index-h)/h.to_i).to_s + (index%h).to_s
					#jouer((index-h)/h.to_i, index%h, :DROITE, clique)
				end
			}
			@traitv[index] = box
		} 

		indiceh=0
		indicev=0
		for i in 0..l*2
			for j in 0..h*2
				if i % 2 == 0
					if j % 2 == 0
						@grille.attach(Gtk::Label.new("+", true),i,j,1,1)
						
					else
						@grille.attach(@traitv[indicev],i,j,1,1)
						indicev +=1
					end
				else
					if j % 2 == 0
						@grille.attach(@traith[indiceh],i,j,1,1)
						indiceh += 1
					else
						@grille.attach(Gtk::Label.new(i.to_s() +" "+ j.to_s(), true),i,j,1,1)
					end
				end
			end
		end

	end

	def run
		@window.show_all
	end

	def signaux
		# Fermeture fenêtre
		@window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
	end

end

j=Jeu.new()
j.run
Gtk.main
