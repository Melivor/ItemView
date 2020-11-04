import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
//import Qt.labs.platform 1.1

Rectangle{
    id:root
    anchors.centerIn: parent
    //anchors.horizontalCenter: parent.horizontalCenter
    //anchors.top: parent.top
    //anchors.topMargin: height/2
    property var model:parent.dmodel

    property bool editable: model.flags&Qt.ItemIsEditable
    property bool hovered:false
    property string toolTip: model.description?model.description:""
    property var value:model.display
    function post(){
        model.display=value
    }
    function cancel(){
        value=model.display
    }
    Control{
        id:control
    }

    //border.width: hovered?1.2:0
    border.color: hovered?control.palette.highlight:control.palette.mid
    border.width: 1
    color:value
    implicitWidth:50
    implicitHeight: 20
    z:editable?10:-1
    ColorDialog {
        id: colorDialog
        title: qsTr("Please choose a color")
        //showAlphaChannel: true
        // x: (window.width - width) / 2
        // y: (window.height - height) / 2

        onAccepted: {
            //fbitem.setColor(colorDialog.color)
            value=colorDialog.color
            post()
            //root.parent.delegateModel.display=colorDialog.color
            close()
        }
        onRejected: {
            close()
        }
    }

    MouseArea {
             hoverEnabled: true
             anchors.fill: root
             onEntered: hovered=true
             onExited: hovered=false
             onClicked: {
                 if(editable){
                    colorDialog.color=model.display
                    colorDialog.open()
                     console.log("Editing color !")
                 }

             }
         }
}
