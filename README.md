
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

![Example 1](https://github.com/postboxat18/flutter_listfilter/assets/77087523/3691893e-dce8-4e22-bf05-ebeec7154729)
![Example 2](https://github.com/postboxat18/flutter_listfilter/assets/77087523/97fdd634-1aac-416e-8bdd-a270717924be)
```

Ensure that you replace `textList` and `filterHeaderList` with your own data lists. In the `builder` function, you can implement your logic based on the selected filter options. Don't forget to adjust the image URLs to point to your actual images.
