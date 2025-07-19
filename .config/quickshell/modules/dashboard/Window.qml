pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import qs.services
import qs.widgets

Scope {
  id: scope

  property WindowManager.Window window: WindowManager.dashboard
  property bool anchorToBar: false

  GlobalShortcut {
    name: "dashboard-toggle"
    onPressed: {
      scope.window.toggle();
      scope.anchorToBar = false;
    }
  }

  GlobalShortcut {
    name: "dashboard-toggle-anchor-to-bar"
    onPressed: {
      scope.window.toggle();
      scope.anchorToBar = true;
    }
  }

  LazyLoader {
    active: scope.window.visible

    ModuleWindow {
      managedWindow: scope.window

      anchors.top: true
      margins.top: scope.anchorToBar ? -(HyprlandExtended.gapsOut[0] + 1) : 0

      anchors.right: true
      margins.right: 0

      topLeftRadius: scope.anchorToBar ? 0 : 8
      topRightRadius: scope.anchorToBar ? 0 : 8

      Dashboard {}
    }
  }
}
