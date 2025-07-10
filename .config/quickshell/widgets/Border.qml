import QtQuick

Rectangle {
  property int topWidth: 0
  property int leftWidth: 0
  property int rightWidth: 0
  property int bottomWidth: 0

  z: -1

  anchors {
    top: parent.top
    left: parent.left
    right: parent.right
    bottom: parent.bottom

    topMargin: -topWidth
    leftMargin: -leftWidth
    rightMargin: -rightWidth
    bottomMargin: -bottomWidth
  }
}
