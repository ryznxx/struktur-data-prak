import 'dart:io';

class Node<T> {
  T key;
  Node<T>? left, right;

  Node(this.key);
}

class BinaryTree<T> {
  Node<T>? root;

  void preorderTraversal(Node<T>? node) {
    if (node == null) {
      return;
    }

    stdout.write("${node.key} ");
    preorderTraversal(node.left);
    preorderTraversal(node.right);
  }

  void printTree() {
    preorderTraversal(root);
    stdout.write("\n");
  }

  void insertRootTree(T newValue) {
    root = Node<T>(newValue);
  }

  void insertLevelOrder(T newValue) {
    if (root == null) {
      root = Node<T>(newValue);
      return;
    }

    List<dynamic> test_queue = [root!.key];
    print(test_queue);
    List<Node<T>> queue = [root!];
    while (queue.isNotEmpty) {
      Node<T> temp = queue.removeAt(0);

      if (temp.left == null) {
        temp.left = Node<T>(newValue);
        break;
      } else {
        queue.add(temp.left!);
      }

      if (temp.right == null) {
        temp.right = Node<T>(newValue);
        break;
      } else {
        queue.add(temp.right!);
      }
    }
  }

  // 1. Method untuk menambahkan berdasarkan Level Order (rekursif)
  void insertLevelOrderRecursive(T newValue) {
    if (root == null) {
      root = Node<T>(newValue);
      return;
    }

    int depth = _getTreeDepth(root);
    for (int level = 0; level <= depth; level++) {
      if (_insertAtLevel(root, newValue, level, 0)) {
        break;
      }
    }
  }

  bool _insertAtLevel(
    Node<T>? node,
    T value,
    int targetLevel,
    int currentLevel,
  ) {
    if (node == null) return false;

    if (currentLevel == targetLevel) {
      if (node.left == null) {
        node.left = Node<T>(value);
        return true;
      } else if (node.right == null) {
        node.right = Node<T>(value);
        return true;
      }
      return false;
    }

    return _insertAtLevel(node.left, value, targetLevel, currentLevel + 1) ||
        _insertAtLevel(node.right, value, targetLevel, currentLevel + 1);
  }

  int _getTreeDepth(Node<T>? node) {
    if (node == null) return -1;

    int leftDepth = _getTreeDepth(node.left);
    int rightDepth = _getTreeDepth(node.right);

    return 1 + (leftDepth > rightDepth ? leftDepth : rightDepth);
  }

  // 2. Method untuk menambahkan data berdasarkan target dengan linear search
  bool insertByTarget(T targetValue, T newValue, {bool asLeftChild = true}) {
    Node<T>? targetNode = _linearSearch(root, targetValue);

    if (targetNode == null) {
      print("Target node dengan nilai $targetValue tidak ditemukan");
      return false;
    }

    if (asLeftChild) {
      if (targetNode.left == null) {
        targetNode.left = Node<T>(newValue);
        print(
          "Node $newValue berhasil ditambahkan sebagai anak kiri dari $targetValue",
        );
        return true;
      } else {
        print("Anak kiri dari node $targetValue sudah ada");
        return false;
      }
    } else {
      if (targetNode.right == null) {
        targetNode.right = Node<T>(newValue);
        print(
          "Node $newValue berhasil ditambahkan sebagai anak kanan dari $targetValue",
        );
        return true;
      } else {
        print("Anak kanan dari node $targetValue sudah ada");
        return false;
      }
    }
  }

  Node<T>? _linearSearch(Node<T>? node, T targetValue) {
    if (node == null) return null;

    if (node.key == targetValue) return node;

    Node<T>? leftResult = _linearSearch(node.left, targetValue);
    if (leftResult != null) return leftResult;

    return _linearSearch(node.right, targetValue);
  }

  // 3. Method untuk traversal non-rekursif menggunakan stack (list)

  // In-Order Traversal (non-rekursif)
  void inOrderNonRecursive() {
    if (root == null) {
      print("Tree kosong");
      return;
    }

    List<Node<T>> stack = [];
    Node<T>? current = root;

    print("In-Order Traversal (Non-Recursive): ");

    while (stack.isNotEmpty || current != null) {
      // Push semua node kiri ke stack
      while (current != null) {
        stack.add(current);
        current = current.left;
      }

      // Pop dari stack dan cetak
      current = stack.removeLast();
      stdout.write("${current.key} ");

      // Pindah ke subtree kanan
      current = current.right;
    }
    stdout.write("\n");
  }

