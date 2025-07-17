import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

Item {
  implicitHeight: layout.implicitHeight
  Layout.fillWidth: true

  Rectangle {
    color: Appearance.color.crust
    radius: 8
    anchors.fill: parent
  }

  ColumnLayout {
    id: layout

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    spacing: 0

    Item {
      Layout.fillWidth: true
      implicitHeight: row.implicitHeight + 24

      Rectangle {
        color: Appearance.color.mantle
        anchors.fill: parent
        topLeftRadius: 8
        topRightRadius: 8
      }

      RowLayout {
        id: row

        spacing: 8
        anchors.centerIn: parent

        MaterialIcon {
          text: "notifications"
          color: Appearance.color.text
        }

        TextNormal {
          text: "Notifications"
        }
      }
    }

    ColumnLayout {
      Layout.margins: 12

      TextNormal {
        text: "All caught up."
      }
    }
  }
}
