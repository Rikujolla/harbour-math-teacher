import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        model: mistakesModel
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Mistages Page")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.horizontalPageMargin
                text: first  + " x " + second + " = " + first*second
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                console.log("Clicked " + index)
                if (mistakesModel.count >1) {
                    mistakesModel.remove(index)
                    pageStack.push(Qt.resolvedUrl("FlowersPage.qml"))
                }
                else {
                    mistakesModel.remove(index)
                    pageStack.push(Qt.resolvedUrl("FunPage.qml"))
                }
            }
        }
        VerticalScrollDecorator {}
        ListModel {
            id: mistakesModel
            ListElement {
                first: 1
                second: 2
            }
            ListElement {
                first: 2
                second: 3
            }
            ListElement {
                first: 3
                second: 4
            }
            ListElement {
                first: 4
                second: 5
            }
            ListElement {
                first: 5
                second: 6
            }
        }

    }
}
