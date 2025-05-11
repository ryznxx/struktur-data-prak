import 'queue.dart';

void main() {
  CircularQueue q = CircularQueue(5);

  q.enqueue(10);
  q.enqueue(20);
  q.enqueue(30);
  q.enqueue(40);
  q.display();

  q.dequeue();
  q.dequeue();
  q.display();

  q.enqueue(50);
  q.enqueue(60);
  q.display();

  q.enqueue(70); // Harus overflow di sini
}
