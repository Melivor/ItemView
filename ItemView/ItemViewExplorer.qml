import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
//
import "qrc:/VariousCustomTypes"
import "Dialogs"
import "qrc:/import"


Item {
    id:advProfilView

    anchors.fill:parent
    property var modelExplorer
    property string title
    Component.onCompleted: modelExplorer.selectedRow=modelExplorer.activeRow
    Loader{
        id:loaderDialog
        anchors.centerIn: parent
    }
    SplitView{
        orientation: Qt.Horizontal
        anchors.fill:parent
        Rectangle{
            SplitView.fillHeight: true
            SplitView.preferredWidth: 350
            color:HorusTheme.backgroundColor
            Text{
                id:title
                font.pointSize: 12
                text:advProfilView.title
                color:palette.text
                anchors.left: parent.left
                anchors.leftMargin: parent.width*HorusTheme.sectionMarginFactor
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: parent.width*HorusTheme.baseMarginFactor
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
                    radius: HorusTheme.baseRadius
                    border.color: HorusTheme.borderColor
                    z:-1
                }
                anchors.top:searchField.bottom
                anchors.topMargin: 20
                anchors.left:title.left
                anchors.bottomMargin: 20
                model:advProfilView.modelExplorer

                // anchors.leftMargin: parent.width*HorusTheme.baseMarginFactor
                anchors.right: title.right
                // anchors.rightMargin: parent.width*HorusTheme.baseMarginFactor
                anchors.bottom: buttonAdd.top

                id:listView
                orientation: Qt.Vertical
                boundsBehavior: Flickable.StopAtBounds
               // onCurrentIndexChanged: if(modelExplorer.currentSelection!==currentIndex)modelExplorer.currentSelection=currentIndex
                currentIndex: modelExplorer.currentSelection
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
                        color:modelExplorer.row%2==0?HorusTheme.backgroundColor:HorusTheme.foregroundColor
                        radius: HorusTheme.baseRadius

                        border.color: listView.currentIndex==index?HorusTheme.standardBlue:HorusTheme.borderColor
                    }
                    MouseArea{
                        id:mouseArea
                        anchors.fill:parent
                        hoverEnabled: true
                        onClicked: {

                            modelExplorer.setCurrentSelection(display)
                        }
                    }

                    Text{
                        //height: 20
                        id:text
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*HorusTheme.baseMarginFactor
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
                highlighted: true
                onClicked: {
                    loaderDialog.setSource("Dialogs/AddProfil.qml",{"model":advProfilView.modelExplorer})
                    // loaderDialog.Dialog.item.model=model
                }

            }
            TextButton{
                id:addFromWebButton
                text:qsTr("More online")
                textColor:HorusTheme.standardBlue
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
                color:HorusTheme.backgroundColor
                anchors.fill:parent
            }

            Text{
                id:currentProfil
                font.pointSize: 12
                text:listView.currentModel?listView.currentModel.name:""
                anchors.left: parent.left
                anchors.leftMargin: HorusTheme.sectionMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: parent.width*HorusTheme.baseMarginFactor
                color:palette.text
            }

            TextButton{
                text:qsTr("Delete this profil")
                anchors.right:rect.right
                anchors.top:currentProfil.top
                textColor: HorusTheme.standardRed
                onClicked:  loaderDialog.setSource("Dialogs/DeleteProfil.qml",{"model":advProfilView.modelExplorer})
            }
            Rectangle{
                id:rect
                anchors.left: currentProfil.left
                // anchors.leftMargin: 20
                anchors.top:currentProfil.bottom
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: 20
                color:HorusTheme.foregroundColor
                anchors.bottom: parent.bottom
                anchors.bottomMargin: HorusTheme.baseMargin
                radius: HorusTheme.baseRadius
                border.color: HorusTheme.borderColor
                Flow{
                    id:root
                    anchors.top:parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: HorusTheme.baseMargin
                    anchors.rightMargin: HorusTheme.baseMargin
                    anchors.topMargin: HorusTheme.baseMargin


                    //columns: 8
                    //rows:
                    //property var currentModel:model.currentListView
                    //anchors.fill:parent
                    //anchors.margins: 20
                    flow:Flow.TopToBottom
                    // columnSpacing: HorusTheme.baseSpacing
                    //rowSpacing:  HorusTheme.baseSpacing
                    //rows:3
                    spacing: HorusTheme.baseSpacing/2
                    Repeater {
                        id:repeater
                        model:advProfilView.modelExplorer.currentModel.sections.length
                        //anchors.fill:parent
                        //width: parent.model.sectionNumber*250

                        delegate:
                            Item{
                            //Layout.preferredHeight:childrenRect.height
                            //Layout.preferredWidth:  childrenRect.width
                            implicitHeight: childrenRect.height
                            implicitWidth: childrenRect.width
                            Column{
                                spacing: 20
                                Text{
                                    text:advProfilView.modelExplorer.currentModel.sections[index].name
                                    font.pointSize: 10
                                    color:palette.text
                                }
                                Rectangle{
                                    //anchors.fill:advlistView
                                    border.color: HorusTheme.borderColor
                                    color: HorusTheme.backgroundColor
                                    radius: HorusTheme.baseRadius
                                    z:-1
                                    implicitWidth:advListView.width+HorusTheme.baseMargin
                                    implicitHeight: advListView.height+HorusTheme.baseMargin

                                    ItemListView{
                                        id:advListView
                                        // x:HorusTheme.baseMargin
                                        y:HorusTheme.baseMargin/2
                                        x:20
                                        height: Math.min(contentHeight,root.height-100)
                                        model:advProfilView.modelExplorer.currentModel.sections[index]
                                        // height:childrenRect.height
                                        width: 400
                                        Component.onCompleted: advListView.editingSetting.connect(currentProfilView.getItemModel)
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
        Rectangle{
            id:detailsRect
            Layout.preferredWidth: 200
            color: HorusTheme.backgroundColor
            property var modelItem
            Text{
                id:details
                font.pointSize: 12
                text:qsTr("Details")
                anchors.left: parent.left
                anchors.leftMargin: HorusTheme.sectionMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: parent.width*HorusTheme.baseMarginFactor
                color:palette.text
            }
            Rectangle{

                anchors.left: details.left
                // anchors.leftMargin: 20
                anchors.top:details.bottom
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: 20
                color:HorusTheme.foregroundColor
                anchors.bottom: parent.bottom
                anchors.bottomMargin: HorusTheme.baseMargin
                radius: HorusTheme.baseRadius
                border.color: HorusTheme.borderColor
                Flow{
                    anchors.fill:parent
                    anchors.margins: HorusTheme.baseMargin
                    spacing: HorusTheme.baseSpacing
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
