import QtQuick 2.1
import QtQuick.Controls 1.4 as OldCtrl
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.5
import QtQuick.Window 2.1
import QtQuick.Controls.Material 2.1
import "MaterialDesign.js" as MD
import QtQuick.Extras 1.4

ApplicationWindow {
    id: page
    width: 1200
    height: 800
    visible: true
    Material.primary: Material.DeepOrange
    Material.theme: Material.Dark
    Material.accent: Material.Red

    FontLoader {
        id: iconFont
        source: "fonts/MaterialIcons-Regular.ttf"
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                onClicked: stack.pop()
            }
            Image {
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.height*2
                anchors.horizontalCenter: parent.horizontalCenter
                source: "img/header.png"
            }
            ToolButton {
                anchors.right: parent.right
                text: qsTr("⋮")
                onClicked: drawer.open()
            }
        }
    }
    TabBar {
        id: bar
        width: parent.width
        background: Rectangle {
        color: Material.primary
        }
        TabButton {
            text: qsTr("VCU")
        }
        TabButton {
            text: qsTr("LBCM")
        }
    }

    Drawer {
        id: drawer
        width: parent.width/3
        height: parent.height
        Rectangle {
            property Item visualParent: parent
            height: parent.height
            width: parent.width
            color: "#303030"
            ColumnLayout {
                height: parent.height
                width: parent.width
                Image {
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "img/brain-corp.png"
                }
                RowLayout {
                    height: parent.height
                    width: parent.width
                    Rectangle {
                        color: "transparent"
                        height: parent.height
                        width: parent.width
                        Text {
                            id: settings

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.family: iconFont.name
                            font.pixelSize: 36
                            color: "white"
                            text: MD.icons.settings
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 36
                            text: "General Settings"
                            color: 'white'
                        }
                        MouseArea {
                            anchors.fill: parent
                            onPressed:  parent.opacity = 0.5 // down state
                            onReleased: parent.opacity = 1
                            onCanceled: parent.opacity = 1
                            onClicked:  root.clicked() // emit
                        }
                    }
                }
                RowLayout {
                    height: parent.height
                    width: parent.width
                    Rectangle {
                        color: "transparent"
                        height: parent.height
                        width: parent.width
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.family: iconFont.name
                            font.pixelSize: 36
                            color: "white"
                            text: MD.icons.security
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 36
                            text: "SSH Settings"
                            color: 'white'
                        }
                        MouseArea {
                            anchors.fill: parent
                            onPressed:  parent.opacity = 0.5 // down state
                            onReleased: parent.opacity = 1
                            onCanceled: parent.opacity = 1
                            onClicked:  root.clicked() // emit
                        }
                    }
                }
                RowLayout {
                    height: parent.height
                    width: parent.width
                    Rectangle {
                        color: "transparent"
                        height: parent.height
                        width: parent.width
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.family: iconFont.name
                            font.pixelSize: 36
                            color: "white"
                            text: MD.icons.network_cell
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 36
                            text: "OTA Settings"
                            color: 'white'
                        }
                        MouseArea {
                            anchors.fill: parent
                            onPressed:  parent.opacity = 0.5 // down state
                            onReleased: parent.opacity = 1
                            onCanceled: parent.opacity = 1
                            onClicked:  root.clicked() // emit
                        }
                    }
                }
                RowLayout {
                    height: parent.height
                    width: parent.width
                    Rectangle {
                        color: "transparent"
                        height: parent.height
                        width: parent.width
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.family: iconFont.name
                            font.pixelSize: 36
                            color: "white"
                            text: MD.icons.usb
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 36
                            text: "UART"
                            color: 'white'
                        }
                        MouseArea {
                            anchors.fill: parent
                            onPressed:  parent.opacity = 0.5 // down state
                            onReleased: parent.opacity = 1
                            onCanceled: parent.opacity = 1
                            onClicked:  root.clicked() // emit
                        }
                    }
                }
                RowLayout {
                    height: parent.height
                    width: parent.width
                }
               RowLayout {
                    height: parent.height
                    width: parent.width
                }
                RowLayout {
                    height: parent.height
                    width: parent.width
                }
               RowLayout {
                    height: parent.height
                    width: parent.width
                }
               RowLayout {
                    height: parent.height
                    width: parent.width
                }
               RowLayout {
                    height: parent.height
                    width: parent.width
                }
               RowLayout {
                    height: parent.height
                    width: parent.width
                }
               RowLayout {
                    height: parent.height
                    width: parent.width
                }
            }
        }
        Overlay.modal: Rectangle {
        color: "#aa303030"
        }
    }

    StackLayout {
        height: parent.height
        width: 1200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: logging.height
        currentIndex: bar.currentIndex
        Item {
            id: vcuTab
            GridLayout {
                width: 1200
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 100
                columns: 3
                ColumnLayout {
                    spacing: 10
                    Text { text: "Motor Controls"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                    Rectangle { color: "transparent"; border.color: 'white'; radius: 6;width: parent.width; height: parent.height}
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    RowLayout {
                        Button {
                            anchors.right: parent.right
                            text: "Run Left Motor "
                            highlighted: true
                            Material.accent: Material.primary
                        }
                        Slider {
                            Layout.preferredWidth: 150
                            anchors.left: parent.left
                            Material.accent: Material.primary
                            value: 0.5
                        }
                    }
                    RowLayout {
                        Button {
                            anchors.right: parent.right
                            text: "Run Right Motor"
                            highlighted: true
                            Material.accent: Material.primary
                        }
                        Slider {
                            Layout.preferredWidth: 150
                            anchors.left: parent.left
                            Material.accent: Material.primary
                            value: 0.5
                        }
                    }
                    RowLayout {
                        Button {
                            anchors.right: parent.right
                            text: "Sweeper Motor"
                            highlighted: true
                            Material.accent: Material.primary
                        }
                        Slider {
                            Layout.preferredWidth: 150
                            anchors.left: parent.left
                            Material.accent: Material.primary
                            value: 0.5
                        }
                    }
                    RowLayout {
                        ColumnLayout{
                            width: parent.width*2
                            Text { text: "Actuator"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            Slider {
                                Layout.preferredWidth: 300
                                anchors.left: parent.left
                                Material.accent: Material.primary
                                value: 0.5
                            }
                        }
                    }
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        ColumnLayout{
                            Layout.alignment: Qt.AlignHCenter
                            Text { text: "Vacuum"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            RowLayout{
                                spacing: 20
                                Layout.alignment: Qt.AlignHCenter

                                RadioButton {
                                    text: "Off"
                                }
                                RadioButton {
                                    text: "On"
                                }
                                RadioButton {
                                    text: "Turbo"
                                }
                            }
                        }
                    }
                }
                ColumnLayout {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Senor Controls"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                    Rectangle { color: "transparent"; border.color: 'white'; radius: 6;width: parent.width; height: parent.height}
                    RowLayout {
                        spacing: 80
                        Layout.alignment: Qt.AlignHCenter
                        Switch {
                            anchors.right: parent.right
                            checked: false
                        }
                        Text { text: "Enable Sensors"; font.bold: true; color: 'white';anchors.left: parent.left}
                    }
                    Text { text: "Cliff Sensors"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                    RowLayout {
                        spacing: 20
                        ColumnLayout {
                            Text { text: "S1"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                        ColumnLayout {
                            Text { text: "S2"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                        ColumnLayout {
                            Text { text: "S3"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                        ColumnLayout {
                            Text { text: "S4"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                        ColumnLayout {
                            Text { text: "S5"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                        ColumnLayout {
                            Text { text: "S6"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                    }
                    Text { text: "Bumper Sensors"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                    RowLayout {
                        spacing: 75
                        Text { text: " ";}
                        ColumnLayout {
                            anchors.leftMargin: 60
                            Text { text: "Left"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                        ColumnLayout {
                            anchors.right: parent.right
                            Text { text: "Right"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                            StatusIndicator {
                                color: Material.Primary
                             }
                        }
                    }
                    RowLayout {
                        spacing: 80
                        Layout.alignment: Qt.AlignHCenter
                        StatusIndicator {
                            anchors.right: parent.right
                            color: Material.Primary
                        }
                        Text { text: "     E  Stop     "; font.bold: true; color: 'white';anchors.left: parent.left}
                    }
                    RowLayout {
                        spacing: 80
                        Layout.alignment: Qt.AlignHCenter
                        StatusIndicator {
                            anchors.right: parent.right
                            color: Material.Primary
                        }
                        Text { text: "Blue Button"; font.bold: true; color: 'white';anchors.left: parent.left}
                    }
                }
                ColumnLayout {
                    spacing: 20
                    Rectangle { color: "transparent"; border.color: 'white'; radius: 6;width: parent.width; height: parent.height}
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    Text { text: "Connection"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                    RowLayout {
                        spacing: 80
                        Button {
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            text: "Connect"
                            highlighted: true
                            Material.accent: Material.primary
                        }
                        StatusIndicator {
                            anchors.right: parent.right
                            color: "green"
                            active: true
                        }
                    }
                    RowLayout {
                        spacing: 80
                        Button {
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            text: "Get Version"
                            highlighted: true
                            Material.accent: Material.primary
                        }
                        Text {
                            text: "Version";
                            font.bold: true;
                            color: 'white';
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                        }
                    }

                    RowLayout {
                        spacing: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Autorun Test"
                            highlighted: true
                            Material.accent: Material.primary
                        }

                    }
                    RowLayout {
                        spacing: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Reboot"
                            highlighted: true
                            Material.accent: Material.primary
                        }
                    }
                }
            }
            RowLayout {
                spacing: 80
                anchors.bottomMargin: 250
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    Layout.preferredWidth: 900
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    placeholderText: qsTr("Enter SSH Command")
                }
                Button {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    id: sshbutton
                    text: "Execute Command"
                    highlighted: true
                    Material.accent: Material.primary
                }
            }
        }
        Item {
                id: lbcmTab
                GridLayout {
                    width: 1200
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 100
                    columns: 3
                    ColumnLayout {
                        spacing: 10
                        Rectangle { color: "transparent"; border.color: 'white'; radius: 6;width: parent.width; height: parent.height}
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text { text: "Debug Commands"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Text { text: " "}
                            Button {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Download Log"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            Text { text: " "}
                        }
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Text { text: " "}
                            Button {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Query Configuration"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            Text { text: " "}
                        }
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Text { text: " "}
                            Button {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Upgrade Version"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            Text { text: " "}
                        }
                        RowLayout {
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text {
                                color: 'white'
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: 'Set Partition'
                            }
                        }
                        RowLayout {
                            spacing: 80
                            Button {
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: 'Partition A'
                            }
                            Button {
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: 'Partition B'
                            }
                        }
                    }
                    ColumnLayout {
                        spacing: 18
                        Rectangle { color: "transparent"; border.color: 'white'; radius: 6;width: parent.width; height: parent.height}
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text { text: "Tests"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Text { text: " "}
                            Button {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Run Tx Test"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            Text { text: " "}
                        }
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Text { text: " "}
                            Button {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Display Test"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            Text { text: " "}
                        }
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Button {
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: "Ping Lidar"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            StatusIndicator {
                                anchors.right: parent.right
                                color: "green"
                                active: true
                            }
                        }
                        RowLayout {
                            spacing: 80
                            Layout.alignment: Qt.AlignHCenter
                            Button {
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: "Ping Camera"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            StatusIndicator {
                                anchors.right: parent.right
                                color: "green"
                                active: true
                            }
                        }
                    }
                    ColumnLayout {
                        spacing: 10
                        Rectangle { color: "transparent"; border.color: 'white'; radius: 6;width: parent.width; height: parent.height}
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        Text { text: "Connection"; font.bold: true; color: 'white';Layout.alignment: Qt.AlignHCenter}
                        RowLayout {
                            spacing: 80
                            Button {
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: "Connect"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            StatusIndicator {
                                anchors.right: parent.right
                                color: "green"
                                active: true
                            }
                        }
                        RowLayout {
                            spacing: 80
                            anchors.horizontalCenter: parent.horizontalCenter
                            Button {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Get Info"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                       }
                        RowLayout {
                            spacing: 80
                            Text {
                                color: 'white'
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: 'Provisioning Status:'
                            }
                            Text {
                                color: 'white'
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: '  '
                            }

                        }
                        RowLayout {
                            spacing: 80
                            Text {
                                color: 'white'
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: 'Version:'
                            }
                            Text {
                                color: 'white'
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: '  '
                            }
                        }
                        RowLayout {
                            spacing: 80
                            Text {
                                color: 'white'
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                text: 'App:'
                            }
                            Text {
                                color: 'white'
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: '  '
                            }
                        }
                        RowLayout {
                            spacing: 80
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text { text: " "}
                            Button {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Reboot"
                                highlighted: true
                                Material.accent: Material.primary
                            }
                            Text { text: " "}
                            Text { text: " "}
                        }
                     }
                }
            RowLayout {
                spacing: 80
                anchors.bottomMargin: 250
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                TextField {
                    Layout.preferredWidth: 900
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    placeholderText: qsTr("Enter SSH Command")
                }
                Button {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    text: "Execute Command"
                    highlighted: true
                    Material.accent: Material.primary
                }
            }
        }
    }

    RowLayout {
        id: logger
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 40
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.bottomMargin: 5

        ColumnLayout {
            Layout.preferredWidth: parent.width
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: title
                Layout.alignment: Qt.AlignHCenter
                color: 'white'
                Material.accent: Material.DeepOrange
                font.pointSize: 16
                text: "Logging"
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width
            }


            ScrollView {
                id: view
                Layout.preferredHeight: 200
                Layout.preferredWidth: parent.width
                anchors.margins: 100
                background: Rectangle { color: "transparent"; border.color: 'white'; radius: 6}

                TextArea {
                    background: null
                    readOnly: true
                    selectByMouse: true
                    text: "TextArea\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n\n...\n...\n...\n...\n...\n...\n"
                }
             }
        }
    }
}