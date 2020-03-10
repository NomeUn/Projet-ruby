require "gtk3"
require "optparse"
require "fileutils"
Gtk.init
class Jeu
	def initialize()
		@window = Gtk::Window.new
		@grille = Gtk::Grid.new
		@window.add(@grille)
		signaux()
		k=8
		for i in 0..k*2+1
			for j in 0..k*2+1
				if i % 2 == 0
					if j % 2 == 0
						@grille.attach(Gtk::Frame.new.add(Gtk::DrawingArea.new.override_back_ground_color(Gdk::RGBA::new(0, 1.0, 1.0, 1.0))),i,j,1,1);
						
					else
						@grille.attach(Gtk::EventBox.new(),i,j,1,1);
					end
				else
					if j % 2 == 0
						@grille.attach(Gtk::EventBox.new(),i,j,1,1);
					else
						@grille.attach(Gtk::Label.new(i.to_s() +" "+ j.to_s(), true),i,j,1,1);
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
