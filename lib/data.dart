// lib/data.dart

class LostItem {
  final String title;
  final String description;
  final String imagePath;

  LostItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

List<LostItem> lostItems = [
  LostItem(
    title: "Buku",
    description: "Buku sakti dengan sampul biru.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Meja",
    description: "Meja belajar kayu cokelat.",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Kipas",
    description: "Kipas angin besar warna putih.",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Ponsel",
    description: "Ponsel hitam dengan casing merah.",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Kunci Mobil",
    description: "Kunci mobil dengan gantungan bola.",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Tas Ransel",
    description: "Tas hitam dengan banyak kantong.",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Sepatu",
    description: "Sepatu olahraga putih ukuran 42.",
    imagePath: "assets/barang_hilang.jpg",
  ),
  LostItem(
    title: "Topi",
    description: "Topi baseball biru dengan logo merah.",
    imagePath: "assets/barang_hilang.jpg",
  ),
];
