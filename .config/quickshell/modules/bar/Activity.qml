import QtQuick
import QtQuick.Layouts
import "../../services"
import "../../widgets"

// TODO: maximum width.
Item {
  id: root

  required property var screen
  property var monitor: HyprlandExtended.monitorForScreen(screen)
  property var activeWorkspace: HyprlandExtended.activeWorkspaceForMonitor(monitor)

  Layout.fillHeight: true
  implicitWidth: text.implicitWidth

  TextNormal {
    id: text
    text: root.activeWorkspace?.lastwindowtitle ?? ""
    anchors.centerIn: parent
  }
}
