void insertionSort<T extends Comparable<T>>(List<T> arr) {
  for (int i = arr.length - 1; i >= 0; i--) {
    for (int j = i + 1, k = i; j < arr.length; j++) {
      if (arr[j].compareTo(arr[k]) < 0) {
        break;
      } else {
        // Tukar elemen di posisi k dan j
        T temp = arr[k];
        arr[k] = arr[j];
        arr[j] = temp;
        k = j;
      }
    }
  }
}

void display<T>(List<T> data) {
  for (T obj in data) {
    print('$obj ');
  }
  print('');
}

void main() {
  List<num> data = List<num>.generate(10, (index) => (index + 1) * 2);
  data.shuffle();
  print('Data Sebelum Pengurutan:');
  display(data);

  DateTime start = DateTime.now();
  insertionSort<num>(data);
  Duration elapsedTime = DateTime.now().difference(start);
  print('Data Setelah Pengurutan:');
  display(data);
  print('Waktu: $elapsedTime');
}
