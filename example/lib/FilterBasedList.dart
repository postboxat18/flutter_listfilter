import 'package:flutter/material.dart';
import 'package:flutter_listfilter/flutter_listfilter.dart';

class FilterBasedList extends StatefulWidget {
  const FilterBasedList({super.key});

  @override
  State<FilterBasedList> createState() => _FilterBasedListState();
}

class _FilterBasedListState extends State<FilterBasedList> {
  late List<String> filterHeaderList = [
    "fields",
    "doc",
    "createDate",
    "updateDate",
    "updatedBy"
  ];
  late List<TextList> textList = [
    TextList("TextFields", "dummy.pdf", "12/02/2025", "06/09/2001", "Naruto"),
    TextList("Button", "sample.pdf", "02/05/2015", "16/05/2015", "Ichigo"),
    TextList("Container", "original.pdf", "06/08/2027", "16/05/2015", "Goku"),
    TextList("Scaffold", "original.pdf", "04/09/2000", "06/09/2001", "Naruto"),
    TextList("Wrap", "report.pdf", "04/09/2000", "14/04/204", "Goku"),
    TextList("Row", "sample.pdf", "02/05/2015", "25/06/2029", "Goku"),
    TextList("Column", "report.pdf", "12/02/2045", "14/04/204", "Naruto"),
    TextList("Scaffold", "sample.pdf", "12/02/2025", "06/09/2001", "Ichigo"),
    TextList("Container", "report.pdf", "12/02/2025", "22/07/2018", "Naruto"),
    TextList("Scaffold", "sample.pdf", "04/09/2000", "25/06/2029", "Goku"),
    TextList("Row", "sample.pdf", "02/05/2015", "22/07/2018", "Luffy"),
    TextList("Column", "original.pdf", "12/02/2012", "14/04/204", "Ichigo"),
    TextList("Container", "original.pdf", "25/07/2018", "25/06/2029", "Luffy"),
    TextList("Button", "dummy.pdf", "12/02/2012", "22/07/2018", "Jon"),
    TextList("Row", "report.pdf", "25/07/2018", "14/04/204", "Luffy"),
    TextList("Wrap", "original.pdf", "12/02/2012", "14/04/204", "Ichigo"),
    TextList("Row", "sample.pdf", "07/01/2011", "22/07/2018", "Luffy"),
    TextList("Button", "report.pdf", "07/01/2011", "16/05/2015", "Ichigo"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("FilterBasedList"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CHIP
            FlutterListFilter(
              isRadio: false,
              primaryColor: Colors.blue,
              lineColor: Color(0xFFA9B5BB),
              textList: textList,
              extraChipWidgets: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(55),
                      )),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "2012/02/20-2025/02/20",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.black,
                      ),
                    ],
                  )),
              filterHeaderList: filterHeaderList,
              builder: (List<dynamic> textLoadList) {
                print("filterBasedList=>outSide=>${textLoadList.length}");
                return Expanded(
                    child: textLoadList.isEmpty
                        ? Center(
                            child: Text("Empty Data"),
                          )
                        : ListView.builder(
                            itemCount: textLoadList.length,
                            itemBuilder: (context, index) => Card(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.lightBlueAccent),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 2, 0, 0),
                                            child: Text(
                                              textLoadList[index].updatedBy[0],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          textLoadList[index].fields,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 2, 5),
                                          child: Icon(
                                            Icons.edit_document,
                                            color: Colors.grey,
                                            size: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 5, 5),
                                          child: Text(textLoadList[index].doc),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(textLoadList[index].createDate),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              textLoadList[index].updateDate),
                                        ),
                                        Text(textLoadList[index].updatedBy),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
