# Glint Linux System Controls
alias glint-update="rpm-ostree upgrade"
alias glint-rollback="rpm-ostree rollback"
alias glint-clean="flatpak uninstall --unused -y && sudo rpm-ostree cleanup -m"
alias cls="clear"
fastfetch --logo /usr/share/pixmaps/glint-logo.txt --logo-padding-left 2 --logo-padding-right 4
