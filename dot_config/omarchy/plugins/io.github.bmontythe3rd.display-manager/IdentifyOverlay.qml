import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Commons

Item {
  id: root
  property bool opened: false
  property var displays: []

  function open(payloadJson) {
    try {
      var payload = JSON.parse(String(payloadJson || "{}"))
      displays = Array.isArray(payload.displays) ? payload.displays : []
    } catch (e) { displays = [] }
    opened = true
    closeTimer.restart()
  }
  function close() { opened = false; closeTimer.stop() }

  Timer { id: closeTimer; interval: 2500; repeat: false; onTriggered: root.close() }

  Variants {
    model: Quickshell.screens
    PanelWindow {
      required property var modelData
      screen: modelData
      visible: root.opened
      color: "transparent"
      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      anchors { top: true; bottom: true; left: true; right: true }

      Rectangle {
        anchors.centerIn: parent
        width: Style.space(180)
        height: Style.space(130)
        radius: Style.cornerRadius * 2
        color: Color.popups.background
        border.color: Color.accent
        border.width: Style.normalBorderWidth

        property int displayIndex: {
          for (var i = 0; i < root.displays.length; i++) if (root.displays[i].name === modelData.name) return i
          return -1
        }
        Column {
          anchors.centerIn: parent
          spacing: Style.space(6)
          Text { anchors.horizontalCenter: parent.horizontalCenter; text: parent.parent.displayIndex >= 0 ? String(parent.parent.displayIndex + 1) : "?"; color: Color.foreground; font.family: Style.font.family; font.pixelSize: Style.space(58); font.bold: true }
          Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.name; color: Qt.darker(Color.foreground, 1.3); font.family: Style.font.family; font.pixelSize: Style.font.body }
        }
      }
    }
  }
}
