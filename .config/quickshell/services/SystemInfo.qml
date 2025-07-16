pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property double cpuUsage: 0
  property double memoryUsage: 0
  property double uptimeInSeconds: 0

  property string username
  property string hostname

  FileView {
    id: stat
    path: "/proc/stat"
  }

  FileView {
    id: meminfo
    path: "/proc/meminfo"
  }

  FileView {
    id: uptime
    path: "/proc/uptime"
  }

  Timer {
    interval: 1000
    running: true
    repeat: true

    onTriggered: {
      root.calculateCpuUsage();
      root.calculateMemoryUsage();
      root.calculateUptimeInSeconds();
    }
  }

  Process {
    command: ["whoami"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.username = data.toString().trim()
    }
  }

  Process {
    command: ["hostnamectl", "hostname"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.hostname = data.toString().trim()
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

    root.cpuUsage = 1 - (idle / total);
  }

  function calculateMemoryUsage() {
    meminfo.reload();

    const text = meminfo.text();
    const total = Number(text.match(/MemTotal:\s+(\d+)/)[1] ?? 1);
    const available = Number(text.match(/MemAvailable:\s+(\d+)/)[1] ?? 0);

    root.memoryUsage = 1 - (available / total);
  }

  function calculateUptimeInSeconds() {
    uptime.reload();

    const [value] = uptime.text().split(" ");

    if (!value) {
      return;
    }

    uptimeInSeconds = Number(value);
  }
}
