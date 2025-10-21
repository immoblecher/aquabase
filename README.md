# aquabase
**Aquabase** Water Resources Management Software - developed with Lazarus/FreePascal IDE

Aquabase is a powerful water resources management software application with data entry, management and presentation tools for the (ground)water scientist, water manager and engineer. The latest version is Aquabase Twenty20 (8.x.x.x), which is available for Windows 32 and 64 bit and Linux (Debian/Ubuntu). A MacOS version is planned to be available by the end of the year.

The current version is in no way complete and development continues, as there is quite a bit of work still necessary to rewrite the reports and charting functions from old (Aquabase Ver. 6) functionality. Aquabase is developed with the Lazarus / FreePascal IDE under Ubuntu Linux and uses only open-source components, i.e. for the database access (ZeosDBO), the reports (Fortesreport CE) and some enhanced controls (rxnew) with more user-friendly functions. The Windows 32 bit and 64 bit versions are then compiled with Lazarus / FreePascal and tested under Wine before distribution (Aquabase runs perfectly under Wine).

Aquabase supports the following popular databases: SQLite/Spatialite (flat-file based, on local computer or file server), MySQL, MariaDB, PostgreSQL with PostGIS and MS SQLServer (all database-server based). Only the latest versions of MS SQLServer (for Windows and Linux) with spatial functions are supported, but due to typical constant updates and changes by Microsoft some adaptations may be necessary in the Aquabase code, which can be accommodated.

More info on Aquabase and downloads: https://aquabase.blecher.co.za/wp/

What is needed to compile? 

* Lazarus/FreePascal IDE https://www.lazarus-ide.org/
* The ZeosDBO database components https://sourceforge.net/projects/zeoslib/
* For creating the reports FortesReportCE http://fortes4lazarus.sourceforge.net/
* The rxnew components for additional functionality https://wiki.lazarus.freepascal.org/RXfpc
* The simple mapping component LazMapViewer https://wiki.lazarus.freepascal.org/LazMapViewer
* For photo EXIF functionality the DExif component https://github.com/cutec-chris/dexif
* For spreadsheet functionalities the FPSpreadsheet components https://sourceforge.net/projects/lazarus-ccr/files/FPSpreadsheet/OPM/update_FPSpreadsheet.json/download
* Synapse for online (ftp) functions for Aquabase update download http://www.ararat.cz/synapse/doku.php/start

The additional requirements on top of Lazarus/FreePascal above should be installed/updated through the Online Package Manager in Lazarus. If you want to cross-compile under Windows you need to install the cross-compile packages for Lazarus as well.

Aquabase needs a lot of additional libraries (.dll, .o etc.) to run. Most of these are distributed with Aquabase: The Inno Setup https://jrsoftware.org/isinfo.php files to create Windows installations are under the .../install directory. So it might be a good idea to install Aquabase from the website and have a look at the "\Program Files\Aquabase 2020" directory for the required files to be distributed with Aquabase.

Under Linux use Debreate or any other for Debian based installations and make sure that required libraries are installed (minimum proj/mod_spatialite and sqlite). For access to other databases make sure to install the relevant client libraries.

The /po_files directory contains some translations for German already. These are only in the starting phase and need a lot of work so that Aquabase can be distributed in other languages. Another important language file is the en_za.sqlite (for South Africa), which contains South Africa specific tables for codes, standards etc. This should then be adapted for other countries; e.g. de_de.sqlite for Germany etc.
