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
import "pages"
import "pages/settings.js" as Mysets

ApplicationWindow
{
    initialPage: Component { QuizPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.Portrait
    //allowedOrientations: defaultAllowedOrientations

    // Common start
    property int coins: 0 // Global property for money
    property int level_points : 0 // Normally increase when you get a point when answering right
    property int level: 0 //
    property int questions_count: 4
    property string asset_path : "./assets/asset1/" //Asset number
    property string player_name: "Horse rider" // Default player name
    property bool developer: false //Developer setting to prevent console logs in production

    ListModel {
        id: mistakesModel
        ListElement {
            first: 1
            second: 2
        }
    }
    ListModel {
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
    }
    // Common end

    Component.onCompleted: {
        Mysets.loadSettings()
        //pageStack.push(Qt.resolvedUrl(startPageTxt))
    }

}
