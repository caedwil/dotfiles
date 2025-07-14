import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
  id: scope

  // TODO: if triggered by clicking on the component in the status bar, position
  // relative to the component. However, if triggered any other way (like by a
  // key bind), position centered.
  GlobalShortcut {
    name: "player-spotify-toggle"
    onPressed: loader.active = !loader.active
  }

  LazyLoader {
    id: loader
    active: false
    Player {
      name: "Spotify"
    }
  }
}
