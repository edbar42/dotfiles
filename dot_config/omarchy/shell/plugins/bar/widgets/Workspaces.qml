import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspaces"

  // Each bar instance lives on one output, so it should only ever show
  // that output's own workspace block — matching waybar's per-monitor
  // hyprland/workspaces behavior instead of listing every workspace on
  // every monitor's bar.
  readonly property var screen: root.QsWindow && root.QsWindow.window ? root.QsWindow.window.screen : null
  readonly property string screenName: screen ? screen.name : ""
  readonly property var monitor: {
    var values = Hyprland.monitors.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].name === root.screenName) return values[i]
    }
    return null
  }
  // Workspaces are assigned to monitors in blocks of 10 (1-10, 11-20, ...)
  // ordered by monitor id, per this system's hl.workspace_rule setup.
  readonly property int monitorBase: monitor ? monitor.id * 10 : 0

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  function workspaceIds() {
    var base = root.monitorBase
    var ids = [base + 1, base + 2, base + 3, base + 4, base + 5]
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var workspace = values[i]
      var id = workspace.id
      var belongsToMonitor = workspace.monitor !== null && workspace.monitor !== undefined && workspace.monitor.name === root.screenName
      if (belongsToMonitor && id > base && id <= base + 10 && ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.workspaceIds().length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        // Highlight this monitor's own active workspace, not just whichever
        // monitor currently has keyboard focus, so every bar marks its own
        // spot the way waybar's per-output workspace module does.
        readonly property bool focused: root.monitor !== null && root.monitor.activeWorkspace !== null
          && root.monitor.activeWorkspace.id === modelData

        bar: root.bar
        text: focused ? "\uDB85\uDCFB" : (modelData === 10 ? "0" : String(modelData))
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : Style.space(20)
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }
      }
    }
  }
}
