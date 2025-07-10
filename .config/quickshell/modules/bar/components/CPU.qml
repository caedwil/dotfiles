import QtQuick
import QtQuick.Layouts
import "../../../config"
import "../../../services"
import "../../../widgets"

Item {
  Layout.fillHeight: true
  implicitWidth: text.implicitWidth + (Appearance.bar.padding * 2)

  TextRegular {
    id: text
    text: {
      const cpu = (Hardware.cpuUsage * 100).toPrecision(2);
      return `CPU: ${cpu}%`;
    }
    anchors.centerIn: parent
  }
}
