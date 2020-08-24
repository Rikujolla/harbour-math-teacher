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
import "./horse.js" as Horse
//These patches mean large coloured areas on horse skin, e.g. https://en.wikipedia.org/wiki/Pinto_horse


Page {
    id: page
    property var harness_list: [
        {msg:qsTr("Horse")},
        //: These patches mean large coloured areas on horse skin, e.g. https://en.wikipedia.org/wiki/Pinto_horse
        {msg:qsTr("Patches")},
        {msg:qsTr("Forelock")},
        {msg:qsTr("Mane")},
        {msg:qsTr("Tail")},
        {msg:qsTr("Shoes")},
        {msg:qsTr("Halter")},
        {msg:qsTr("Bridle")},
        {msg:qsTr("Saddle blanket")},
        {msg:qsTr("Saddle")},
        {msg:qsTr("Leg wraps")},
        //: Rosette is a prize which is attached to the horses bridle after a winned race
        {msg:qsTr("Rosette")}
    ]
    property string blotch_color: "transparent"
    property var myColors: [ "#000000", "#ffffff", "#ffd633", "#cca300", "#cc4400", "#bf4040", "#cc6600", "#8a8a5c", "#990000", "#999900", "#808000", "#e65c00", "#997300", "#862d59", "#992600"]
    property string folder_file : "$HOME/horse1.png" //Folder for layer images.

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
            MenuItem {
                text:qsTr("Share my horse")
                onClicked:{
                    console.log(folder_file)
                    saddle.save("/home/nemo/horse.png")
                    pageStack.push("Sailfish.TransferEngine.SharePage",

                                   {
                                       "source": "/home/nemo/horse.png",
                                       "mimeType": "image/png",
                                       "content": { "type": "text/x-uri", "status": "Sent from SailfishOS app Math teacher" },
                                       "serviceFilter": ["sharing", "e-mail"]
                                   }
                                   )
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

            Rectangle {
                id: horse
                width: page.width
                height: 500*page.width/750
                color: "transparent"

                // Using tables in Canvas can be learned e.g. from https://felgo.com/doc/qt/qtquick-canvas-tiger-tiger-js/
                Canvas {
                    id: saddle
                    x: 0
                    y: 0
                    width: page.width
                    height: 500*page.width/750

                    function clear() {
                        var ctx = getContext("2d");
                        ctx.reset();
                        saddle.requestPaint()
                    }

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.scale(page.width/750, page.width/750)
                        for (var i = 0; i < harnesses.count; i++) {
                            ctx.lineWidth = harnesses.get(i).width;
                            ctx.path = harnesses.get(i).path;

                            ctx.fillStyle = harnesses.get(i).fill;
                            if (harnesses.get(i).painted === true ){
                                ctx.fill();
                            }

                            ctx.strokeStyle = harnesses.get(i).stroke;
                            if (harnesses.get(i).painted === true){
                                ctx.stroke();
                            }
                        }
                        ctx.restore();
                    }
                }

                // End testing
            }
            BackgroundItem {
                width: page.width
                height: 3*page.width/4
                GridView {
                    id:grid
                    cellWidth: page.width/4
                    cellHeight: page.width/4
                    anchors.fill: parent
                    model:horse_harness
                    delegate: Rectangle {
                        id:hh_rec
                        width: grid.cellWidth
                        height: 0.8*grid.cellHeight
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
                                    console.log(harnesses.count)
                                    for (var i = 0; i < harnesses.count; i++) {
                                        if (harnesses.get(i).index === index && harnesses.get(i).painted === true) {
                                            harnesses.set(i,{"painted":false});
                                            saddle.clear();
                                        }
                                        else if (harnesses.get(i).index === index && harnesses.get(i).painted === false) {
                                            harnesses.set(i,{"painted":true})
                                            saddle.clear();
                                        }
                                    }
                                }

                                onPressAndHold: {
                                    var dialog = pageStack.push("Sailfish.Silica.ColorPickerDialog", { "colors": myColors })
                                    dialog.accepted.connect(function() {
                                        blotch_color = dialog.color
                                        for (var i = 0; i < harnesses.count; i++) {
                                            if (harnesses.get(i).index === index) {
                                                harnesses.set(i,{"painted":true});
                                                harnesses.set(i,{"fill":blotch_color, "stroke":blotch_color})
                                            }
                                        }
                                        saddle.clear();
                                    })
                                }
                            }
                        } // Image

                        Rectangle {
                            width:grid.cellWidth
                            height:0.2*grid.cellWidth
                            color:"white"
                            anchors.top: hh_rec.bottom
                        }

                        Text {
                            text: harness_list[index].msg
                            font.pixelSize: Theme.fontSizeExtraSmall
                            anchors.top: hh_rec.bottom
                            anchors.horizontalCenter:  hh_rec.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    /*ListModel {
        id:harnesses
        ListElement {
            label:"Halter"
            index: 5
            fill: "#502d16"
            stroke:"#502d16"
            width:0.1
            painted:false
            path:""
        }
    }*/

    ListModel {
        id: horse_harness
        ListElement {
            //hh_name: "Horse"
            //hh_source:"0.svg"
            hh_source_l:"0_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Patches"
            //hh_source:"1.svg"
            hh_source_l:"1_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Forelock"
            //hh_source:"2.svg"
            hh_source_l:"2_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Mane"
            //hh_source:"3.svg"
            hh_source_l:"3_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Tail"
            //hh_source:"4.svg"
            hh_source_l:"4_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Shoes"
            //hh_source:"5.svg"
            hh_source_l:"5_ll.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Halter"
            //hh_source:"5.svg"
            hh_source_l:"5_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Bridle"
            //hh_source:"6.svg"
            hh_source_l:"6_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Saddle blanket"
            //hh_source:"8.svg"
            hh_source_l:"8.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Saddle"
            //hh_source:"9.svg"
            hh_source_l:"9.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Leg wraps"
            //hh_source:"8.svg"
            hh_source_l:"8_l.svg"
            hh_enabled:false
        }
        ListElement {
            //hh_name: "Rosette"
            //hh_source:"8.svg"
            hh_source_l:"11_l.svg"
            hh_enabled:false
        }
    }



    Component.onCompleted: {
        if (harnesses.count === 1){
            harnesses.clear();
            Horse.fill_harness();
        }

    }
}

