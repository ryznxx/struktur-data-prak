void selectionSort<T extends Comparable<T>>(List<T> arr) {
  for (int i = arr.length - 1; i >= 0; i--) {
    int maxIndex = i;
    for (int j = i - 1; j >= 0; j--) {
      if (arr[j].compareTo(arr[maxIndex]) < 0) {
        maxIndex = j;
      }
    }
    // Tukar elemen di posisi i dengan elemen maksimum
    T temp = arr[i];
    arr[i] = arr[maxIndex];
    arr[maxIndex] = temp;
  }
}

void display<T>(List<T> data) {
  for (T element in data) {
    print('$element ');
  }
  print(''); // Untuk baris baru
}

void main() {
  List<num> data = List<num>.generate(10, (index) => (index + 1) * 2);
  data.shuffle();

  print('Data Sebelum Pengurutan:');
  display(data);

  DateTime startTime = DateTime.now();
  selectionSort<num>(data);
  Duration elapsedTime = DateTime.now().difference(startTime);

  print('Data Setelah Pengurutan:');
  display(data);
  print('Waktu Eksekusi: ${elapsedTime.inMilliseconds} ms');
}
