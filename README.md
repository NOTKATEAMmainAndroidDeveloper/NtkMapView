Crossplatform Flutter map widget, powered with Leaflet(that used OSM)

>> **This package in early development**
> 
>> *Insert the user's personal data at your own risk, as on the WEB version this may lead to data theft. Be cautious when using such data and do so at your own risk. We are not responsible for data loss.*

## Usage map

If you need only a blank map create a widget
```dart
NtkMapViewInterface();
```
<br/>

You may a configure Html file you used to map
```dart
NtkMapViewInterface(
  mapPath: 'assets/map.html'
);
```

<br/>

If you need to full control with map, then you need to create a map controller in you initState()
<br/>
Param is viewId, you may set null if you dont need customize it
```dart
  NtkMapControllerInterface ntkMapController = NtkMapControllerInterface.init(null);
```

Then add you controller to you map widget
```dart
NtkMapViewInterface(
  mapPath: 'assets/map.html',
  mapController: ntkMapController,
);
```
<br/>
Also you may configure callbacks for map

## Map callbacks
You may get callback on map create start
```dart
NtkMapViewInterface(
  onCreateStart: (){

  },
);
```
<br/>
You may get callback on map create end, this callback return used controller

```dart
NtkMapViewInterface(
  onCreateEnd: (controller){
    
  },
);
```

<br/>
You may get callback on user tap on map, this callback returned a point on map (LatLng)

```dart
NtkMapViewInterface(
  onMapClick: (point) async {
    
  },
);
```

## Work with controller
for now moment controller have a next method:
<br/><br/>**addMarker(LatLng point, Function(LatLng point)? callback)**
   <br/>add a marker on the map and returned callback when you clicked on it
<br/><br/>**goToPoint(LatLng point)**
   <br/>move center camera on point(like panTo in leaflet)
<br/><br/>**goToPointThenZoom(LatLng point, double zoom)**
   <br/>move camera and zoom to point(like flyTo in leaflet)
<br/><br/>**addPolyline(List points)**
   <br/>create polyline on List of points(also clear all previous polyline)
<br/><br/>**addCustomMarker(LatLng point, String title, List<String> names, List<Function> acts)**
   <br/>create marker on point with title, in this marker you may configure a button and its callback
```dart
ntkMapController.addCustomMarker(
  latLng, addressName,
  ["from",  "to"],
  [(){
    this "from" callback
  },
  (){
    this "to" callback
  },
])
```

## Map filter
> **For now works only on web!**

Use in you controller method
**applyNewFilter(MapFilter filter);**
<br/><br/>
MapFilter fields (*above a default value*):
```dart
  int blur = 0;
  double invert = 0;
  double grayscale = 0;
  double bright = 1;
  double contrast = 1;
  int hue = 0;
  double opacity = 1;
  double saturate = 1;
  double sepia = 0;
```

## In future
In next version we may add:
1. Add a method to chose a tile url
2. Separate method to clear polyline
3. Create a method to clear markers
4. Create filter method for mobile

## Additional information

I'm not very good at English, but I hope the provided description will help you understand how to use the plugin