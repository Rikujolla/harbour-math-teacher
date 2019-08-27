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

Item {
    id: flowerBox
    anchors.fill: parent

    property alias flower_result: rec_repeat.result
    //property alias pro_color: dialogWindow.proColor

    Rectangle {
        anchors.fill: parent
        id: overlay
        color: "#000000" //
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
            onClicked: {
                flowerBox.destroy()
            }
        }
    }


    Repeater {
        id: rec_repeat
        property int result
        model: flower_result+1
        Rectangle {
            x: Math.floor(Math.random() * Screen.width)
            y: 200 + Math.floor(Math.random() * Screen.height)
            width: 100
            height: 100
            border.width: 1
            color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
            radius:width/2
            Repeater {
                id:rec_leaves
                //property string rec_colori: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
                model: Math.floor(Math.random() *8) +1
                Rectangle {
                    x: 30+70*Math.cos(2*Math.PI*index/rec_leaves.count)
                    y: 30+70*Math.sin(2*Math.PI*index/rec_leaves.count)
                    width: 40
                    height: 40
                    radius: width/2
                    //rotation: index*360.0/rec_leaves.count
                    color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
                }

            }
        }
    }
    // This rectangle is the actual popup

    ListModel {
        id: recmodel
        ListElement {
            recx: 100
            recy: 800
            reccol: "yellow"
        }
        ListElement {
            recx: 200
            recy: 900
            reccol: "blue"
        }
        ListElement {
            recx: 300
            recy: 1000
            reccol: "red"
        }
    }
}
