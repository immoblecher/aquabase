# -*- coding: utf-8 -*-
"""
/***************************************************************************
 Aquabase
                                 A QGIS plugin
 Aquabase plugins
                              -------------------
        begin                : 2016-08-09
        git sha              : $Format:%H$
        copyright            : (C) 2022 by Immo Blecher
        email                : immo@blecher.co.za
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
"""
from PyQt5.QtCore import *
from PyQt5.QtGui import QIcon, QCursor
from PyQt5.QtWidgets import QAction, QDialogButtonBox, QApplication, QMessageBox
# Initialize Qt resources from file resources.py
from .resources import *
# Import the code for the dialog
from .aquabase_dialog import AquabaseDialog
import os.path
from qgis.core import *


class Aquabase:
    """QGIS Plugin Implementation."""

    def __init__(self, iface):
        """Constructor.

        :param iface: An interface instance that will be passed to this class
            which provides the hook by which you can manipulate the QGIS
            application at run time.
        :type iface: QgsInterface
        """
        # Save reference to the QGIS interface
        self.iface = iface
        # initialize plugin directory
        self.plugin_dir = os.path.dirname(__file__)
        # initialize locale
        locale = QSettings().value('locale/userLocale')[0:2]
        locale_path = os.path.join(
            self.plugin_dir,
            'i18n',
            'Aquabase_{}.qm'.format(locale))

        if os.path.exists(locale_path):
            self.translator = QTranslator()
            self.translator.load(locale_path)

            if qVersion() > '4.3.3':
                QCoreApplication.installTranslator(self.translator)

        # Create the dialog (after translation) and keep reference
        self.dlg = AquabaseDialog()

        # Declare instance attributes
        self.actions = []
        self.menu = self.tr(u'&Aquabase')
        # TODO: We are going to let the user set this up in a future iteration
        self.toolbar = self.iface.addToolBar(u'Aquabase')
        self.toolbar.setObjectName(u'Aquabase')

    # noinspection PyMethodMayBeStatic
    def tr(self, message):
        """Get the translation for a string using Qt translation API.

        We implement this ourselves since we do not inherit QObject.

        :param message: String for translation.
        :type message: str, QString

        :returns: Translated version of message.
        :rtype: QString
        """
        # noinspection PyTypeChecker,PyArgumentList,PyCallByClass
        return QCoreApplication.translate('Aquabase', message)

    def add_action(
        self,
        icon_path,
        text,
        callback,
        enabled_flag=True,
        add_to_menu=True,
        add_to_toolbar=True,
        status_tip=None,
        whats_this=None,
        parent=None):
        """Add a toolbar icon to the toolbar.

        :param icon_path: Path to the icon for this action. Can be a resource
            path (e.g. ':/plugins/foo/bar.png') or a normal file system path.
        :type icon_path: str

        :param text: Text that should be shown in menu items for this action.
        :type text: str

        :param callback: Function to be called when the action is triggered.
        :type callback: function

        :param enabled_flag: A flag indicating if the action should be enabled
            by default. Defaults to True.
        :type enabled_flag: bool

        :param add_to_menu: Flag indicating whether the action should also
            be added to the menu. Defaults to True.
        :type add_to_menu: bool

        :param add_to_toolbar: Flag indicating whether the action should also
            be added to the toolbar. Defaults to True.
        :type add_to_toolbar: bool

        :param status_tip: Optional text to show in a popup when mouse pointer
            hovers over the action.
        :type status_tip: str

        :param parent: Parent widget for the new action. Defaults None.
        :type parent: QWidget

        :param whats_this: Optional text to show in the status bar when the
            mouse pointer hovers over the action.

        :returns: The action that was created. Note that the action is also
            added to self.actions list.
        :rtype: QAction
        """

        icon = QIcon(icon_path)
        action = QAction(icon, text, parent)
        action.triggered.connect(callback)
        action.setEnabled(enabled_flag)

        if status_tip is not None:
            action.setStatusTip(status_tip)

        if whats_this is not None:
            action.setWhatsThis(whats_this)

        if add_to_toolbar:
            self.toolbar.addAction(action)

        if add_to_menu:
            self.iface.addPluginToDatabaseMenu(
                self.menu,
                action)

        self.actions.append(action)

        return action

    def initGui(self):
        """Create the menu entries and toolbar icons inside the QGIS GUI."""

        icon_path = ':/plugins/Aquabase/createview.png'
        self.add_action(
            icon_path,
            text=self.tr(u'Create view from selection'),
            callback=self.run,
            parent=self.iface.mainWindow())

        icon_path = ':/plugins/Aquabase/registersite.png'
        self.add_action(
            icon_path,
            text=self.tr(u'Register selected site'),
            callback=self.registersite,
            parent=self.iface.mainWindow())

        icon_path = ':/plugins/Aquabase/mapselect.png'
        self.add_action(
            icon_path,
            text=self.tr(u'Mark and go to selected site'),
            callback=self.gotosite,
            parent=self.iface.mainWindow())

    def unload(self):
        """Removes the plugin menu item and icon from QGIS GUI."""
        for action in self.actions:
            self.iface.removePluginDatabaseMenu(
                self.tr(u'&Aquabase'),
                action)
            self.iface.removeToolBarIcon(action)
        # remove the toolbar
        del self.toolbar

    def run(self):
        """Run method that performs all the real work"""
        # show the dialog
        self.dlg.show()
        # Run the dialog event loop to create the qgis_selection
        result = self.dlg.exec_()
        # See if OK was pressed
        if result:
            # Do something useful here - delete the line containing pass and
            # substitute with your code.
            layer = self.iface.activeLayer()
            caps = layer.dataProvider().capabilities()
            # check if active layer = basicinf
            field = 'QUADRANT' 
            index = layer.dataProvider().fieldNameIndex(field)
            if index > 0 and caps & QgsVectorDataProvider.ChangeAttributeValues:
                selection = layer.selectedFeatures()
                if len(selection) > 0:
                    cursor = QCursor()
                    cursor.setShape(Qt.WaitCursor)
                    QApplication.instance().setOverrideCursor(cursor)
                    layer.startEditing()
                    request = QgsFeatureRequest().setFilterExpression('QUADRANT = ''9''')
                    for feature in layer.getFeatures(request):
                        attrs = feature.attributes()
                        if attrs[index] == '9':   
                            layer.changeAttributeValue(feature.id(), index, '1')
                    for feature in selection:
                        layer.changeAttributeValue(feature.id(), index, '9')
                    layer.commitChanges()
                    QApplication.instance().restoreOverrideCursor()
                    self.iface.messageBar().pushMessage("Aquabase View updated", "The layer from the Basicinf table has been updated for the View!", level=Qgis.Success, duration=5)
                else: 
                    self.iface.messageBar().pushMessage("Selection Warning", "Nothing is selected in the layer from the Basicinf table!", level=Qgis.Warning, duration=5)
            else:
                self.iface.messageBar().pushMessage("Aquabase View Error", "The layer from the Basicinf table must be active and editable for this to work!", level=Qgis.Critical, duration=10)

    def registersite(self):
        layer = self.iface.activeLayer()
        caps = layer.dataProvider().capabilities()
        selection = []
        # check if active layer = basicinf
        field = 'QUADRANT' 
        index = layer.dataProvider().fieldNameIndex(field)
        if index > 0 and caps & QgsVectorDataProvider.ChangeAttributeValues:
            selection = layer.selectedFeatures()
            if len(selection) == 0:
                self.iface.messageBar().pushMessage("Selection Warning", "No site selected in the layer from the Basicinf table!", level=Qgis.Warning, duration=5)
            else:
                if len(selection) == 1:
                    cursor = QCursor()
                    cursor.setShape(Qt.WaitCursor)
                    QApplication.instance().setOverrideCursor(cursor)
                    layer.startEditing()
                    for feature in layer.getFeatures():
                        attrs = feature.attributes()
                        if attrs[index] == '8':   
                            layer.changeAttributeValue(feature.id(), index, '1')
                    for feature in selection:
                        layer.changeAttributeValue(feature.id(), index, '8')
                    layer.commitChanges()
                    QApplication.instance().restoreOverrideCursor()
                    self.iface.messageBar().pushMessage("Selection registered", "The selected site has been registered for Aquabase.", level=Qgis.Success, duration=5)
                else: 
                    self.iface.messageBar().pushMessage("Selection Warning", "Only one site can be selected in the layer from the Basicinf table!", level=Qgis.Warning, duration=5)
        else:
            self.iface.messageBar().pushMessage("Selection Error", "The layer from the Basicinf table must be active and editable for this to work!", level=Qgis.Critical, duration=10)

    def gotosite(self):
        # layers = QgsMapLayerRegistry.instance()
        layers = self.iface.mapCanvas().layers()
        field = 'QUADRANT'
        layerFound = 0;
        selectionFound = 0;
        # for lyr in layers.mapLayers().values():
        for lyr in layers:
            layer = lyr;
            layerType = layer.type()
            if layerType == QgsMapLayer.VectorLayer:
                index = layer.dataProvider().fieldNameIndex(field)
                if index > 0:
                    cursor = QCursor()
                    cursor.setShape(Qt.WaitCursor)
                    QApplication.instance().setOverrideCursor(cursor)
                    layerFound = layerFound + 1
                    self.iface.setActiveLayer(layer)
                    for feature in layer.getFeatures():
                        quadrant = feature.attribute("QUADRANT")
                        if quadrant == '7':
                            selectionFound = 1;
                            layer.removeSelection()
                            layer.select(feature.id())
                            canvas = self.iface.mapCanvas()
                            canvas.zoomToSelected(layer)
                            canvas.zoomScale(50000)
                    QApplication.instance().restoreOverrideCursor()
                    if selectionFound == 0: 
                        self.iface.messageBar().pushMessage("Selection Error", "No selected site from Aquabase was found in layer " + layer.name() + " from Basicinf!", level=Qgis.Critical, duration=10)
        if layerFound == 0:
            self.iface.messageBar().pushMessage("Selection Error", "At least one layer from the Basicinf table must be open for this to work!", level=Qgis.Warning, duration=5)
