for i in *.tif
do
  if [ -f rastry.gpkg ]; then
    echo "Geopackage istnieje, przetwarzamy kolejny ze stosu: $i"
    gdal_translate -of GPKG $i rastry.gpkg -co APPEND_SUBDATASET=YES -co RASTER_TABLE=$i
  else	
    echo "Geopackage nie istnieje. Przetwarzamy $i"
    gdal_translate -of GPKG $i rastry.gpkg -co RASTER_TABLE=$i
  fi  
done;
echo "Piramidy"
gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -r AVERAGE rastry.gpkg 2 4
