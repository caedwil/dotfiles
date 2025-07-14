import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris

// TODO: Make Appearance.player.spotify.
Scope {
  id: scope

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
