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


Page {
    id: page
    property var harness_list: [{msg:qsTr("Forelock")},
        {msg:qsTr("Mane")},
        {msg:qsTr("Tail")},
        {msg:qsTr("Halter")},
        {msg:qsTr("Bridle")},
        {msg:qsTr("Saddle")},
        {msg:qsTr("Leg wraps")}
    ]
    property int rgp_r: 1
    property int rgp_g: 1
    property int rgp_b: 0
    property int rgp_a: 1

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

               /* // Testing coloring
                Path {
                    property string pa: "M 414.71813,206.19712 439.84195,189.98521 471.28667,187.81234 504.30328,190.36674 506.24923,196.702 C 492.90735,197.00853 467.08475,190.59467 475.95825,202.86333 L 491.86711,211.5525 519.97499,214.63183 C 518.30294,218.90865 474.68565,216.47376 469.56439,220.39861 458.25529,229.06575 485.28217,244.07631 509.82399,256.4017 552.00567,287.42837 "
                    property string pb: "531.01611,292.04408 505.67725,283.68808 494.56225,280.02268 483.46694,267.57978 475.0558,264.3631 464.1642,251.45701 459.73359,262.24121 454.24045,269.1295 393.97094,324.87554 413.043,281.26825 400.576,281.85755 401.11442,274.1482 383.26693,281.14759 404.78365,256.6556 410.76782,249.3275 415.96455,257.74828 422.79843,233.42578 429.66611,213.51364 421.50723,210.63159 414.71813,206.19712 Z"
                    id: color_path
                    startX: 414; startY: 206
                    //PathSvg { path: "M 414.71813,206.19712 439.84195,189.98521 471.28667,187.81234 504.30328,190.36674 506.24923,196.702 C 492.90735,197.00853 467.08475,190.59467 475.95825,202.86333 L 491.86711,211.5525 519.97499,214.63183 C 518.30294,218.90865 474.68565,216.47376 469.56439,220.39861 458.25529,229.06575 485.28217,244.07631 509.82399,256.4017 552.00567,287.42837 531.01611,292.04408 505.67725,283.68808 494.56225,280.02268 483.46694,267.57978 475.0558,264.3631 464.1642,251.45701 459.73359,262.24121 454.24045,269.1295 393.97094,324.87554 413.043,281.26825 400.576,281.85755 401.11442,274.1482 383.26693,281.14759 404.78365,256.6556 410.76782,249.3275 415.96455,257.74828 422.79843,233.42578 429.66611,213.51364 421.50723,210.63159 414.71813,206.19712 Z" }
                    PathSvg { path: "M 414.71813,206.19712 439.84195,189.98521 471.28667,187.81234 504.30328,190.36674 506.24923,196.702 C 492.90735,197.00853 467.08475,190.59467 475.95825,202.86333 L 491.86711,211.5525 519.97499,214.63183
C 518.30294,218.90865 474.68565,216.47376 469.56439,220.39861 458.25529,229.06575 485.28217,244.07631 509.82399,256.4017 552.00567,287.42837 531.01611,292.04408 505.67725,283.68808 494.56225,280.02268 483.46694,267.57978 475.0558,264.3631 464.1642,251.45701 459.73359,262.24121 454.24045,269.1295 393.97094,324.87554 413.043,281.26825 400.576,281.85755 401.11442,274.1482 383.26693,281.14759 404.78365,256.6556 410.76782,249.3275 415.96455,257.74828 422.79843,233.42578 429.66611,213.51364 421.50723,210.63159 414.71813,206.19712 Z" }
                }


                Canvas {
                    id: saddle
                    x: 0
                    y: 0
                    width: 750
                    height: 500
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.strokeStyle = Qt.rgba(rgp_r, rgp_g, rgp_b, rgp_a);
                        ctx.fillStyle = Qt.rgba(rgp_r, rgp_g, rgp_b, rgp_a);
                        ctx.scale(page.width/750, page.width/750)
                        ctx.path = color_path;
                        ctx.stroke();
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            rgp_r = 0
                            console.log("red")
                            saddle.requestPaint()
                        }

                    }
                }

                // End testing */
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
                        height: 0.85*grid.cellHeight
                        border.width: 3
                        border.color: "black"
                        Image {
                            fillMode: Image.PreserveAspectFit
                            source: asset_path + hh_source_l
                            opacity: coins > index*20 ? 1.0: 0.2
                            anchors.fill: parent
                            MouseArea {
                                anchors.fill: parent
                                height: grid.cellHeight
                                width: grid.cellWidth
                                enabled: coins > index*20 ? true: false
                                onClicked: {
                                    if (horse_harness.get(index).hh_visible === false){
                                        horse_harness.set(index,{"hh_visible":true})
                                    }
                                    else {
                                        horse_harness.set(index,{"hh_visible":false})
                                    }
                                }
                            }
                        } // Image
                        Rectangle {
                            width:grid.cellWidth
                            height:0.15*grid.cellWidth
                            color:"white"
                            anchors.top: hh_rec.bottom
                        }

                        Text {
                            text: harness_list[index].msg
                            anchors.top: hh_rec.bottom
                            anchors.horizontalCenter:  hh_rec.horizontalCenter
                        }
                    }
                }

            }

        }
    }

    ListModel {
        id: horse_harness
        ListElement {
            hh_name: "Forelock"
            hh_source:"2.svg"
            hh_source_l:"2_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 700
            hh_y: 450
        }
        ListElement {
            hh_name: "Mane"
            hh_source:"3.svg"
            hh_source_l:"3_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Tail"
            hh_source:"4.svg"
            hh_source_l:"4_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Halter"
            hh_source:"5.svg"
            hh_source_l:"5_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Bridle"
            hh_source:"6.svg"
            hh_source_l:"6_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 250
            hh_y: 450
        }
        ListElement {
            hh_name: "Saddle"
            hh_source:"7.svg"
            hh_source_l:"7_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 322 //500
            hh_y: 226 //250

        }
        ListElement {
            hh_name: "Leg wraps"
            hh_source:"8.svg"
            hh_source_l:"8_l.svg"
            hh_enabled:false
            hh_visible: false
            hh_x: 322 //500
            hh_y: 226 //250

        }
    }
}

