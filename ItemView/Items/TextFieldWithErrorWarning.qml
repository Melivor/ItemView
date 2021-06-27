import QtQuick 2.0

TextField {
    Text{
        enabled: parent.model.error
        visible: parent.model.error
        color:"red"
        text: parent.model.errorString
    }
}
