import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../services"

Item {
  Layout.fillHeight: true
  implicitWidth: text.implicitWidth + (Appearance.bar.padding * 2)

  TextRegular {
    id: text
    text: DateTime.time
    anchors.centerIn: parent
  }
}
