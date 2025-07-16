import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.widgets

Item {
  Layout.fillHeight: true
  implicitWidth: text.implicitWidth + (Appearance.bar.padding * 2)

  TextNormal {
    id: text
    text: DateTime.time
    anchors.centerIn: parent
  }
}
