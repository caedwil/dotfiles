pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
  id: root

  property var clients: []
  property var workspaces: []
  property var monitors: []

  function updateAll() {
    getClients.running = true;
    getWorkspaces.running = true;
    getMonitors.running = true;
  }

  Connections {
    target: Hyprland

    function onRawEvent() {
      root.updateAll();
    }
  }

  Component.onCompleted: root.updateAll()

  Process {
    id: getClients
    command: ["hyprctl", "clients", "-j"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.clients = JSON.parse(data)
    }
  }

  Process {
    id: getWorkspaces
    command: ["hyprctl", "workspaces", "-j"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.workspaces = JSON.parse(data)
    }
  }

  Process {
    id: getMonitors
    command: ["hyprctl", "monitors", "-j"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.monitors = JSON.parse(data)
    }
  }

  function clientForAddress(address) {
    return root.clients.find(client => client.address === address);
  }

  function clientsForWorkspaceByClass(workspace) {
    const clients = {};

    for (const client of root.clients) {
      if (client.workspace.id !== workspace.id) {
        continue;
      }

      if (!clients[client.class]) {
        clients[client.class] = {
          class: client.class,
          clients: []
        };
      }

      clients[client.class].clients.push(client);
    }

    return Object.values(clients);
  }

  function workspacesForMonitor(monitor) {
    return root.workspaces.filter(workspace => {
      return workspace.monitorID === monitor.id && !workspace.name.startsWith("special:");
    });
  }

  function activeWorkspaceForMonitor(monitor) {
    return root.workspaces.find(workspace => workspace.id === monitor.activeWorkspace.id);
  }

  function monitorForScreen(screen) {
    return root.monitors.find(monitor => monitor.name === screen.name);
  }
}
