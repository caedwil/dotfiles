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

  Connections {
    target: Hyprland

    function onRawEvent() {
      getClients.running = true;
      getWorkspaces.running = true;
      getMonitors.running = true;
    }
  }

  Process {
    id: getClients
    command: ["bash", "-c", "hyprctl clients -j | jq -c"]
    running: true
    stdout: SplitParser {
      onRead: data => root.clients = JSON.parse(data)
    }
  }

  Process {
    id: getWorkspaces
    command: ["bash", "-c", "hyprctl workspaces -j | jq -c"]
    running: true
    stdout: SplitParser {
      onRead: data => root.workspaces = JSON.parse(data)
    }
  }

  Process {
    id: getMonitors
    command: ["bash", "-c", "hyprctl monitors -j | jq -c"]
    running: true
    stdout: SplitParser {
      onRead: data => root.monitors = JSON.parse(data)
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

  function monitorForScreen(screen) {
    return root.monitors.find(monitor => monitor.name === screen.name);
  }
}
