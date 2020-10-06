
import QtQuick 2.12
import QtQuick.Controls 2.13

import "qrc:/VariousCustomTypes"
import QtQuick.Layouts 1.3

ConfirmationDialog
{
    property var model
    function validate(){
        model.deleteCurrentSelection()
        loaderDialog.source=""
    }
}
