import QtQuick 2.12
import QtQuick.Dialogs 1.2


MessageDialog {
    id: messageDialog
    title: qsTr("Warning")
    text: qsTr("Are you sure you want to delete ")+model.currentModel.name+" ?"
    icon:StandardIcon.Warning
    property var model
    standardButtons: StandardButton.Yes | StandardButton.No
    onYes: {
        model.deleteCurrentSelection()
        loaderDialog.source=""
    }
    onNo: loaderDialog.source=""
}
