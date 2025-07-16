import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

Item {
  implicitHeight: layout.implicitHeight
  Layout.fillWidth: true

  Rectangle {
    color: Appearance.color.crust
    // border.color: Appearance.color.surface0
    radius: 8
    anchors.fill: parent
  }

  ColumnLayout {
    id: layout

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    spacing: 0

    // TODO: move to a component file.
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

    // Rectangle {
    //   Layout.fillWidth: true
    //   implicitHeight: 1
    //   color: Appearance.color.surface0
    // }

    ColumnLayout {
      Layout.margins: 12

      TextNormal {
        text: "I haven't setup notifications yet..."
      }
    }
  }
}
