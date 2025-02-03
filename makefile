.PHONY: neovim alacritty tmux 

neovim: ## Init dark power
	@echo "Dark Power..."
	ln -vsf $(CURDIR)/darkpowered/ ${HOME}/.config/
	ln -vsf $(CURDIR)/.dpp/ ${HOME}/
	@echo "Done."
