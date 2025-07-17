pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config

ModuleWindow {
  id: window

  anchors.top: true
  margins.top: 16

  implicitWidth: 400

  signal cancel
  signal confirm

  property string content
  property string confirmButtonContent

  ColumnLayout {
    spacing: 12

    TextNormal {
      id: text
      text: window.content
      wrapMode: Text.WordWrap
      padding: 8
      Layout.maximumWidth: window.implicitWidth - 40
    }

    Rectangle {
      color: Appearance.color.crust
      implicitHeight: 1
      Layout.fillWidth: true
      Layout.leftMargin: -12
      Layout.rightMargin: -12
    }

    RowLayout {
      Layout.alignment: Qt.AlignRight

      spacing: 12

      Button {
        id: cancelButton

        implicitHeight: cancelText.implicitHeight + 16
        implicitWidth: cancelText.implicitWidth + 32

        background: Rectangle {
          color: cancelButton.hovered ? Appearance.color.crust : Appearance.color.mantle
          anchors.fill: parent
          radius: 8
        }

        TextNormal {
          id: cancelText
          text: "Cancel"
          color: cancelButton.hovered ? Appearance.color.accent : Appearance.color.text
          anchors.centerIn: parent
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: event => event.accepted = false
        }
      }

      Connections {
        target: cancelButton

        function onPressed() {
          window.cancel();
        }
      }

      Button {
        id: confirmButton

        implicitHeight: confirmText.implicitHeight + 16
        implicitWidth: confirmText.implicitWidth + 32

        background: Rectangle {
          color: confirmButton.hovered ? Appearance.color.crust : Appearance.color.mantle
          anchors.fill: parent
          radius: 8
        }

        TextNormal {
          id: confirmText
          text: window.confirmButtonContent
          color: confirmButton.hovered ? Appearance.color.accent : Appearance.color.text
          anchors.centerIn: parent
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: event => event.accepted = false
        }
      }

      Connections {
        target: confirmButton

        function onPressed() {
          window.confirm();
        }
      }
    }
  }
}
