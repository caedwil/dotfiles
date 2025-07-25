import QtQuick
import qs.config

Text {
  id: root

  property int size: Appearance.font.size.xlarge
  property real fill: 0
  property int weight: 400

  renderType: Text.NativeRendering

  font {
    family: Appearance.font.family.symbols
    pixelSize: root.size
    hintingPreference: Font.PreferFullHinting
    variableAxes: {
      "FILL": root.fill,
      "opsz": root.size,
      "wght": root.weight
    }
  }
}
