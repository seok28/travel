// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';

class Item {
  String title;
  int value;

  Item(this.title, this.value);
}

class Area {
  List<DropdownMenuItem<Item>> seoulArea = List.empty(growable: true);
  Area() {
    seoulArea.add(DropdownMenuItem(
      child: const Text('강남구'),
      value: Item('강남구', 1),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('강동구'),
      value: Item('강동구', 2),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('강북구'),
      value: Item('강북구', 3),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('강서구'),
      value: Item('강서구', 4),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('관악구'),
      value: Item('관악구', 5),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('광진구'),
      value: Item('광진구', 6),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('구로구'),
      value: Item('구로구', 7),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('금천구'),
      value: Item('금천구', 8),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('노원구'),
      value: Item('노원구', 9),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('도봉구'),
      value: Item('도봉구', 10),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('동대문구'),
      value: Item('동대문구', 11),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('동작구'),
      value: Item('동작구', 12),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('마포구'),
      value: Item('마포구', 13),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('서대문구'),
      value: Item('서대문구', 14),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('서초구'),
      value: Item('서초구', 15),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('성동구'),
      value: Item('성동구', 16),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('성북구'),
      value: Item('성북구', 17),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('송파구'),
      value: Item('송파구', 18),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('양천구'),
      value: Item('양천구', 19),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('영등포구'),
      value: Item('영등포구', 20),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('용산구'),
      value: Item('용산구', 21),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('은평구'),
      value: Item('은평구', 22),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('종로구'),
      value: Item('종로구', 23),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('중구'),
      value: Item('중구', 24),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('중랑구'),
      value: Item('중랑구', 25),
    ));
    print(seoulArea.length);
  }
}

class Area2 {
  List<DropdownMenuItem<Item>> busanArea = List.empty(growable: true);
  Area2() {
    busanArea.add(DropdownMenuItem(
      child: const Text('강서구'),
      value: Item('강서구', 1),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('금정구'),
      value: Item('금정구', 2),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('기장군'),
      value: Item('기장군', 3),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('남구'),
      value: Item('남구', 4),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('동구'),
      value: Item('동구', 5),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('동래구'),
      value: Item('동래구', 6),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('부산진구'),
      value: Item('부산진구', 7),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('북구'),
      value: Item('북구', 8),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('사상구'),
      value: Item('사상구', 9),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('사하구'),
      value: Item('사하구', 10),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('서구'),
      value: Item('서구', 11),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('수영구'),
      value: Item('수영구', 12),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('연제구'),
      value: Item('연제구', 13),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('영도구'),
      value: Item('영도구', 14),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('중구'),
      value: Item('중구', 15),
    ));
    busanArea.add(DropdownMenuItem(
      child: const Text('해운대구'),
      value: Item('해운대구', 16),
    ));
    print(busanArea.length);
  }
}

class Kind {
  List<DropdownMenuItem<Item>> kinds = List.empty(growable: true);

  Kind() {
    kinds.add(DropdownMenuItem(
      child: const Text('관광지'),
      value: Item('관광지', 12),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('문화시설'),
      value: Item('문화시설', 14),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('축제/공연'),
      value: Item('축제/공연', 15),
    ));

    kinds.add(DropdownMenuItem(
      child: const Text('레포츠'),
      value: Item('레포츠', 28),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('숙박'),
      value: Item('숙박', 32),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('쇼핑'),
      value: Item('쇼핑', 38),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('음식'),
      value: Item('음식', 39),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('전체'),
      value: Item('전체', 0),
    ));
  }
}
