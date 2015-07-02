import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0
import org.ethereum.qml.QEther 1.0
import "js/Debugger.js" as Debugger
import "js/ErrorLocationFormater.js" as ErrorLocationFormater
import "js/TransactionHelper.js" as TransactionHelper
import "js/QEtherHelper.js" as QEtherHelper
import "."

ColumnLayout {
	id: root
	property alias title: titleLabel.text
	property variant _data
	property string role
	property alias model: modelKeyValue

	function clear()
	{
		modelKeyValue.clear()
	}

	function init()
	{
		modelKeyValue.clear()
		if (typeof(computeData) !== "undefined" && computeData instanceof Function)
			computeData()
		else
		{
			console.log("--------------")
			console.log(JSON.stringify(_data))
			console.log(role)
			if (_data !== undefined && _data[role] !== undefined)
			{
				var keys = Object.keys(_data[role])
				for (var k in keys)
				{
					modelKeyValue.append({ "key": keys[k] === "" ? "undefined" : keys[k], "value": _data[role][keys[k]] })
				}
			}
		}
	}

	RowLayout
	{
		Layout.preferredHeight: 20
		Layout.fillWidth: true
		Label
		{
			id: titleLabel
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			color: "white"
		}
	}

	RowLayout
	{
		Layout.fillWidth: true
		Layout.preferredHeight: 100
		ListModel
		{
			id: modelKeyValue
		}

		Rectangle
		{
			Layout.fillWidth: true
			Layout.fillHeight: true
			color: "white"
			radius: 2
			ScrollView
			{
				id: columnValues
				horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
				anchors.fill: parent
				ColumnLayout
				{
					anchors.margins: 10
					Repeater
					{
						id: repeaterKeyValue
						model: modelKeyValue
						RowLayout
						{
							Layout.fillWidth: true
							Layout.preferredHeight: 30
							spacing: 0
							Rectangle
							{
								Layout.preferredWidth: columnValues.width / 2
								Label
								{
									anchors.left: parent.left
									anchors.leftMargin: 10
									text: {
										if (index >=  0)
											return repeaterKeyValue.model.get(index).key
										else
											return ""
									}
								}
							}

							Rectangle
							{
								Layout.preferredWidth: columnValues.width / 2 - 10
								Label
								{
									anchors.right: parent.right
									anchors.rightMargin: 10
									text: {
										if (index >= 0)
											return repeaterKeyValue.model.get(index).value
										else
											return ""
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
