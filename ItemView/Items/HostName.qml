import QtQuick 2.12
import QtQuick.Controls 2.13
import "qrc:/VariousCustomTypes"
import QtQuick.Layouts 1.12
Item{
    id:row
    height: 30
    width: 210
    property var model:parent.dmodel
    property bool editable: false
    property string toolTip: model.description?model.description:""
    property var value:model?model.display:""
    function post(){
        model.display=value

    }
    function cancel(){
        value=model.display
    }
    TextField {
       // z:parent.z+1
        implicitHeight: 30
       // width: 100
        implicitWidth: 90
        id:root
        text:model?model.display:""
        readOnly: row.editable?false:true
        function setValue(valueToBeSet){
            value=valueToBeSet
            post()
            focus=false
        }

        ToolTip {
            id:toolTip
            parent: root
            delay:1000
            text: row.toolTip

        }
        onEditingFinished:{
            value=text
            post()
            focus=false
        }
        onHoveredChanged: hovered?toolTip.visible=true:toolTip.visible=false
    }
    TextButton{
         height: 30
         x:90
         implicitHeight: 30
        // z:parent.z+1
        // font.bold:true
         hoverEnabled: true
         text:qsTr("test connection")
         textColor: palette.highlight
         onClicked: {
             //printSender.stopListenning()
             loaderDialog.setSource("qrc:/Qml/Dialogs/StateDialogs/ConnectingPrinter.qml", {"receptorItem":root, "hostname":value})
             //loaderDialog.setSource("qrc:/Qml/Dialogs/AddPrinterDialog.qml", {"receptorItem":root})
         }
    }
}
