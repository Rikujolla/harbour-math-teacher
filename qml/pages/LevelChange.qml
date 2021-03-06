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

Dialog {
    id: dialog_page

    Column {
        width: parent.width

        DialogHeader {
            acceptText : qsTr("Fun")
            cancelText: qsTr("Play")
        }

        Text {
            font.pixelSize: Theme.fontSizeExtraLarge
            color: Theme.primaryColor
            wrapMode: Text.WordWrap
            width: parent.width
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            text: {qsTr("You are now on the next level!")
            }
        }
        Text {
            font.pixelSize: Theme.fontSizeExtraLarge
            color: Theme.primaryColor
            wrapMode: Text.WordWrap
            width: parent.width
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            text: {qsTr("Congratulations!")
            }
        }

        Repeater {
            model: 3
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: dialog_page.width/5
                height: width
                source: asset_path + "coin.svg"
            }
        }
    }


    onDone: {
        coins = coins + 3;
        Mysets.saveCoins();
        if (result == DialogResult.Accepted) {
            pageStack.replace(Qt.resolvedUrl("FunPage.qml"))
        }
    }
}
