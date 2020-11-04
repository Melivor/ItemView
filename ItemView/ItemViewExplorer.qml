import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
import "qrc:/VariousCustomTypes"
import "Dialogs"


Item {
    id:advProfilView

    anchors.fill:parent
    property var modelExplorer
    property string title
    Component.onCompleted: modelExplorer.selectedRow=modelExplorer.activeRow
    property color warningColor: "red"
    property int radius: 5
     property int baseMargin: 20
    Loader{
        id:loaderDialog
        anchors.centerIn: parent
    }
    SplitView{
        id:splitView
        orientation: Qt.Horizontal
        anchors.fill:parent
        Rectangle{
            SplitView.fillHeight: true
            SplitView.preferredWidth: 350
            color:palette.alternateBase
            Text{
                id:title
                font.pointSize: 12
                text:advProfilView.title
                color:palette.text
                anchors.left: parent.left
                anchors.leftMargin: advProfilView.baseMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: advProfilView.baseMargin
            }
            TextField{

                id:searchField
                anchors.left:title.left
                anchors.right: title.right
                anchors.rightMargin: 10
                anchors.top:title.bottom
                anchors.topMargin: 20
                anchors.bottomMargin: 20
                placeholderText: qsTr("Search")

            }

            ListView{

                Rectangle{
                    anchors.fill:listView
                    anchors.rightMargin: 10
                    radius: advProfilView.radius
                    border.color: splitView.palette.mid
                    color:splitView.palette.base
                    z:-1
                }
                anchors.top:searchField.bottom
                anchors.topMargin: 20
                anchors.left:title.left
                anchors.bottomMargin: 20
                model:advProfilView.modelExplorer
                anchors.right: title.right
                anchors.bottom: buttonAdd.top


                id:listView
                orientation: Qt.Vertical
                boundsBehavior: Flickable.StopAtBounds

                currentIndex: modelExplorer.activeSelection
                ScrollBar.vertical:ScrollBar{
                    // policy: ScrollBar.AlwaysOn
                }
                delegate:Item{
                    //anchors.top:parent.top
                    // width: parent.width
                    implicitWidth: listView.width-10
                    implicitHeight: 35
                    opacity: mouseArea.hovered?0.5:1
                    property alias text: text.text
                    // visible: model.match(index,"display","slicr").size>0
                    Rectangle{
                        anchors.fill:parent
                        color:index%2==0?palette.base:palette.alternateBase
                        radius: advProfilView.radius

                        border.color: listView.currentIndex==index?palette.highlight:palette.mid
                    }
                    MouseArea{
                        id:mouseArea
                        anchors.fill:parent
                        hoverEnabled: true
                        onClicked: {

                            modelExplorer.setActiveSelection(display)
                        }
                    }

                    Text{
                        //height: 20
                        id:text
                        anchors.left: parent.left
                        anchors.leftMargin:advProfilView.baseMargin
                        anchors.verticalCenter: parent.verticalCenter
                        text:model.display
                        color:palette.text
                    }
                }
            }
            Button{
                id:buttonAdd
                //textColor: palette.text
                text:qsTr("Add")
                anchors.bottom: addFromWebButton.top
                anchors.bottomMargin: 10
                anchors.left:title.left
                anchors.right: title.right
                anchors.rightMargin: 10
               // highlighted: true
                onClicked: {
                    loaderDialog.setSource("Dialogs/AddProfil.qml",{"model":advProfilView.modelExplorer, "baseMargin":advProfilView.baseMargin, "radius":advProfilView.radius})
                    // loaderDialog.Dialog.item.model=model
                }

            }
            TextButton{
                id:addFromWebButton
                text:qsTr("More online")
                textColor:palette.highlight
                anchors.right: title.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
            }
        }
        Item{
            id:currentProfilView
            SplitView.fillHeight: true
            SplitView.preferredWidth: advProfilView.width*0.60
            function getItemModel (itemModel){
                detailsRect.modelItem=itemModel
            }

            // SplitView.fillWidth: true
            Rectangle{
                color:palette.alternateBase
                anchors.fill:parent
            }

            Text{
                id:currentProfil
                font.pointSize: 12
                //text:modelExplorer.activeModel?modelExplorer.activeModel.name:""
                anchors.left: parent.left
                anchors.leftMargin: baseMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: baseMargin
                color:palette.text
            }

            TextButton{
                text:qsTr("Delete this profil")
                anchors.right:rect.right
                anchors.top:currentProfil.top
                textColor: warningColor
                onClicked:  loaderDialog.setSource("Dialogs/DeleteProfil.qml",{"model":advProfilView.modelExplorer})
            }
            ItemFlowViewBySection{
                id:rect
                anchors.left: currentProfil.left
                anchors.top:currentProfil.bottom
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: baseMargin
                radius: advProfilView.radius
                baseMargin: advProfilView.baseMargin
                model:advProfilView.modelExplorer.activeModel
                Component.onCompleted: editingSetting.connect(currentProfilView.getItemModel)
            }

        }
        Rectangle{
            id:detailsRect
            Layout.preferredWidth: 200
            color: palette.alternateBase
            property var modelItem
            Text{
                id:details
                font.pointSize: 12
                text:qsTr("Details")
                anchors.left: parent.left
                anchors.leftMargin:  advProfilView.baseMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin:  advProfilView.baseMargin
                color:palette.text
            }
            Rectangle{

                anchors.left: details.left
                // anchors.leftMargin: 20
                anchors.top:details.bottom
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: 20
                color:palette.base
                anchors.bottom: parent.bottom
                anchors.bottomMargin:  advProfilView.baseMargin
                radius:  advProfilView.radius
                border.color: palette.mid
                Flow{
                    anchors.fill:parent
                    anchors.margins:  advProfilView.baseMargin
                    spacing:  advProfilView.baseMargin
                    Text{
                        text:detailsRect.modelItem?detailsRect.modelItem.description+"  ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        color:palette.text
                        //text:advListView.currentItem.description
                    }
                    Text{
                        text:detailsRect.modelItem?"min value is: "+detailsRect.modelItem.min+" ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        visible: detailsRect.modelItem?detailsRect.modelItem.min!==detailsRect.modelItem.max:false
                        color:palette.text
                    }
                    Text{
                        text:detailsRect.modelItem?"max value is: "+detailsRect.modelItem.max+" ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        visible: detailsRect.modelItem?detailsRect.modelItem.min!==detailsRect.modelItem.max:false
                        color:palette.text
                    }
                    Text{
                        text:detailsRect.modelItem?"unit is: "+detailsRect.modelItem.unit+"    ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        visible: detailsRect.modelItem?detailsRect.modelItem.unit!=="":false
                        color:palette.text
                    }
                }
            }

        }

    }

}
