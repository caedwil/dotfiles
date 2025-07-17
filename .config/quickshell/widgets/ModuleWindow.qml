import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.config
import qs.services

PanelWindow { // qmllint disable
  id: window

  default property alias component: loader.sourceComponent
  property alias topLeftRadius: background.topLeftRadius
  property alias topRightRadius: background.topRightRadius
  property alias bottomLeftRadius: background.bottomLeftRadius
  property alias bottomRightRadius: background.bottomRightRadius

  property WindowManager.Window managedWindow

  color: "transparent"

  implicitHeight: wrapper.implicitHeight
  implicitWidth: 512

  WlrLayershell.layer: WlrLayer.Overlay
  exclusionMode: ExclusionMode.Normal

  mask: Region {
    item: wrapper
  }

  HyprlandFocusGrab {
    id: grab
    windows: [window, ...WindowManager.bars]

    onCleared: {
      window.managedWindow.hide();
    }
  }

  Component.onCompleted: {
    if (managedWindow) {
      grab.active = true;
    }
  }

  Item {
    id: wrapper

    implicitHeight: loader.implicitHeight + 40
    implicitWidth: window.implicitWidth

    Rectangle {
      id: background
      implicitHeight: wrapper.implicitHeight - 16
      implicitWidth: wrapper.implicitWidth - 16
      anchors.centerIn: parent
      color: Appearance.color.base
      border.color: Appearance.color.crust
      topLeftRadius: 8
      topRightRadius: 8
      bottomLeftRadius: 8
      bottomRightRadius: 8
    }

    MultiEffect {
      source: background
      anchors.fill: background
      shadowEnabled: true
      shadowBlur: 0.4
      shadowColor: Appearance.color.crust
      shadowVerticalOffset: 0
      shadowHorizontalOffset: 0
    }

    Loader {
      id: loader
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.margins: 20
    }
  }
}
