import QtQuick
import "../config"

Text {
  id: root

  property int size: Appearance.font.size.xlarge
  property real fill: 0

  renderType: Text.NativeRendering

  font {
    family: Appearance.font.family.symbols
    pixelSize: root.size
    hintingPreference: Font.PreferFullHinting
    variableAxes: {
      "FILL": root.fill,
      "opsz": root.size
    }
  }
}
