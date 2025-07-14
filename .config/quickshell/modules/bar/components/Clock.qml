import QtQuick
import QtQuick.Layouts
import "../../../config"
import "../../../services"
import "../../../widgets"

Item {
  Layout.fillHeight: true
  implicitWidth: text.implicitWidth + (Appearance.bar.padding * 2)

  TextNormal {
    id: text
    text: DateTime.time
    anchors.centerIn: parent
  }
}
