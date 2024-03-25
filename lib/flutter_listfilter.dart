library flutter_listfilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/flutter_list_filter_bloc.dart';

class FlutterListFilter extends StatefulWidget {
  final List<dynamic> textList;
  final List<String> filterHeaderList;
  final dynamic builder;
  final Color primaryColor;
  final Color lineColor;
  final bool isRadio;
  final Widget extraChipWidgets;

  const FlutterListFilter({
    super.key,
    required this.textList,
    required this.filterHeaderList,
    this.isRadio = true,
    required this.primaryColor,
    required this.lineColor,
    required this.builder,
    this.extraChipWidgets = const Row(
      children: [],
    ),
  });

  @override
  State<FlutterListFilter> createState() => _FlutterListFilterState();
}

class _FlutterListFilterState extends State<FlutterListFilter> {
  late FlutterListFilterBloc flutterListFilterBloc = FlutterListFilterBloc();

  @override
  void initState() {
    flutterListFilterBloc.add(FilterLoadEvent({}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: flutterListFilterBloc,
        builder: (context, filterState) {
          if (filterState is FilterLoadState) {
            List<dynamic> textLoadList = [];
            textLoadList = widget.textList;
            if (filterState.map.isNotEmpty) {
              textLoadList = widget.textList;
              bool isTrue = false;
              for (var key in filterState.map.entries) {
                if (filterState.map[key.key] != null) {
                  List<String> list = filterState.map[key.key];
                  textLoadList = textLoadList
                      .where((element) =>
                          list.any((e) => element.get(key.key) == e))
                      .toList();
                }
              }

              if (!widget.isRadio && textLoadList.isEmpty) {
                for (var key in filterState.map.entries) {
                  if (filterState.map[key.key] != null) {
                    List<String> list = filterState.map[key.key];
                    isTrue = list.any((element) => element == "");
                  }
                  if (!isTrue) {
                    break;
                  }
                }
                print("filterBasedList=>load=?$isTrue");
                if (isTrue) {
                  flutterListFilterBloc.add(FilterLoadEvent({}));
                }
              }
            }
            print("filterBasedList=>inside=>${textLoadList.length}");

            return Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //FILTER WIG
                ChipState(
                    widget.textList, widget.filterHeaderList, filterState),
                widget.builder(textLoadList)
              ],
            ));
          } else {
            return Container();
          }
        });
  }

  ChipState(List<dynamic> textList, List<String> filterHeaderList,
      FilterLoadState filterState) {
    Map<dynamic, dynamic> map = {};
    List<dynamic> uniqueList = [];
    var set = Set<String>();
    for (var value in filterHeaderList) {
      uniqueList =
          textList.where((element) => set.add(element.get(value))).toList();

      map.addAll({value: uniqueList});
    }
    return Row(
      children: [
        //CLEAR
        if (filterState.map.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextButton(
              onPressed: () {
                flutterListFilterBloc.add(FilterLoadEvent({}));
              },
              child: (filterState.map.length) > 1
                  ? Text("Clear All",
                      style: TextStyle(
                        color: widget.primaryColor,
                      ))
                  : Text("Clear",
                      style: TextStyle(
                        color: widget.primaryColor,
                      )),
            ),
          ),
        ],

        //FILTER
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              //USER FILTER
              widget.extraChipWidgets,
              //DYNAMIC FILTERS
              for (var key in map.entries) ...[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            isDismissible: widget.isRadio,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            builder: (BuildContext context) =>
                                openBottomSheet(key, map));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: filterState.map[key.key] != null
                                    ? widget.primaryColor
                                    : widget.lineColor),
                            borderRadius: BorderRadius.circular(55),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            key.key,
                            style: TextStyle(
                              color: filterState.map[key.key] != null
                                  ? widget.primaryColor
                                  : Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: filterState.map[key.key] != null
                                ? widget.primaryColor
                                : Colors.black,
                          ),
                        ],
                      )),
                )
              ]
            ],
          ),
        )),
      ],
    );
  }

  openBottomSheet(MapEntry key, Map map) {
    return BlocBuilder(
      bloc: flutterListFilterBloc,
      builder: (context, filterState) {
        if (filterState is FilterLoadState) {
          List<String> selectValue = [];
          List<dynamic> list = map[key.key];
          if (filterState.map[key.key] != null) {
            selectValue = filterState.map[key.key];
          } else {
            for (int i = 0; i < list.length; i++) {
              selectValue.add("");
            }
          }

          return Stack(children: [
            //LINE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: widget.lineColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //SORT BY
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
                            child: Text(
                              "Sort By ${key.key}",
                              style: TextStyle(color: widget.lineColor),
                            ),
                          ),
                          Wrap(
                            children: [
                              //APPLY
                              if (!widget.isRadio) ...[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Apply",
                                      style: TextStyle(
                                        color: widget.primaryColor,
                                      )),
                                ),
                              ],
                              //CLEAR
                              TextButton(
                                onPressed: () {
                                  Map<dynamic, dynamic> map = filterState.map;
                                  map.remove(key.key);
                                  flutterListFilterBloc
                                      .add(FilterLoadEvent(map));
                                  Navigator.pop(context);
                                },
                                child: const Text("Clear",
                                    style: TextStyle(
                                      color: Colors.red,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                      //LINE
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < list.length; i++) ...[
                            if (widget.isRadio) ...[
                              RadioListTile(
                                activeColor: widget.primaryColor,
                                value: list[i].get(key.key),
                                groupValue: selectValue[i],
                                onChanged: (value) {
                                  Map<dynamic, dynamic> map = filterState.map;
                                  if (filterState.map[key.key] != null) {
                                    List<dynamic> list = map[key.key];
                                    for (int k = 0; k < list.length; k++) {
                                      if (i == k) {
                                        selectValue[i] = value;
                                      } else {
                                        selectValue[k] = "";
                                      }
                                    }
                                  } else {
                                    selectValue[i] = value;
                                  }
                                  map.addAll({key.key: selectValue});
                                  flutterListFilterBloc
                                      .add(FilterLoadEvent(map));
                                  Navigator.pop(context);
                                },
                                title: Text(list[i].get(key.key)),
                              )
                            ] else ...[
                              CheckboxListTile(
                                activeColor: widget.primaryColor,
                                value: selectValue[i] == list[i].get(key.key),
                                onChanged: (value) {
                                  Map<dynamic, dynamic> map = filterState.map;
                                  if (value == true) {
                                    selectValue[i] = list[i].get(key.key);
                                  } else {
                                    selectValue[i] = "";
                                  }
                                  map.addAll({key.key: selectValue});
                                  flutterListFilterBloc
                                      .add(FilterLoadEvent(map));
                                },
                                title: Text(list[i].get(key.key)),
                              )
                            ]
                          ]
                        ],
                      ),
                    ],
                  )),
            )
          ]);
        } else {
          return Container();
        }
      },
    );
  }
}
