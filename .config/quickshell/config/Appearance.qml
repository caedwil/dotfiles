pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  // TODO: convert to components.
  // TODO: fix up all the colours - replace all the hard-coded colours.
  // TODO: get rid of the bar property.

  property var color: QtObject {
    property color base: "#24273a"
    property color mantle: "#1e2030"
    property color crust: "#181926"

    property color surface0: "#363a4f"

    property color text: "#cad3f5"
    property color accent: "#8bd5ca"

    property color subtext0: "#b8c0e0"
    property color subtext1: "#a5adcb"
  }

  property var font: QtObject {
    property var family: QtObject {
      property string normal: "Fira Code"
      property string symbols: "Material Symbols Rounded"
    }

    property var size: QtObject {
      property int small: 11
      property int normal: 13
      property int large: 16
      property int xlarge: 18
    }
  }

  property var radius: QtObject {
    property int full: 1000
  }

  property var bar: QtObject {
    property real spacing: 4
    property real padding: 8

    property var background: QtObject {
      property color color: root.color.base
    }

    property var border: QtObject {
      property color color: root.color.crust
    }

    property var group: QtObject {
      property color color: root.color.crust

      property var border: QtObject {
        property real radius: 8
        property color color: root.color.surface0
      }
    }

    property var tray: QtObject {
      property real spacing: 8

      property var icon: QtObject {
        property real size: 16
      }
    }
  }
}
