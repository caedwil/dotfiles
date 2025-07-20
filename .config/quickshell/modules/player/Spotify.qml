pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import qs.services
import qs.widgets

Scope {
  id: scope

  property bool anchorToBar: false
  property HyprlandMonitor monitor: Hyprland.focusedMonitor
  property WindowManager.Window window: WindowManager.spotify
  property MprisPlayer player: Media.getPlayerByName("Spotify")

  // This is to stop the window from moving between monitors as the mouse moves.
  property int leftMarginForWindow: 0

  GlobalShortcut {
    name: "player-spotify-toggle"
    onPressed: {
      if (!scope.window.visible && !scope.player) {
        Hyprland.dispatch("exec [workspace 5] spotify-launcher");
        return;
      }

      scope.window.toggle();
      scope.anchorToBar = false;
      scope.leftMarginForWindow = 0;
    }
  }

  GlobalShortcut {
    name: "player-spotify-toggle-anchor-to-bar"
    onPressed: {
      scope.window.toggle();
      scope.anchorToBar = true;
      scope.leftMarginForWindow = Position.playerX[scope.monitor.id];
    }
  }

  LazyLoader {
    id: loader
    active: scope.window.visible

    ModuleWindow {
      managedWindow: scope.window

      anchors.top: true
      margins.top: scope.anchorToBar ? -(HyprlandExtended.gapsOut[0] + 1) : 16

      anchors.left: scope.anchorToBar
      margins.left: scope.leftMarginForWindow

      topLeftRadius: scope.anchorToBar ? 0 : 8
      topRightRadius: scope.anchorToBar ? 0 : 8

      Player {
        name: "Spotify"
      }
    }
  }
}
