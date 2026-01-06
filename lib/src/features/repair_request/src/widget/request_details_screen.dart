// import 'dart:io';
// import 'package:ui_kit/ui.dart';
// import '../../request.dart';

// class RepairRequestDetailsScreen extends StatefulWidget {
//   const RepairRequestDetailsScreen({super.key, required this.request});

//   final FullRepairRequest request;

//   @override
//   State<RepairRequestDetailsScreen> createState() =>
//       _RepairRequestDetailsScreenState();
// }

// class _RepairRequestDetailsScreenState
//     extends State<RepairRequestDetailsScreen> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   String _formatDate(DateTime d) {
//     final dd = d.day.toString().padLeft(2, '0');
//     final mm = d.month.toString().padLeft(2, '0');
//     final yyyy = d.year;
//     return '$dd.$mm.$yyyy';
//   }

//   Color _priorityColor(Priority p) {
//     switch (p) {
//       case Priority.ordinary:
//         return Colors.green;
//       case Priority.high:
//         return Colors.red;
//     }
//   }

//   void _openImage(BuildContext context, String path) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) {
//           return Scaffold(
//             backgroundColor: Colors.black,
//             appBar: AppBar(backgroundColor: Colors.black),
//             body: Center(
//               child: Hero(
//                 tag: path,
//                 child: InteractiveViewer(
//                   child: Image.file(File(path), fit: BoxFit.contain),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildImageCarousel() {
//     final images = widget.request.imagePaths;
//     if (images.isEmpty) {
//       return Container(
//         height: 240,
//         color: Colors.grey[200],
//         child: Center(
//           child: Column(
//             mainAxisSize: .min,
//             children: [
//               Icon(Icons.photo, size: 48, color: Colors.grey),
//               const SizedBox(height: 8),
//               Text(
//                 'Фото не добавлены',
//                 style: TextStyle(color: Colors.grey[700]),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Column(
//       children: [
//         SizedBox(
//           height: 320,
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) => setState(() => _currentIndex = index),
//             itemCount: images.length,
//             itemBuilder: (context, index) {
//               final path = images[index].photoPath;
//               return GestureDetector(
//                 onTap: () {
//                   _openImage(context, path);
//                 },
//                 child: Hero(
//                   tag: path,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 10,
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Container(
//                         color: Colors.grey[100],
//                         child: Image.file(
//                           File(path),
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Center(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.broken_image,
//                                     size: 36,
//                                     color: Colors.grey,
//                                   ),
//                                   const SizedBox(height: 6),
//                                   const Text('Ошибка загрузки'),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 8),
//         _buildDotsIndicator(images.length),
//       ],
//     );
//   }

//   Widget _buildDotsIndicator(int count) {
//     return Row(
//       mainAxisAlignment: .center,
//       children: List.generate(count, (i) {
//         final active = i == _currentIndex;
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           width: active ? 12 : 8,
//           height: active ? 12 : 8,
//           decoration: BoxDecoration(
//             color: active
//                 ? Theme.of(context).colorPalette.accent
//                 : Colors.grey[400],
//             borderRadius: BorderRadius.circular(6),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _metaTile({
//     required IconData icon,
//     required String title,
//     String? subtitle,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//       subtitle: subtitle != null ? Text(subtitle) : null,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final r = widget.request;

//     return Scaffold(
//       appBar: AppBar(
//         title: UiText.titleLarge('Заявка #${r.id}'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//             child: Chip(label: UiText.titleMedium(r.status.value)),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildImageCarousel(),
//             const SizedBox(height: 12),

//             // Основная карточка
//             Padding(
//               padding: const .symmetric(horizontal: 12),
//               child: Card(
//                 shape: RoundedRectangleBorder(borderRadius: .circular(12)),
//                 child: Padding(
//                   padding: const .all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Chip(
//                             avatar: CircleAvatar(
//                               backgroundColor: _priorityColor(r.priority),
//                               child: Icon(
//                                 Icons.flag,
//                                 size: 18,
//                                 color: _priorityColor(r.priority),
//                               ),
//                             ),
//                             label: UiText.bodyLarge(r.priority.value),
//                           ),
//                           const SizedBox(width: 8),
//                           Chip(
//                             avatar: const Icon(Icons.calendar_today, size: 18),
//                             label: UiText.bodyLarge(_formatDate(r.date)),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'Описание',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 6),
//                       Text(r.description, style: const TextStyle(fontSize: 15)),
//                       const SizedBox(height: 12),
//                       Divider(),
//                       _metaTile(
//                         icon: Icons.person,
//                         title: 'UID',
//                         subtitle: r.uid,
//                       ),
//                       _metaTile(
//                         icon: Icons.build,
//                         title: 'Специализация ID',
//                         subtitle: r.specializationId.toString(),
//                       ),
//                       _metaTile(
//                         icon: Icons.access_time,
//                         title: 'Создана',
//                         subtitle:
//                             '${_formatDate(r.createdAt)} ${r.createdAt.hour.toString().padLeft(2, '0')}:${r.createdAt.minute.toString().padLeft(2, '0')}',
//                       ),
//                       _metaTile(
//                         icon: r.studentAbsent ? Icons.close : Icons.check,
//                         title: 'Студент отсутствует',
//                         subtitle: r.studentAbsent ? 'Да' : 'Нет',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 28),
//           ],
//         ),
//       ),
//     );
//   }
// }
