import QtQuick 2.12

import QtQuick.Controls 2.13

import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2


Dialog {
    //modal: true
    id:root
    visible: true
    title: qsTr("Add new profil")
    property var model
    //anchors.centerIn: parent
    property int baseMargin: 10
    property int radius: 5
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    modality: Qt.ApplicationModal
    onAccepted: {
        model.addNew(nameField.text)
        loaderDialog.source=""
    }
    onRejected :loaderDialog.source=""

    //    footer:RowLayout {
    //        id:footer
    //        Button {
    //            text: qsTr("Cancel")
    //            Layout.alignment: Qt.AlignLeft
    //            Layout.topMargin: 0
    //            Layout.bottomMargin: 10
    //            Layout.leftMargin: 20
    //            onClicked: loaderDialog.source=""
    //        }
    //        Button{
    //            text:qsTr("Create")
    //            Layout.alignment: Qt.AlignRight
    //            Layout.rightMargin: 20
    //            onClicked:{ model.addNew(nameField.text)
    //                 loaderDialog.source=""
    //            }
    //        }

    //    }

    //contentItem:
    Rectangle{
        implicitWidth: 450
        implicitHeight: 250
        color:palette.alternateBase
        anchors.left:parent
        anchors.right: parent
        border.color: palette.mid
        radius:root.radius
        ColumnLayout {
            id: column
            anchors.fill:parent
            //anchors.top:parent.bottom
            //anchors.topMargin: 20
            //anchors.horizontalCenter: parent.horizontalCenter
            spacing:root.baseMargin

            RowLayout{
                spacing: root.baseMargin
                Layout.leftMargin: root.baseMargin
                // width: column.width
                Text {
                    id: text1
                    text:qsTr("Name: ")
                    Layout.alignment: Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredWidth: 100
                    color:palette.text
                }
                TextField{
                    id:nameField
                    Layout.preferredWidth: 250
                    Layout.alignment: Qt.AlignRight
                }
            }
            RowLayout{
                Layout.leftMargin: root.baseMargin
                spacing: root.baseMargin
                Text{
                    text:qsTr("Description: ")
                    Layout.alignment: Qt.AlignTop
                    verticalAlignment: Text.AlignVCenter
                    Layout.preferredWidth: 100
                    Layout.topMargin: 10
                    color:palette.text
                }
                TextField{
                    id:descField
                    Layout.alignment: Qt.AlignTop|Qt.AlignRight
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 80
                    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
                    //Layout.alignment: Qt.AlignRight
                }
            }
        }
    }
}
