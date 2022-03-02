# aquabase
**Aquabase** Water Resources Management Software - developed with Lazarus/FreePascal IDE

Aquabase is a powerful water resources management software application with data entry, management and presentation tools for the (ground)water scientist, water manager and engineer. The latest version is Aquabase Twenty20 (8.x.x.x), which is available for Windows 32 and 64 bit and Linux (Debian/Ubuntu). A MacOS version is planned to be available by the end of the year.

The current version is in no way complete and development continues, as there is quite a bit of work still necessary to rewrite the reports and charting functions from old (Aquabase Ver. 6) functionality. Aquabase is developed with the Lazarus / FreePascal IDE under Ubuntu Linux and uses only open-source components, i.e. for the database access (ZeosDBO), the reports (Fortesreport CE) and some enhanced controls (rxnew) with more user-friendly functions. The Windows 32 bit and 64 bit versions are then compiled with Lazarus / FreePascal and tested under Wine before distribution (Aquabase runs perfectly under Wine).

Aquabase supports the following popular databases: SQLite/Spatialite (flat-file based, on local computer or file server), MySQL, MariaDB, PostgreSQL with PostGIS and MS SQLServer (all database-server based). Only the latest versions of MS SQLServer (for Windows and Linux) with spatial functions are supported, but due to typical constant updates and changes by Microsoft some adaptations may be necessary in the Aquabase code, which can be accommodated, if you are interested in using Aquabase with SQLServer.

More info on Aquabase and downloads: https://aquabase.blecher.co.za/wp/

What is needed to compile? 

* Lazarus/FreePascal IDE https://www.lazarus-ide.org/
* 
