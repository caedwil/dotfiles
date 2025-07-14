pragma Singleton

import Quickshell

Singleton {
  property var playerX: []

  function setPlayerX(monitor, x) {
    playerX[monitor.id] = x;
    console.log(playerX[monitor.id]);
  }

  function getPlayerX(monitor) {
    return playerX[monitor.id];
  }
}
