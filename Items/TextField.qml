import QtQuick 2.12
import QtQuick.Controls 2.13
import "../../Style"
TextField {

    implicitHeight: 30

    property var model:parent.dmodel
    property bool editable: model.flags&Qt.ItemIsEditable
    // enabled: parent.delegateModel.flags&Qt.ItemIsEnabled
    property var value:model?model.display:""
    //property var previousValue: parent.delegateModel.display
    function post(){
        model.display=value

    }
    function cancel(){
        value=model.display
    }
    implicitWidth: 200
    //width: 200
    id:root
    //anchors.centerIn: parent
   // persistentSelection:true
    text:model.display
   // visible: parent.delegateModel.enable?true:false
    property string toolTip: model.description?model.description:""
    readOnly: editable?false:true
    z:editable?10:-1
    ToolTip {
        id:toolTip
        parent: root
        delay:1000
        text: root.toolTip

    }
    onEditingFinished:{
        value=text
        post()
        focus=false
    }
    onHoveredChanged: hovered?toolTip.visible=true:toolTip.visible=false
}
