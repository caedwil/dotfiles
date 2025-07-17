pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import qs.services
import qs.widgets

Scope {
  id: scope

  property WindowManager.Window window: WindowManager.dashboard

  // TODO: Should clicking elsewhere close the window... somehow?
  GlobalShortcut {
    name: "dashboard-toggle"
    onPressed: {
      scope.window.toggle();
    }
  }

  LazyLoader {
    id: loader
    active: scope.window.visible

    ModuleWindow {
      managedWindow: scope.window

      anchors.top: true
      margins.top: -(HyprlandExtended.gapsOut[0] + 1)

      anchors.right: true
      margins.right: 0

      topLeftRadius: 0
      topRightRadius: 0

      Dashboard {}
    }
  }
}
