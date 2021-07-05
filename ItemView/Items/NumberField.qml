import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
TextField
{
    id:control
    implicitWidth: 110
    inputMethodHints: Qt.ImhFormattedNumbersOnly
    validator: DoubleValidator{}
    text:Number(model.display).toLocaleString(Qt.locale(),"f",3)
    anchors.right: parent.right
    //anchors.rightMargin: 10
    function post(){
        model.display=Number.fromLocaleString(text)
    }
    onEditingFinished: post()

    PlaceholderText {
        id: placeholder
        //anchors.right:control.right
        x: control.width-contentWidth-control.rightPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: model.unit
        font: control.font
        color: control.placeholderTextColor
        visible: true
        //visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        verticalAlignment: control.verticalAlignment
        elide: Text.ElideRight
        renderType: control.renderType
    }
//    background: Rectangle {
//        visible: editable?true:false
//        implicitWidth: control.implicitWidth+10 //
//        implicitHeight: 30
//        border.width: control.activeFocus ? 2 : 1
//        color: control.palette.base
//        border.color: control.activeFocus ?palette.highlight :palette.mid
//        radius: 10
//        Text{
//            anchors.right: parent.right
//            anchors.rightMargin: 10
//            anchors.top:parent.top
//            anchors.bottom: parent.bottom
//            text:model.unit
//            horizontalAlignment: Text.AlignRight
//            verticalAlignment: Text.AlignVCenter
//            color:control.color
//        }
//    }

    //text:parent.delegateModel.display
}
