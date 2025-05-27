class CircularQueue {
  List<int>? queue;
  late int front, rear, size;
  final int maxSize;

  CircularQueue(this.maxSize) {
    queue = List<int>.filled(maxSize, 0);
    front = -1;
    rear = -1;
    size = 0;
  }

  bool isFull() {
    return (front == 0 && rear == maxSize - 1) || (rear + 1) % maxSize == front;
  }

  bool isEmpty() {
    return front == -1;
  }

  int getSize() {
    if (isEmpty()) return 0;
    if (front <= rear) return rear - front + 1;
    return maxSize - front + rear + 1;
  }

  void enqueue(int data) {
    if (isFull()) {
      print("📛 Queue Overflow: Antrian penuh!");
      return;
    }

    if (isEmpty()) {
      front = 0;
      rear = 0;
    } else {
      rear = (rear + 1) % maxSize;
    }

    queue![rear] = data;
    size = getSize();
    print("✅ Data $data berhasil masuk ke antrian");
  }

  int dequeue() {
    if (isEmpty()) {
      print("📛 Queue Underflow: Antrian kosong!");
      return -1;
    }

    int data = queue![front];
    queue?[front] = 0; // Reset nilai posisi front

    if (front == rear) {
      // Hanya ada satu elemen
      front = -1;
      rear = -1;
    } else {
      front = (front + 1) % maxSize;
    }

    size = getSize();
    print("🗑️ Data $data berhasil dikeluarkan dari antrian");
    return data;
  }

  void display() {
    if (isEmpty()) {
      print("🚫 Antrian kosong!");
      return;
    }

    print("📦 Isi Antrian:");
    int i = front;
    do {
      print("[$i]: ${queue?[i]}");
      i = (i + 1) % maxSize;
    } while (i != (rear + 1) % maxSize);

    print("👉 Front: $front, Rear: $rear, Size: $size");
  }

  int peek() {
    if (isEmpty()) {
      print("📛 Antrian kosong!");
      return -1;
    }
    return queue![front];
  }

  void clear() {
    queue = List<int>.filled(maxSize, 0);
    front = -1;
    rear = -1;
    size = 0;
    print("🧹 Antrian berhasil dikosongkan");
  }
}
