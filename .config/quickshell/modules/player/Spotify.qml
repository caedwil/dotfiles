pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland

Scope {
  id: scope

  property bool useRelativePosition: false
  property HyprlandMonitor monitor

  GlobalShortcut {
    name: "player-spotify-toggle"
    onPressed: {
      scope.useRelativePosition = false;
      scope.monitor = Hyprland.focusedMonitor;
      loader.active = !loader.active;
    }
  }

  GlobalShortcut {
    name: "player-spotify-toggle-relative-to-status-bar"
    onPressed: {
      scope.useRelativePosition = true;
      scope.monitor = Hyprland.focusedMonitor;
      loader.active = !loader.active;
    }
  }

  LazyLoader {
    id: loader
    active: false
    Player {
      name: "Spotify"
      visible: loader.active
      useRelativePosition: scope.useRelativePosition
      monitor: scope.monitor
    }
  }
}