  // Pre-Order Traversal (non-rekursif)
  void preOrderNonRecursive() {
    if (root == null) {
      print("Tree kosong");
      return;
    }

    List<Node<T>> stack = [root!];

    print("Pre-Order Traversal (Non-Recursive): ");

    while (stack.isNotEmpty) {
      Node<T> current = stack.removeLast();
      stdout.write("${current.key} ");

      // Push anak kanan terlebih dahulu (akan diproses setelah anak kiri)
      if (current.right != null) {
        stack.add(current.right!);
      }

      // Push anak kiri
      if (current.left != null) {
        stack.add(current.left!);
      }
    }
    stdout.write("\n");
  }

  // Post-Order Traversal (non-rekursif)
  void postOrderNonRecursive() {
    if (root == null) {
      print("Tree kosong");
      return;
    }

    List<Node<T>> stack1 = [root!];
    List<Node<T>> stack2 = [];

    print("Post-Order Traversal (Non-Recursive): ");

    // Menggunakan dua stack untuk post-order
    while (stack1.isNotEmpty) {
      Node<T> current = stack1.removeLast();
      stack2.add(current);

      // Push anak kiri terlebih dahulu
      if (current.left != null) {
        stack1.add(current.left!);
      }

      // Push anak kanan
      if (current.right != null) {
        stack1.add(current.right!);
      }
    }

    // Pop semua elemen dari stack2 dan cetak
    while (stack2.isNotEmpty) {
      stdout.write("${stack2.removeLast().key} ");
    }
    stdout.write("\n");
  }

  // Method untuk menampilkan semua jenis traversal
  void displayAllTraversals() {
    print("\n=== TRAVERSAL METHODS ===");
    preOrderNonRecursive();
    inOrderNonRecursive();
    postOrderNonRecursive();
  }

  // Method untuk menampilkan struktur tree secara visual
  void displayTreeStructure() {
    print("\n=== TREE STRUCTURE ===");
    _printTreeStructure(root, "", true);
  }

  void _printTreeStructure(Node<T>? node, String prefix, bool isLast) {
    if (node == null) return;

    print("$prefix${isLast ? '└── ' : '├── '}${node.key}");

    if (node.left != null || node.right != null) {
      if (node.left != null) {
        _printTreeStructure(
          node.left,
          prefix + (isLast ? "    " : "│   "),
          node.right == null,
        );
      }
      if (node.right != null) {
        _printTreeStructure(
          node.right,
          prefix + (isLast ? "    " : "│   "),
          true,
        );
      }
    }
  }
}

void main() {
  BinaryTree<int> tree = BinaryTree<int>();

  print("=== TESTING BINARY TREE OPERATIONS ===\n");

  // Test 1: Insert menggunakan level order biasa
  print("1. Membuat tree dengan insertLevelOrder:");
  tree.insertRootTree(1);
  tree.insertLevelOrder(2);
  tree.insertLevelOrder(3);
  tree.insertLevelOrder(4);
  tree.insertLevelOrder(5);
  tree.printTree();
  tree.displayTreeStructure();

  // Test 2: Insert menggunakan level order rekursif
  print("\n2. Menambahkan node 6 dengan insertLevelOrderRecursive:");
  tree.insertLevelOrderRecursive(6);
  tree.printTree();
  tree.displayTreeStructure();

  // Test 3: Insert berdasarkan target
  print("\n3. Testing insertByTarget:");
  tree.insertByTarget(
    2,
    7,
    asLeftChild: true,
  ); // Tambah 7 sebagai anak kiri dari 2
  tree.insertByTarget(
    3,
    8,
    asLeftChild: false,
  ); // Tambah 8 sebagai anak kanan dari 3
  tree.insertByTarget(10, 9); // Target tidak ada
  tree.displayTreeStructure();

  // Test 4: Non-recursive traversals
  tree.displayAllTraversals();

  print("\n=== TESTING DENGAN TREE BARU ===");

  // Test dengan tree yang lebih kompleks
  BinaryTree<String> stringTree = BinaryTree<String>();
  stringTree.insertRootTree("A");
  stringTree.insertLevelOrder("B");
  stringTree.insertLevelOrder("C");
  stringTree.insertLevelOrder("D");
  stringTree.insertLevelOrder("E");
  stringTree.insertLevelOrder("F");
  stringTree.insertLevelOrder("G");

  print("\nString Tree Structure:");
  stringTree.displayTreeStructure();
  stringTree.displayAllTraversals();
}
