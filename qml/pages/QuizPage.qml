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
import "./functions.js" as MyFunc

Page {
    id: page
    property int a:1
    property int b:2
    property int c:-1
    property bool quiz_started : false

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Change player")
                onClicked: pageStack.push(Qt.resolvedUrl("ChangePlayer.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Math page")
            }
            Label {
                x: Theme.horizontalPageMargin
                text: a + " x " + b + " = ?"
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
                                quiz_started = true
                                if (answers.get(index).answer === a * b){
                                    time_slider.value = 0;
                                    answers.set(index,{"box_color":"green"})
                                    MyFunc.not_enable();
                                    questions_count = questions_count - 1;
                                    if (questions_count < 1) {
                                        MyFunc.fill_answers(a, b, c, level)
                                        questions_count = Math.round(4 + Math.log(level+1) * 5);
                                        //console.log("Fun page", questions_count)
                                        pageStack.push(Qt.resolvedUrl("FunPage.qml"))
                                    }
                                    else if (MyFunc.level_check(level, level_points) > level) {
                                        MyFunc.fill_answers(a, b, c, level)
                                        level = MyFunc.level_check(level, level_points);
                                        Mysets.saveLevelPoints();
                                        pageStack.push(Qt.resolvedUrl("LevelChange.qml"))
                                    }
                                    else if (time_slider.value < time_slider.maximumValue) {
                                        coins = coins + 1;
                                        //Mysets.saveCoins();
                                        level_points = level_points + 1;
                                        Mysets.saveLevelPoints();
                                        break_timer.start()
                                    }
                                    else {
                                        break_timer.start()
                                    }
                                }
                                else {
                                    answers.set(index,{"box_color":"red"})
                                    mistakesModel.set(mistakesModel.count,{"first": a, "second":b})
                                    if (mistakesModel.count > 5 || questions_count < 1) {
                                        questions_count = 5;
                                        pageStack.push(Qt.resolvedUrl("LearningPage.qml"))
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
                    running: true
                    //running: quiz_started && mistakesModel.count < 6 && Qt.application.active
                    repeat: true
                    interval: 250
                    onTriggered: {
                        if(developer) {console.log("test5")}
                        time_slider.value = time_slider.value + interval/1000
                    }
                }
            }
            Row{
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    width: page.width/10
                    height: width
                    color: "light grey"
                    border.color: "red"
                    border.width: (6 - mistakesModel.count)*width/4.0
                    radius: width*0.5
                }
                Rectangle {
                    width: page.width/10
                    height: width
                    color: "light grey"
                    border.color: "red"
                    border.width: (4 - mistakesModel.count)*width/4.0
                    radius: width*0.5
                }
                Rectangle {
                    width: page.width/10
                    height: width
                    color: "light grey"
                    border.color: "red"
                    border.width: (2 - mistakesModel.count)*width/4.0
                    radius: width*0.5
                }
                Label {
                    x: Theme.horizontalPageMargin
                    text: qsTr("Level") + " " + level
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeMedium
                }

                Label {
                    x: Theme.horizontalPageMargin
                    text: qsTr("Coins") + " " + coins
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeMedium
                }
            }

            Text {
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
                wrapMode: Text.WordWrap
                width: parent.width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
                text: {
                    qsTr("Player") + ": " + player_name
                }
            }

            ProgressBar {
                width: parent.width
                //: Progress bar shows when you reach the Fun page next time
                label:qsTr("Next fun")
                minimumValue: 0
                maximumValue: Math.round(4 + Math.log(level+1) * 5)
                value: maximumValue - questions_count
            }

            Timer {
                id: break_timer
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(developer) {console.log("test6")}
                    //a = Math.floor(Math.random() * (Math.max(11, level)));
                    //b = MyFunc.multiplier_lottery(level)
                    MyFunc.fill_answers(a, b, c, level)
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
                    answer: 1
                    click: true
                    box_visible:false
                }
                ListElement {
                    box_color: "blue"
                    answer: 1
                    click: true
                    box_visible:false
                }
                ListElement {
                    box_color: "blue"
                    answer: 1
                    click: true
                    box_visible:false
                }
                ListElement {
                    box_color: "blue"
                    answer: 1
                    click: true
                    box_visible:false
                }
                ListElement {
                    box_color: "blue"
                    answer: 1
                    click: true
                    box_visible:false
                }
            }
        }
    }

    Component.onCompleted: {mistakesModel.clear()}
}
