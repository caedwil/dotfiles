import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Item {
  implicitHeight: layout.implicitHeight
  implicitWidth: layout.implicitWidth

  RowLayout {
    id: layout

    TextNormal {
      text: DateTime.date
    }

    TextNormal {
      text: "//"
    }

    TextNormal {
      text: DateTime.time
    }
  }
}
