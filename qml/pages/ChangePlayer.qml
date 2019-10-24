/*Copyright (c) 2019, Riku Lahtinen
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "./settings.js" as Mysets

Page {
    id: page
    property bool delete_mode: false
    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        PullDownMenu{
            MenuItem {
                text: qsTr("Delete player")
                onClicked: {
                    delete_mode = true;
                }
            }

            MenuItem {
                text: qsTr("Add player")
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("AddPlayer.qml"),
                                                {"name": ''})
                    dialog.accepted.connect(function() {
                        player_name = dialog.name
                        Mysets.saveSettings()
                        Mysets.loadPlayers();
                    })
                }
            }
        }

        model: players
        anchors.fill: parent
        header: PageHeader {
            title: delete_mode ? qsTr("Player deletion") : qsTr("Player selection")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.horizontalPageMargin
                text: player
                anchors.verticalCenter: parent.verticalCenter
                color: delete_mode ? "red": (delegate.highlighted ? Theme.highlightColor : Theme.primaryColor)
            }
            onClicked: {
                player_name = players.get(index).player
                if (!delete_mode) {
                    Mysets.updateActivePlayer(index)
                    Mysets.loadSettings()
                    questions_count = Math.round(4 + Math.log(level+1) * 5);
                    pageStack.pop()
                }
                else {
                    remorseDel.execute(qsTr("Deleting"), console.log("remorse") , 3000 )
                }
            }
        }

        RemorsePopup { id: remorseDel
            onTriggered: {
                Mysets.deletePlayer(player_name)
                delete_mode = false
                Mysets.loadPlayers();
            }
        }

        VerticalScrollDecorator {}
    }

    ListModel {
        id: players
        ListElement {
            player: ""
            status: ""
        }
    }

    Component.onCompleted: {
        Mysets.loadPlayers();
    }

}
