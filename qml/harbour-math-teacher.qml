import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: Component { QuizPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.Portrait
    //allowedOrientations: defaultAllowedOrientations

    property int coins: 0 // Global property for money
    property int questions_count: 5
    property string asset_path : "./assets/asset1/" //Asset number

    ListModel {
        id: mistakesModel
        ListElement {
            first: 1
            second: 2
        }
    }

}
