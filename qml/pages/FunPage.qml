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

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {

            MenuItem {
                text: qsTr("Change horse")
                onClicked: {
                    if (asset_path == "./assets/asset1/"){
                        asset_path = "./assets/asset2/"
                    }
                    else {
                        asset_path = "./assets/asset1/"
                    }
                }
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Fun page")
            }

            /*Rectangle {
                height: page.width/2
                width : height
                radius: page.width/4
                color: "green"
            }*/
            /*Image {
                source: "./assets/asset1/horse.jpg"
                width: page.width
                height: sourceSize.height*page.width/sourceSize.width
                fillMode: Image.Stretch

            }*/
            Image {
                id: horse
                source: asset_path + "0.svg"
                width: page.width
                height: sourceSize.height*page.width/sourceSize.width
                fillMode: Image.Stretch
                /*Canvas {
                    id: saddle
                    x: 200
                    y: 100
                    width: 100
                    height: 200
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.fillStyle = Qt.rgba(1, 1, 0, 1);
                        ctx.fillRect(0, 0, width, height);
                    }
                }*/
                Repeater {
                    model:horse_harness
                    Image {
                        width:page.width
                        height:sourceSize.height*page.width/sourceSize.width
                        source: asset_path + hh_source
                        //x: hh_x
                        //y: hh_y
                        visible: hh_visible
                    }
                }
            }
            BackgroundItem {
                width: page.width
                height: page.width/4
                GridView {
                    id:grid
                    cellWidth: page.width/4
                    cellHeight: page.width/4
                    anchors.fill: parent
                    model:horse_harness
                    delegate: Rectangle {
                        id:hh_rec
                        width: grid.cellWidth
                        height: grid.cellHeight
                        border.width: 3
                        border.color: "black"
                        Image {
                            source: hh_source_l
                            opacity: coins > index*20 ? 1.0: 0.2
                            anchors.fill: parent
                            MouseArea {
                                anchors.fill: parent
                                height: grid.cellHeight
                                width: grid.cellWidth
                                enabled: coins > index*20 ? true: false
                                onClicked: {
                                    //console.log(index);
                                    if (horse_harness.get(index).hh_visible === false){
                                        horse_harness.set(index,{"hh_visible":true})
                                    }
                                    else {
                                        horse_harness.set(index,{"hh_visible":false})
                                    }
                                }
                            }
                        } // Image
                        Text {
                            text: hh_name
                            anchors.bottom: hh_rec.bottom
                            anchors.horizontalCenter:  hh_rec.horizontalCenter
                        }
                    }
                }

            }

            //loppusulkeet
        }
    }

    ListModel {
        id: horse_harness
        ListElement {
            hh_name: "Forelock"
            hh_source:"2.svg"
            hh_source_l:"./assets/asset1/2_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 700
            hh_y: 450
        }
        ListElement {
            hh_name: "Mane"
            hh_source:"3.svg"
            hh_source_l:"./assets/asset1/3_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Tail"
            hh_source:"4.svg"
            hh_source_l:"./assets/asset1/4_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Bridle"
            hh_source:"6.svg"
            hh_source_l:"./assets/asset1/6_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Saddle"
            hh_source:"7.svg"
            hh_source_l:"./assets/asset1/7_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 322 //500
            hh_y: 226 //250

        }
        /**ListElement {
            hh_name: "Leg wraps"
            hh_source:"./assets/asset1/7.svg"
            hh_source_l:"./assets/asset1/7_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 322 //500
            hh_y: 226 //250

        }*/
    }
}

