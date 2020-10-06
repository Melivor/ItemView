import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
import "../Style"
import "../CustomType"
import "Dialogs"


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
            color:horusTheme.backgroundColor
            Text{
                id:title
                font.pointSize: 12
                text:advProfilView.title
                anchors.left: parent.left
                anchors.leftMargin: parent.width*horusTheme.sectionMarginFactor
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: parent.width*horusTheme.baseMarginFactor
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
                    radius: horusTheme.baseRadius
                    border.color: horusTheme.borderColor
                    z:-1
                }
                anchors.top:searchField.bottom
                anchors.topMargin: 20
                anchors.left:title.left
                anchors.bottomMargin: 20
                model:advProfilView.modelExplorer

                // anchors.leftMargin: parent.width*horusTheme.baseMarginFactor
                anchors.right: title.right
                // anchors.rightMargin: parent.width*horusTheme.baseMarginFactor
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
                        color:modelExplorer.row%2==0?horusTheme.backgroundColor:horusTheme.foregroundColor
                        radius: horusTheme.baseRadius

                        border.color: listView.currentIndex==index?horusTheme.standardBlue:horusTheme.borderColor
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
                        anchors.leftMargin: parent.width*horusTheme.baseMarginFactor
                        anchors.verticalCenter: parent.verticalCenter
                        text:model.display
                    }
                }
            }
            Button{
                id:buttonAdd
                textColor: horusTheme.textColor
                text:qsTr("Add")
                anchors.bottom: addFromWebButton.top
                anchors.bottomMargin: 10
                anchors.left:title.left
                anchors.right: title.right
                anchors.rightMargin: 10
                highlighted: true
                onClicked: {
                    loaderDialog.setSource("AddProfil.qml",{"model":advProfilView.modelExplorer})
                    // loaderDialog.Dialog.item.model=model
                }

            }
            TextButton{
                id:addFromWebButton
                text:qsTr("More online")
                textColor:horusTheme.standardBlue
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
                color:horusTheme.backgroundColor
                anchors.fill:parent
            }

            Text{
                id:currentProfil
                font.pointSize: 12
                text:listView.currentModel?listView.currentModel.name:""
                anchors.left: parent.left
                anchors.leftMargin: horusTheme.sectionMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: parent.width*horusTheme.baseMarginFactor
            }

            TextButton{
                text:qsTr("Delete this profil")
                anchors.right:rect.right
                anchors.top:currentProfil.top
                textColor: horusTheme.standardRed
                onClicked:  loaderDialog.setSource("DeleteProfil.qml",{"model":advProfilView.modelExplorer})
            }
            Rectangle{
                id:rect
                anchors.left: currentProfil.left
                // anchors.leftMargin: 20
                anchors.top:currentProfil.bottom
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: 20
                color:horusTheme.foregroundColor
                anchors.bottom: parent.bottom
                anchors.bottomMargin: horusTheme.baseMargin
                radius: horusTheme.baseRadius
                border.color: horusTheme.borderColor
                Flow{
                    id:root
                    anchors.top:parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: horusTheme.baseMargin
                    anchors.rightMargin: horusTheme.baseMargin
                    anchors.topMargin: horusTheme.baseMargin


                    //columns: 8
                    //rows:
                    //property var currentModel:model.currentListView
                    //anchors.fill:parent
                    //anchors.margins: 20
                    flow:Flow.TopToBottom
                    // columnSpacing: horusTheme.baseSpacing
                    //rowSpacing:  horusTheme.baseSpacing
                    //rows:3
                    spacing: horusTheme.baseSpacing/2
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
                                }
                                Rectangle{
                                    //anchors.fill:advlistView
                                    border.color: horusTheme.borderColor
                                    color: horusTheme.backgroundColor
                                    radius: horusTheme.baseRadius
                                    z:-1
                                    implicitWidth:advListView.width+horusTheme.baseMargin
                                    implicitHeight: advListView.height+horusTheme.baseMargin

                                    ItemListView{
                                        id:advListView
                                        // x:horusTheme.baseMargin
                                        y:horusTheme.baseMargin/2
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
            color: horusTheme.backgroundColor
            property var modelItem
            Text{
                id:details
                font.pointSize: 12
                text:qsTr("Details")
                anchors.left: parent.left
                anchors.leftMargin: horusTheme.sectionMargin
                anchors.top:parent.top
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: parent.width*horusTheme.baseMarginFactor
            }
            Rectangle{

                anchors.left: details.left
                // anchors.leftMargin: 20
                anchors.top:details.bottom
                anchors.topMargin: 20
                anchors.right:parent.right
                anchors.rightMargin: 20
                color:horusTheme.foregroundColor
                anchors.bottom: parent.bottom
                anchors.bottomMargin: horusTheme.baseMargin
                radius: horusTheme.baseRadius
                border.color: horusTheme.borderColor
                Flow{
                    anchors.fill:parent
                    anchors.margins: horusTheme.baseMargin
                    spacing: horusTheme.baseSpacing
                    Text{
                        text:detailsRect.modelItem?detailsRect.modelItem.description+"  ":""
                        width:parent.width
                        wrapMode: Text.Wrap

                        //text:advListView.currentItem.description
                    }
                    Text{
                        text:detailsRect.modelItem?"min value is: "+detailsRect.modelItem.min+" ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        visible: detailsRect.modelItem?detailsRect.modelItem.min!==detailsRect.modelItem.max:false
                    }
                    Text{
                        text:detailsRect.modelItem?"max value is: "+detailsRect.modelItem.max+" ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        visible: detailsRect.modelItem?detailsRect.modelItem.min!==detailsRect.modelItem.max:false
                    }
                    Text{
                        text:detailsRect.modelItem?"unit is: "+detailsRect.modelItem.unit+"    ":""
                        width:parent.width
                        wrapMode: Text.Wrap
                        visible: detailsRect.modelItem?detailsRect.modelItem.unit!=="":false
                    }
                }
            }

            // Layout.preferredHeight: rect.height-2*horusTheme.baseMargin
            //Layout.preferredWidth: 400
            //Layout.column: (rect3.bottom+rect4.height)>parent.bottom?rect3.Layout.column+1:rect3.Layout.column
            //  implicitWidth: 600
            //  implicitHeight: rect.height-2*horusTheme.baseMargin
            // border.color: horusTheme.borderColor
            //color:horusTheme.backgroundColor
            //radius:horusTheme.baseRadius
            // Layout.columnSpan: 2

        }

    }

}
