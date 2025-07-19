pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
  id: root

  property var players

  Instantiator {
    model: Mpris.players
  }

  function getPlayerByName(name) {
    return Mpris.players.values.find(player => player.identity == name);
  }
}
