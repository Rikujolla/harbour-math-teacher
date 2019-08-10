import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All
    property int re_sult


    SilicaListView {
        id: listView
        model: mistakesModel
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Learning Page")
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
                //console.log("Clicked " + index)
                if (mistakesModel.count >1) {
                    re_sult = mistakesModel.get(index).first * mistakesModel.get(index).second
                    console.log("first ", re_sult)
                    mistakesModel.remove(index)
                    coins++;
                    pageStack.push(Qt.resolvedUrl("FlowersPage.qml"), {flower_result: re_sult})
                }
                else {
                    mistakesModel.remove(index)
                    pageStack.push(Qt.resolvedUrl("FunPage.qml"))
                }
            }
        }
        VerticalScrollDecorator {}

    }
}
