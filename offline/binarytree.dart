import 'dart:io';
import 'dart:collection';

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

  void insertQueue(T value) {
    if (root == null) {
      root = Node<T>(value);
      return;
    }

    Queue<Node<T>> queue = Queue<Node<T>>();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node<T> current = queue.removeFirst();

      if (current.left == null) {
        current.left = Node<T>(value);
        return; // Selesai!
      }

      if (current.right == null) {
        current.right = Node<T>(value);
        return; // Selesai!
      }

      queue.add(current.left!);
      queue.add(current.right!);
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

  void inOrderNonRecursive() {
    if (root == null) {
      print("Tree kosong");
      return;
    }

    List<Node<T>> stack = [];
    Node<T>? current = root;

    print("In-Order Traversal (Non-Recursive): ");

    while (stack.isNotEmpty || current != null) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }

      current = stack.removeLast();
      stdout.write("${current.key} ");

      current = current.right;
    }
    stdout.write("\n");
  }

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

      if (current.right != null) {
        stack.add(current.right!);
      }

      if (current.left != null) {
        stack.add(current.left!);
      }
    }
    stdout.write("\n");
  }

  void postOrderNonRecursive() {
    if (root == null) {
      print("Tree kosong");
      return;
    }

    List<Node<T>> stack1 = [root!];
    List<Node<T>> stack2 = [];

    print("Post-Order Traversal (Non-Recursive): ");

    while (stack1.isNotEmpty) {
      Node<T> current = stack1.removeLast();
      stack2.add(current);

      if (current.left != null) {
        stack1.add(current.left!);
      }

      if (current.right != null) {
        stack1.add(current.right!);
      }
    }

    while (stack2.isNotEmpty) {
      stdout.write("${stack2.removeLast().key} ");
    }
    stdout.write("\n");
  }

  void displayAllTraversal() {
    print("\n=== TRAVERSAL METHODS ===");
    preOrderNonRecursive();
    inOrderNonRecursive();
    postOrderNonRecursive();
  }

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
  BinaryTree<dynamic> tree = BinaryTree<dynamic>();

  print("=== TESTING BINARY TREE OPERATIONS ===\n");

  tree.insertRootTree("a");
  tree.insertLevelOrder("b");
  tree.insertLevelOrder(3);
  tree.insertLevelOrder(4);
  tree.insertLevelOrder(5);
  tree.insertQueue(9);

  print("\nMenambahkan node 6 dengan insertLevelOrderRecursive:");
  tree.insertLevelOrderRecursive(6);
  tree.displayTreeStructure();
  tree.displayAllTraversal();
}
