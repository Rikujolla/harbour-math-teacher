import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: levelPage
    anchors.fill: parent

    //property alias pro_piece: dialogWindow.proPiece
    //property alias pro_color: dialogWindow.proColor
    //property alias pro_index: dialogWindow.proIndex
    //property alias turn_White: dialogWindow.turnWhite

    Rectangle {
        anchors.fill: parent
        id: overlay
        color: "#000000" //
        opacity: 0.9
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
            onClicked: {
                levelPage.destroy()
            }
        }
    }

    // This rectangle is the actual popup
    TextArea {
        width: levelPage.width
        height: levelPage.height/4
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeExtraLarge
        wrapMode: Text.WordWrap
        text: "You are now on the next level! Congratulations!"
    }

    Rectangle {
        id: dialogWindow
        //property string proPiece
        //property string proColor
        //property int proIndex
        //property bool turnWhite
        width: 5*Screen.width/8
        height: Screen.width/8
        color: "#dddea1" // Grid colors dddea1 and 997400 Kapu's colors fada5e and 664228
        //    radius: 10
        anchors.centerIn: parent
        GridView {
            id: promogrid
            cellWidth: Screen.width/8
            cellHeight: Screen.width/8
            anchors.fill: parent
            //layoutDirection: isMyStart && turn_White || !isMyStart && !turn_White ? Qt.LeftToRight : Qt.RightToLeft
            model:5
            delegate: Rectangle {
                id: pieceImage
                height: promogrid.cellHeight
                width: height
                radius: height/2
                color: "red"

                // Delete popup
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        levelPage.destroy()
                    }
                } //end MouseArea
            } //end Image
        } // end GridView
    } // end Rectangle

    ListModel {
        id: promotionModel
        ListElement {
            white: "Q.png"
            black: "q.png"
            stfish: "q"
        }
        ListElement {
            white: "R.png"
            black: "r.png"
            stfish: "r"
        }
        ListElement {
            white: "N.png"
            black: "n.png"
            stfish: "n"
        }
        ListElement {
            white: "B.png"
            black: "b.png"
            stfish: "b"
        }
        ListElement {
            white: "P.png"
            black: "p.png"
            stfish: "p"
        }
    }


}