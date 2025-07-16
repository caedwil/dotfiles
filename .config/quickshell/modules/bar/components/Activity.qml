import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Item {
  id: root

  required property var screen
  property var monitor: HyprlandExtended.monitorForScreen(screen)
  property var activeWorkspace: HyprlandExtended.activeWorkspaceForMonitor(monitor)

  Layout.fillHeight: true
  Layout.maximumWidth: 400
  implicitWidth: layout.implicitWidth

  RowLayout {
    id: layout
    anchors.fill: parent

    TextNormal {
      text: root.activeWorkspace?.lastwindowtitle ?? ""
      elide: Text.ElideRight
      Layout.fillWidth: true
    }
  }
}
