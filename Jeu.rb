require "gtk3"
require "optparse"
require "fileutils"
Gtk.init
class Jeu
	def initialize()
		@window = Gtk::Window.new
		@grille = Gtk::Grid.new
		@grille.set_border_width(10)
		h = 5
		l = 4
		@window.add(@grille)
		@traith = Array.new(l*(h+1))
		@traitv = Array.new(h*(l+1))
		signaux()

		@traith.each_index { |index|
			box = Gtk::EventBox.new()
			box.signal_connect('button_press_event'){
				puts"clicked h "+index.to_s
				
			}
			@traith[index] = box
		} 

		@traitv.each_index { |index|
			box = Gtk::EventBox.new()
			box.signal_connect('button_press_event'){
				puts"clicked v "+index.to_s
				if(index < h)
					puts"case droite, 0 ,"+index.to_s
				else
					puts"case gauche,"+((index-h)/h.to_i).to_s + (index%h).to_s
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
						@grille.attach(Gtk::Label.new("case "+i.to_s() +" "+ j.to_s(), true),i,j,1,1)
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
