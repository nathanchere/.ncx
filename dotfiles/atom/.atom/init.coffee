# Sync installed packages
# This is not ideal but until I find something better it will do
# User packages are stored in packages.cson
# and missing packages are restored on start-up

workspaceView = atom.views.getView(atom.workspace)
atom.commands.dispatch(workspaceView, "package-sync:sync")
