
# Flutter Filter Based on List

## Contents

This package provides a Flutter widget for filtering based on a list of parameters. It includes:

- **Auto-suggestions:** Dynamically loads filter options based on the provided list.
- **Easy Integration:** Seamlessly integrate the filter widget into your Flutter application.
- **Customization:** Customize the primary color, line color, and other visual aspects to match your app's design.
- **Efficient Filtering:** Quickly filter through options to find the desired selection.

Before using packages, please add the following `toJson` method to your `Module` class for getting key parameters and values:

```dart
class TextList {
  final String fields;
  final String doc;
  final String createDate;
  final String updateDate;
  final String updatedBy;

  TextList(
      this.fields, this.doc, this.createDate, this.updateDate, this.updatedBy);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fields'] = fields;
    data['doc'] = doc;
    data['createDate'] = createDate;
    data['updateDate'] = updateDate;
    data['updatedBy'] = updatedBy;
    return data;
  }

  dynamic get(String key) {
    var mapRep = toJson();
    if (mapRep.containsKey(key)) {
      return mapRep[key];
    }
    //throw ArgumentError('filter=>getTaskTableList=>key not found=>$key');
  }
}
```

## Example

You can also use your widget, or else it is not necessary to pass the widget:

```dart
FlutterListFilter(
  isRadio: true,
  primaryColor: Colors.blue,
  lineColor: Color(0xFFA9B5BB),
  extraChipWidgets://your widgets
  textList: textList,
  filterHeaderList: filterHeaderList,
  builder: (List<dynamic> textLoadList) {
    // Your code here
  },
),
```

If you prefer using radio buttons:

```dart
FlutterListFilter(
  isRadio: true,
  primaryColor: Colors.blue,
  lineColor: Color(0xFFA9B5BB),
  textList: textList,
  filterHeaderList: filterHeaderList,
  builder: (List<dynamic> textLoadList) {
    // Your code here
  },
),
```

If you prefer using checkboxes:

```dart
FlutterListFilter(
  isRadio: false,
  primaryColor: Colors.blue,
  lineColor: Color(0xFFA9B5BB),
  textList: textList,
  filterHeaderList: filterHeaderList,
  builder: (List<dynamic> textLoadList) {
    // Your code here
  },
),
```
![Screencastfrom25-03-24102346AMIST-ezgif com-video-to-gif-converter](https://github.com/postboxat18/flutter_listfilter/assets/77087523/0c11b544-bd28-455f-ae16-51e83bfac38c)
![Screencastfrom25-03-24102451AMIST-ezgif com-video-to-gif-converter](https://github.com/postboxat18/flutter_listfilter/assets/77087523/576e63fd-e560-4ac0-8a20-7c00d4f04fe1)

```
