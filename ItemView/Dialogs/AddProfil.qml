import QtQuick 2.12
//import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.13

import QtQuick.Layouts 1.3
import "qrc:/import"

Dialog {
    modal: true
    id:root
    visible: true
    title: qsTr("Add new profil")
    property var model
    anchors.centerIn: parent
    footer:RowLayout {
        id:footer
        Button {
            text: qsTr("Cancel")
            Layout.alignment: Qt.AlignLeft
            Layout.topMargin: 0
            Layout.bottomMargin: 10
            Layout.leftMargin: 20
            onClicked: loaderDialog.source=""
        }
        Button{
            text:qsTr("Create")
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 20
            onClicked:{ model.addNew(nameField.text)
                 loaderDialog.source=""
            }
        }

    }
    contentItem:
        ColumnLayout {
            id: column
            //anchors.top:parent.bottom
            //anchors.topMargin: 20
            //anchors.horizontalCenter: parent.horizontalCenter
            spacing:HorusTheme.baseSpacing

            RowLayout{
                spacing: HorusTheme.baseSpacing
                Layout.leftMargin: HorusTheme.baseMargin
               // width: column.width
            Text {
                id: text1
                text:qsTr("Name: ")
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                Layout.preferredWidth: 100
            }
            TextField{
                id:nameField
               Layout.preferredWidth: root.width/2
                Layout.alignment: Qt.AlignRight
            }
            }
            RowLayout{
                Layout.leftMargin: HorusTheme.baseMargin
                spacing: HorusTheme.baseSpacing
                Text{
                    text:qsTr("Description: ")
                    Layout.alignment: Qt.AlignTop
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredWidth: 100
                    Layout.topMargin: 10
                }
                TextField{
                    id:descField
                    Layout.alignment: Qt.AlignTop|Qt.AlignRight
                    Layout.preferredWidth: root.width/2
                    Layout.preferredHeight: 80
                    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
                    //Layout.alignment: Qt.AlignRight
                }
            }
        }
   // }

}
