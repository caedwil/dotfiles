import Quickshell
import Quickshell.Hyprland
import qs.services
import qs.widgets

Scope {
  id: scope

  // TODO: Should clicking elsewhere close the window... somehow?
  GlobalShortcut {
    name: "dashboard-toggle"
    onPressed: {
      loader.active = !loader.active;
    }
  }

  LazyLoader {
    id: loader
    active: false

    ModuleWindow {
      id: window

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
