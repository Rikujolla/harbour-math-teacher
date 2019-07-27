import QtQuick 2.0
import Sailfish.Silica 1.0
import "./functions.js" as MyFunc

Page {
    id: page

    property int coins: 0 // To earn coins to buy food, services and equipment
    property int level_points : 0 // Normally increase when you get a point when answering right
    property int mistake_points: 30 // To be reduced when mistakes or time overflows
    property int level: 0 //
    property int questions_count: 5 //

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Start")
                onClicked: {
                    //column.a = MyFunc.multiplier_lottery(level)
                    column.a = Math.floor(Math.random() * 11);
                    column.b = MyFunc.multiplier_lottery(level)
                    MyFunc.fill_answers(column.a, column.b, column.c, level)
                    column.quiz_started = true
                }
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.



        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            property int a:1
            property int b:2
            property int c:-1
            property bool quiz_started : false




            PageHeader {
                title: qsTr("Math Page")
            }
            Label {
                x: Theme.horizontalPageMargin
                text: column.a + " x " + column.b + " = ?"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }

            BackgroundItem {
                id: gridBackground
                width:page.width
                height: page.width/2

                GridView {
                    id:grid
                    model:answers
                    cellWidth: parent.width / 3
                    cellHeight: parent.height / 3
                    anchors.fill: parent
                    delegate: Rectangle {
                        width: grid.cellWidth
                        height: grid.cellHeight
                        color: box_color
                        visible: box_visible
                        radius: grid.cellHeight/2
                        Text {
                            id: result
                            text: answer
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeSmall
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        MouseArea {
                            id:m_area
                            anchors.fill: parent
                            height: grid.cellHeight
                            width: grid.cellWidth
                            enabled: click
                            onClicked: {
                                column.quiz_started = true
                                if (answers.get(index).answer === column.a * column.b){
                                    answers.set(index,{"box_color":"green"})
                                    //m_area.enabled = false;
                                    MyFunc.not_enable();
                                    break_timer.start()
                                    if (time_slider.value < time_slider.maximumValue) {
                                        //console.log(time_slider.value, time_slider.maximumValue)
                                        coins = coins + 1;
                                        level_points = level_points + 1;
                                    }
                                    time_slider.value = 0;
                                    questions_count = questions_count - 1;
                                    if (questions_count < 1) {
                                        questions_count = Math.max(5, level *5);
                                        mistake_points = 30;
                                        pageStack.push(Qt.resolvedUrl("FunPage.qml"))
                                    }
                                    else if (MyFunc.level_check(level, level_points) > level) {
                                        level = MyFunc.level_check(level, level_points);
                                        pageStack.push(Qt.resolvedUrl("LevelChange.qml"))
                                    }
                                }
                                else {
                                    answers.set(index,{"box_color":"red"})
                                    mistake_points = mistake_points - 5;
                                    if (mistake_points <1 || questions_count < 1) {
                                        //MyFunc.not_enable();
                                        questions_count = 5;
                                        mistake_points = 30;
                                        pageStack.push(Qt.resolvedUrl("MistakesPage.qml"))
                                    }
                                }
                            }
                        }
                    }
                }
            }

            ProgressBar {
                id: time_slider
                width: parent.width
                maximumValue: 10
                value: 0
                Timer {
                    id:timer_slider
                    running: column.quiz_started && mistake_points > 0
                    repeat: true
                    interval: 100
                    onTriggered: time_slider.value = time_slider.value + interval/1000
                }
            }
            Row{
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    width: page.width/10
                    height: width
                    //anchors.horizontalCenter: parent.horizontalCenter
                    color: "light grey"
                    border.color: "red"
                    border.width: (mistake_points)*width*0.05
                    radius: width*0.5
                }
                Rectangle {
                    width: page.width/10
                    height: width
                    //anchors.horizontalCenter: parent.horizontalCenter
                    color: "light grey"
                    border.color: "red"
                    border.width: (mistake_points - 10)*width*0.05
                    radius: width*0.5
                }
                Rectangle {
                    width: page.width/10
                    height: width
                    //anchors.horizontalCenter: parent.horizontalCenter
                    color: "light grey"
                    border.color: "red"
                    border.width: (mistake_points - 20)*width*0.05
                    radius: width*0.5
                }
                Label {
                    x: Theme.horizontalPageMargin
                    text: "Level " + level
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeMedium
                }

                Label {
                    x: Theme.horizontalPageMargin
                    text: "Coins " + coins
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeMedium
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                text: "Game over" + "!"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: mistake_points < 1
            }


            Timer {
                id: timer
                running: false
                repeat: timer.value <1000
                interval: 100
                onTriggered: console.log (timer.value)
            }

            Timer {
                id: break_timer
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    //column.a = MyFunc.multiplier_lottery(level)
                    column.a = Math.floor(Math.random() * 11);
                    column.b = MyFunc.multiplier_lottery(level)
                    MyFunc.fill_answers(column.a, column.b, column.c, level)
                    //m_area.enabled = true;
                }
            }

            ListModel {
                id:answers
                ListElement {
                    box_color: "blue"
                    answer: 0
                    click: true
                    box_visible:true
                }
                ListElement {
                    box_color: "blue"
                    answer: 1
                    click: true
                    box_visible:false
                }
                ListElement {
                    box_color: "blue"
                    answer: 2
                    click: true
                    box_visible:2
                }

            }
        }
    }
}
