# -*- coding: utf-8 -*-
"""
/***************************************************************************
 Aquabase
                                 A QGIS plugin
 Aquabase plugins
                             -------------------
        begin                : 2016-08-09
        copyright            : (C) 2018 by Immo Blecher
        email                : immo@blecher.co.za
        git sha              : $Format:%H$
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 This script initializes the plugin, making it known to QGIS.
"""


# noinspection PyPep8Naming
def classFactory(iface):  # pylint: disable=invalid-name
    """Load Aquabase class from file Aquabase.

    :param iface: A QGIS interface instance.
    :type iface: QgsInterface
    """
    #
    from .aquabase import Aquabase
    return Aquabase(iface)
