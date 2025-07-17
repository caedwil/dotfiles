pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import qs.services
import qs.widgets

Scope {
  id: scope

  property bool anchorToBar: false
  property HyprlandMonitor monitor: Hyprland.focusedMonitor
  property WindowManager.Window window: WindowManager.spotify

  // TODO: This could be a floating window instead. Would need corresponding
  // windowrules in Hyprland config - no decorations, floating. Alternatively,
  // could allow for the "floating" PanelWindow to be moved by dragging it?
  GlobalShortcut {
    name: "player-spotify-toggle"
    onPressed: {
      scope.window.toggle();
      scope.anchorToBar = false;
    }
  }

  GlobalShortcut {
    name: "player-spotify-toggle-anchor-to-bar"
    onPressed: {
      scope.window.toggle();
      scope.anchorToBar = true;
    }
  }

  LazyLoader {
    id: loader
    active: scope.window.visible

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
