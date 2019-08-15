// NameInputDialog.qml
 import QtQuick 2.2
 import Sailfish.Silica 1.0

 Dialog {
     property string name

     Column {
         width: parent.width

         DialogHeader { }

         TextField {
             id: nameField
             width: parent.width
             placeholderText: qsTr("Add your player name!")
             label: qsTr("Player name")
         }
     }

     onDone: {
         if (result == DialogResult.Accepted) {
             name = nameField.text
         }
     }
 }
