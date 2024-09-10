import 'dart:io';
void main() {
  print('Pilih bentuk segitiga yang ingin dicetak:');
  print('1. Segitiga Siku-Siku');
  print('2. Segitiga Siku-Siku Terbalik');
  print('3. Segitiga Sama Kaki');
  stdout.write('Masukkan pilihan (1-3): ');
  int pilihan = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan tinggi segitiga: ');
  int tinggi = int.parse(stdin.readLineSync()!);

  switch (pilihan) {
    case 1:
      print('Segitiga Siku-Siku:');
      segitigaSikuSiku(tinggi);
      break;
    case 2:
      print('Segitiga Siku-Siku Terbalik:');
      segitigaSikuSikuTerbalik(tinggi);
      break;
    case 3:
      print('Segitiga Sama Kaki:');
      segitigaSamaKaki(tinggi);
      break;
    default:
      print('Pilihan tidak valid.');
      break;
  }
}

void segitigaSikuSiku(int tinggi) {
  for (int i = 1; i <= tinggi; i++) {
    print('*' * i);
  }
}

void segitigaSikuSikuTerbalik(int tinggi) {
  for (int i = tinggi; i >= 1; i--) {
    print('*' * i);
  }
}

void segitigaSamaKaki(int tinggi) {
  for (int i = 1; i <= tinggi; i++) {
    // Cetak spasi
    stdout.write(' ' * (tinggi - i));
    // Cetak bintang
    stdout.write('*' * (2 * i - 1));
    print('');
  }
}