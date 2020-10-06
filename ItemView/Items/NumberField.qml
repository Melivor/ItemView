import QtQuick 2.12

TextField
{
    id:root
    implicitWidth: 110
    inputMethodHints: Qt.ImhFormattedNumbersOnly
    validator: DoubleValidator{}
    text:Number(model.display).toLocaleString(Qt.locale(),"f")
    anchors.right: parent.right
    function post(){
        model.display=Number.fromLocaleString(value)
    }
    background: Rectangle {
        visible: editable?true:false
        implicitWidth: root.implicitWidth+10 //
        implicitHeight: 30
        border.width: root.activeFocus ? 2 : 1
        color: root.palette.base
        border.color: root.activeFocus ? root.palette.highlight :root.palette.mid
        radius: horusTheme.baseRadius
        Text{
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top:parent.top
            anchors.bottom: parent.bottom
            text:model.unit
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            color:palette.mid
        }
    }

    //text:parent.delegateModel.display
}
