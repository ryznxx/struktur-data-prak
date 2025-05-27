class Dnode<T> {
  T data;
  Dnode? next, prev;

  Dnode(this.data);
}

class DoubleLinkedList {
  Dnode? head;
  Dnode? tail;

  void append(dynamic data) {
    Dnode newNode = Dnode(data);

    if (head == null) {
      head = newNode;
      tail = newNode;
      return;
    }

    newNode.prev = tail;
    tail!.next = newNode;
    tail = newNode;
  }

  void prepend(dynamic data) {
    Dnode newNode = Dnode(data);

    if (head == null) {
      head = newNode;
      tail = newNode;
      return;
    }

    newNode.next = head;
    head!.prev = newNode;
    head = newNode;
  }

  void insertAfter(dynamic target, dynamic data) {
    if (head == null) return;

    Dnode? current = head;

    while (current != null && current.data != target) {
      current = current.next;
    }

    if (current != null) {
      Dnode newNode = Dnode(data);

      newNode.next = current.next;
      newNode.prev = current;

      if (current.next != null) {
        current.next!.prev = newNode;
      } else {
        tail = newNode;
      }

      current.next = newNode;
    }
  }

  void printList() {
    Dnode? current = head;
    List<String> elements = [];

    while (current != null) {
      elements.add(current.data.toString());
      current = current.next;
    }

    print(elements.join(" <--> "));
  }

  void printReverse() {
    Dnode? current = tail;
    List<String> elements = [];

    while (current != null) {
      elements.add(current.data.toString());
      current = current.prev;
    }

    print(elements.join(" <--> "));
  }

  void delete(dynamic data) {
    if (head == null) return;

    Dnode? current = head;

    while (current != null && current.data != data) {
      current = current.next;
    }

    if (current == null) return;

    if (current.prev != null) {
      current.prev!.next = current.next;
    } else {
      head = current.next;
    }

    if (current.next != null) {
      current.next!.prev = current.prev;
    } else {
      tail = current.prev;
    }
  }

  bool searchNode(dynamic target) {
    Dnode? current = head;

    while (current != null) {
      if (current.data == target) {
        print(
          "Ketemu lur datane : ${target} misal teko current :  ${current.data} terus data marine current : ${current.next!.data}",
        );
        return true;
      }
      current = current.next;
    }

    return false;
  }

  Dnode? searchNodeBacaMundur(dynamic target) {
    Dnode? current = tail;
    int pos = 1;
    while (current != null) {
      if (current.data == target) {
        if (current.prev != null) {
          print(
            "Ketemu lur datane: $target terus data sak gurunge ${current.data} iku : ${current.prev!.data}, posisine nomer : $pos",
          );
          return current;
        } else {
          print("lah kan iki head, segurung e head yo null");
          return null;
        }
      }
      print(current.data);
      pos++;
      current = current.prev;
    }
    print("$target aowkoawk heng ono list neng kene");
    return current;
  }

  void deletePosition(int position) {
    if (head == null) return;

    if (position < 0) return;

    if (position == 1) {
      head = head!.next;
      if (head != null) {
        head!.prev = null;
      } else {
        tail = null;
      }
      return;
    }

    Dnode? current = head;
    int currentPosition = 1;

    while (current != null && currentPosition < position) {
      current = current.next;
      currentPosition++;
    }

    if (current == null) return;

    if (current.prev != null) {
      current.prev!.next = current.next;
    }

    if (current.next != null) {
      current.next!.prev = current.prev;
    } else {
      tail = current.prev;
    }
  }

  int get length {
    int count = 0;
    Dnode? current = head;

    while (current != null) {
      count++;
      current = current.next;
    }

    return count;
  }

  bool isEmpty() {
    return head == null;
  }
}

void main() {
  DoubleLinkedList list = DoubleLinkedList();

  print("penambahan node list:");
  list.append(10);
  list.append(40);
  list.append(50);
  list.append(30);
  list.append(90);
  list.printList();

  print("penghapusan node ke 1:");
  list.deletePosition(2);
  list.printList();

  print("\nList length: ${list.length}");
}
