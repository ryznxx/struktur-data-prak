import 'dart:io';

void cetakKombinasi(String prefix, String sisa, int n) {
  if (n == 0) {
    print(prefix);
    return;
  }

  for (var i = 0; i < sisa.length; i++) {
    cetakKombinasi(
        prefix + sisa[i], sisa.substring(0, i) + sisa.substring(i + 1), n - 1);
  }
}

int? bacaInputAngka(String pesan) {
  stdout.write(pesan);
  final input = stdin.readLineSync()?.trim();
  return int.tryParse(input ?? '');
}

String? bacaInputString(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim();
}

void main() {
  final n = bacaInputAngka("Masukkan jumlah karakter (N): ");
  if (n == null || n <= 0) {
    print("Jumlah karakter harus angka positif.");
    return;
  }

  final input = bacaInputString("Masukkan string karakter unik: ");
  if (input == null || input.isEmpty || input.length < n) {
    print("Input tidak valid atau kurang panjang.");
    return;
  }

  print("Semua kombinasi dari $n karakter:");
  cetakKombinasi("", input, n);
}
