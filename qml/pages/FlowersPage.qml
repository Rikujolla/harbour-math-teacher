import QtQuick 2.0
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
