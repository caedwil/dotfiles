pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../widgets"

Scope {
  id: scope

  property bool anchorToBar: false
  property HyprlandMonitor monitor: Hyprland.focusedMonitor

  // TODO: This could be a floating window instead. Would need corresponding
  // windowrules in Hyprland config - no decorations, floating. Alternatively,
  // could allow for the "floating" PanelWindow to be moved by dragging it?
  GlobalShortcut {
    name: "player-spotify-toggle"
    onPressed: {
      loader.active = !loader.active;
      scope.anchorToBar = false;
    }
  }

  GlobalShortcut {
    name: "player-spotify-toggle-anchor-to-bar"
    onPressed: {
      loader.active = !loader.active;
      scope.anchorToBar = true;
    }
  }

  LazyLoader {
    id: loader
    active: false

    ModuleWindow {
      id: window

      anchors.top: true
      margins.top: scope.anchorToBar ? -(HyprlandExtended.gapsOut[0] + 1) : 16

      anchors.left: scope.anchorToBar
      margins.left: scope.anchorToBar ? Position.playerX[scope.monitor.id] : 0

      topLeftRadius: scope.anchorToBar ? 0 : 8
      topRightRadius: scope.anchorToBar ? 0 : 8

      Player {
        name: "Spotify"
      }
    }
  }
}
