import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "io.github.derluke.dual-monitor-workspaces"

  readonly property int dotCount: Math.max(1, Number(root.setting("count", 5)))
  readonly property string screenName: root.QsWindow.window && root.QsWindow.window.screen
    ? root.QsWindow.window.screen.name : ""

  function workspacesForScreen() {
    var workspaces = []
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var workspace = values[i]
      if (workspace.id > 0 && workspace.monitor !== null
          && workspace.monitor.name === root.screenName) {
        workspaces.push(workspace)
      }
    }

    workspaces.sort(function(left, right) { return left.id - right.id })
    return workspaces.slice(0, root.dotCount)
  }

  function focusWorkspace(workspace) {
    if (workspace !== null) workspace.activate()
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.workspacesForScreen().length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspacesForScreen()

      WidgetButton {
        required property var modelData

        readonly property var workspace: modelData
        readonly property bool occupied: workspace.toplevels.values.length > 0
        readonly property bool active: workspace.active

        bar: root.bar
        text: String(workspace.id)
        opacity: active ? 1 : (occupied ? 0.7 : 0.3)
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : Style.space(24)
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(workspace) }
      }
    }
  }
}
