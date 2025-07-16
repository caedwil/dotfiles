import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config
import qs.widgets

Item {
  id: root

  Layout.fillHeight: true
  implicitWidth: icon.implicitWidth

  MaterialIcon {
    id: icon
    text: "space_dashboard"
    color: Appearance.color.text
    size: 24
    fill: 1
    anchors.centerIn: parent

    Behavior on color {
      ColorAnimation {
        duration: 250
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onPressed: Hyprland.dispatch('global quickshell:dashboard-toggle')
    onEntered: {
      icon.color = '#8bd5ca';
    }
    onExited: {
      icon.color = Appearance.color.text;
    }
  }
}
