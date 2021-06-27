import QtQuick 2.12
import QtQuick.Controls 2.12

Slider {
    property var model:parent.dmodel
    from:model.display[1]
    to:model.display[2]
    Component.onCompleted: value=model.display[0]
    onMoved: {model.display=value}
    implicitWidth: 200
    //stepSize: 1
}
