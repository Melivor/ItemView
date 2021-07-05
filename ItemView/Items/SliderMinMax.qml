import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
Item{
    property var model:parent.dmodel
    implicitHeight: slider.implicitHeight+row.implicitHeight+15
    implicitWidth: slider.implicitWidth
   // width: parent.width
    anchors.right: parent.right
    anchors.rightMargin: 10
    Component.onCompleted: console.log(parent.width)
    Slider {
        id:slider
        width: parent.width
        from:model.min
        to:model.max
        value:model.display
        //Component.onCompleted: value=model.display
        onMoved: {model.display=value}
        implicitWidth: 200
//        Component.onCompleted:{
//            if(model.display>model.max){
//                model.max=model.display
//            }

//            if(model.display<model.min){
//                model.min=model.display
//            }


//        }
        //stepSize: 1
    }
    RowLayout{
        id:row
        implicitHeight: 25
    width:slider.width
    anchors.top:slider.bottom
    anchors.topMargin: 5

    TextField{
        id:minInput
        Layout.alignment: Qt.AlignLeft
        placeholderText: "Min"
        validator: DoubleValidator{}
        text:Number(model.min).toLocaleString(Qt.locale(), 'f', 3)
        implicitWidth: slider.width/3
        implicitHeight: 25

        onEditingFinished:{
           model.min=Number.fromLocaleString(Qt.locale(), text)
        }

        Component.onCompleted:{
//            if(model.display<model.min){
//                model.min=model.display
//            }

//            text=model.min.toLocaleString()
        }

    }
    TextField{
        id:valueField
        Layout.alignment: Qt.AlignLeft
        placeholderText: "Value"
        validator: DoubleValidator{}
        text:Number(model.display).toLocaleString(Qt.locale(), 'f', 3)
        implicitWidth: slider.width/3
        implicitHeight: 25
        onEditingFinished:{
           model.display=Number.fromLocaleString(Qt.locale(),text)
        }

    }
    TextField{
        id:maxInput
        Layout.alignment: Qt.AlignRight
        placeholderText: "Max"
        validator: DoubleValidator{}
        implicitWidth: slider.width/3
        implicitHeight: 25
        text:Number(model.max).toLocaleString(Qt.locale(), 'f', 3)
        Component.onCompleted:{
//            if(model.display>model.max){
//                model.max=model.display
//            }
//            text=model.max.toLocaleString()

        }
        onEditingFinished: {

            model.max=Number.fromLocaleString(Qt.locale(), text)
           // text=model.max.toLocaleString(Qt.locale(), 'f', 3)
        }
    }
    }


}
