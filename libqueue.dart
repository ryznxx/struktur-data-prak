import 'dart:collection';

void main() {
  Queue<int> queue = Queue<int>();

  // Enqueue - Tambah data
  queue.addLast(10);
  queue.addLast(20);
  queue.addLast(30);
  print("✅ Enqueue 3 data: $queue");

  // Dequeue - Ambil data dari depan
  int removed = queue.removeFirst();
  print("🗑️ Dequeue data: $removed");
  print("📦 Isi Queue sekarang: $queue");

  // Cek elemen depan & belakang
  print("🔍 Front: ${queue.first}");
  print("🔍 Rear: ${queue.last}");

  // Cek kondisi kosong atau tidak
  print("🤔 Apakah kosong? ${queue.isEmpty}");

  // Coba dequeue sampe kosong
  queue.removeFirst();
  queue.removeFirst();
  print("🚫 Dequeue sampai habis: $queue");

  // Kondisi underflow (Queue kosong)
  if (queue.isEmpty) {
    print("⚠️ Queue kosong, gabisa dequeue lagi");
  }
}
