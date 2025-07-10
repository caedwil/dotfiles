pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property double cpuUsage: 0

  FileView {
    id: stat
    path: "/proc/stat"
  }

  Timer {
    interval: 1000
    running: true
    repeat: true

    onTriggered: {
      root.cpuUsage = root.calculateCpuUsage();
    }
  }

  function calculateCpuUsage() {
    stat.reload();

    const match = stat.text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+/);

    if (!match) {
      return;
    }

    const stats = match.slice(1).map(Number);
    const total = stats.reduce((result, value) => result + value, 0);
    const idle = stats[3];

    return 1 - (idle / total);
  }
}
