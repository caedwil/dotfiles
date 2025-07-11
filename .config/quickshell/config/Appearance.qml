pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  // TODO: convert to components.

  property var color: QtObject {
    property color base: "#24273a"
    property color mantle: "#1e2030"
    property color crust: "#181926"

    property color surface0: "#363a4f"

    property color text: "#cad3f5"

    property color rosewater: "#f4dbd6"
    property color flamingo: "#f0c6c6"
    property color pink: "#f5bde6"
    property color mauve: "#c6a0f6"
    property color red: "#ed8796"
    property color maroon: "#ee99a0"
    property color peach: "#f5a97f"
    property color yellow: "#eed49f"
    property color green: "#a6da95"
    property color teal: "#8bd5ca"
    property color sky: "#91d7e3"
    property color sapphire: "#7dc4e4"
    property color blue: "#8aadf4"
    property color lavender: "#b7bdf8"
  }

  property var font: QtObject {
    property var family: QtObject {
      property string normal: "Fira Code"
      property string symbols: "Material Symbols Rounded"
    }

    property var size: QtObject {
      property int small: 10
      property int normal: 13
      property int large: 14
      property int xlarge: 18
    }
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
