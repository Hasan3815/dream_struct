// import 'package:dream_struct/login/splash_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(home: Splashscreen(), debugShowCheckedModeBanner: false));
// }

import 'package:dream_struct/login/splash_screen.dart';
import 'package:dream_struct/screens/auth_check_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

// // Title  : Dream Struct (Build your home my their own)
// // Abstract : It is a smart construction planning system that automates house design and cost estimation. It is developed using flutter for the frontend and firebase for backend services like authentication and data management. The system allows users to input plot size and requirement such as rooms, kitchen, and other spaces. Based on these inputs it generate architectural , structural , plumbing and electrical plans. It also provide detailed material lists estimated construction cost. The platform includes role based dashboards for users , architects, and administrators. Architect revies and approve plans to ensure safety  and legal compliance. User can select between standard and premium plan through subscription ,models. The system integrate design generation , budgeting, and professional validation in one platform. Future enhancement include the 3D visualization , AI optimization , and virtual walkthrough features.


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// // 1. Data Models
// enum ArchitectSpecialtyFilter {
//   all,
//   nearby,
//   residential,
//   commercial,
//   landscape,
//   sustainable,
//   interior, // Added for Sarah Davis example
//   urban, // Added for David Brown example
// }

// class Architect {
//   final String name;
//   final String specialty;
//   final double rating;
//   final String imageUrl;
//   final bool isNearYou; // To categorize for "Near You" section

//   Architect({
//     required this.name,
//     required this.specialty,
//     required this.rating,
//     required this.imageUrl,
//     this.isNearYou = false,
//   });
// }

// // 2. State Management (Provider)
// class ArchitectsProvider extends ChangeNotifier {
//   String _searchQuery = '';
//   ArchitectSpecialtyFilter _selectedFilter = ArchitectSpecialtyFilter.all;

//   // Dummy data for architects
//   final List<Architect> _allArchitects = [
//     Architect(
//       name: 'John Doe',
//       specialty: 'Modern Residential Design',
//       rating: 4.0,
//       imageUrl: 'https://i.ibb.co/L5Q2Z2d/person1.png',
//       isNearYou: true,
//     ),
//     Architect(
//       name: 'Emily Williams',
//       specialty: 'Landscape Architecture',
//       rating: 4.9,
//       imageUrl: 'https://i.ibb.co/q1z6h4m/person2.png',
//       isNearYou: true,
//     ),
//     Architect(
//       name: 'Jane Smith',
//       specialty: 'Commercial Architecture',
//       rating: 4.8,
//       imageUrl: 'https://i.ibb.co/rK3s8d3/person3.png',
//       isNearYou: false,
//     ),
//     Architect(
//       name: 'Michael Johnson',
//       specialty: 'Sustainable Design',
//       rating: 4.2,
//       imageUrl: 'https://i.ibb.co/Wc6q7wL/person4.png',
//       isNearYou: false,
//     ),
//     Architect(
//       name: 'Sarah Davis',
//       specialty: 'Interior Design',
//       rating: 4.5,
//       imageUrl: 'https://i.ibb.co/Z1Yy2zB/person5.png',
//       isNearYou: true, // Example, could be based on actual location
//     ),
//     Architect(
//       name: 'David Brown',
//       specialty: 'Urban Planning',
//       rating: 3.9,
//       imageUrl: 'https://i.ibb.co/jT8B9Lp/person6.png',
//       isNearYou: false,
//     ),
//   ];

//   String get searchQuery => _searchQuery;
//   ArchitectSpecialtyFilter get selectedFilter => _selectedFilter;

//   void setSearchQuery(String query) {
//     _searchQuery = query;
//     notifyListeners();
//   }

//   void setSelectedFilter(ArchitectSpecialtyFilter filter) {
//     _selectedFilter = filter;
//     notifyListeners();
//   }

//   List<Architect> get _filteredArchitects {
//     List<Architect> architects = _allArchitects;

//     // Filter by search query
//     if (_searchQuery.isNotEmpty) {
//       final query = _searchQuery.toLowerCase();
//       architects = architects.where((architect) {
//         return architect.name.toLowerCase().contains(query) ||
//             architect.specialty.toLowerCase().contains(query);
//       }).toList();
//     }

//     // Filter by selected category
//     if (_selectedFilter != ArchitectSpecialtyFilter.all) {
//       architects = architects.where((architect) {
//         switch (_selectedFilter) {
//           case ArchitectSpecialtyFilter.nearby:
//             return architect.isNearYou;
//           case ArchitectSpecialtyFilter.residential:
//             return architect.specialty.toLowerCase().contains('residential');
//           case ArchitectSpecialtyFilter.commercial:
//             return architect.specialty.toLowerCase().contains('commercial');
//           case ArchitectSpecialtyFilter.landscape:
//             return architect.specialty.toLowerCase().contains('landscape');
//           case ArchitectSpecialtyFilter.sustainable:
//             return architect.specialty.toLowerCase().contains('sustainable');
//           case ArchitectSpecialtyFilter.interior:
//             return architect.specialty.toLowerCase().contains('interior');
//           case ArchitectSpecialtyFilter.urban:
//             return architect.specialty.toLowerCase().contains('urban');
//           default:
//             return true; // ArchitectSpecialtyFilter.all
//         }
//       }).toList();
//     }

//     return architects;
//   }

//   List<Architect> get nearYouArchitects {
//     return _filteredArchitects.where((architect) => architect.isNearYou).toList();
//   }

//   List<Architect> get otherArchitects {
//     return _filteredArchitects.where((architect) => !architect.isNearYou).toList();
//   }
// }

// // 3. Main Screen Widget
// class VerifiedArchitectsScreen extends StatelessWidget {
//   const VerifiedArchitectsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Implement back navigation
//           },
//         ),
//         title: const Text(
//           'Verified Architects',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               // Implement filter action
//             },
//           ),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       backgroundColor: const Color(0xFFF8F9FA), // Light grey background
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: _buildSearchBar(context),
//             ),
//             _buildFilterChips(context),
//             Expanded(
//               child: Consumer<ArchitectsProvider>(
//                 builder: (context, provider, child) {
//                   final nearYou = provider.nearYouArchitects;
//                   final others = provider.otherArchitects;

//                   if (nearYou.isEmpty && others.isEmpty) {
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(24.0),
//                         child: Text(
//                           'No architects found matching your criteria.',
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                   }

//                   return ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     children: [
//                       if (nearYou.isNotEmpty) ...[
//                         const SizedBox(height: 16.0),
//                         const Text(
//                           'Near You (2 miles)',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF263238), // Dark text color
//                           ),
//                         ),
//                         const SizedBox(height: 12.0),
//                         ...nearYou.map((architect) => Padding(
//                           padding: const EdgeInsets.only(bottom: 16.0),
//                           child: ArchitectCard(architect: architect),
//                         )).toList(),
//                       ],
//                       if (others.isNotEmpty) ...[
//                         const SizedBox(height: 16.0),
//                         const Text(
//                           'Other architects',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF263238), // Dark text color
//                           ),
//                         ),
//                         const SizedBox(height: 12.0),
//                         ...others.map((architect) => Padding(
//                           padding: const EdgeInsets.only(bottom: 16.0),
//                           child: ArchitectCard(architect: architect),
//                         )).toList(),
//                       ],
//                       const SizedBox(height: 24.0), // Bottom padding
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TextField(
//         onChanged: (query) {
//           context.read<ArchitectsProvider>().setSearchQuery(query);
//         },
//         decoration: InputDecoration(
//           hintText: 'Search architects by name or specialty...',
//           hintStyle: const TextStyle(color: Colors.grey),
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterChips(BuildContext context) {
//     return Consumer<ArchitectsProvider>(
//       builder: (context, provider, child) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Row(
//             children: ArchitectSpecialtyFilter.values.map((filterType) {
//               String label;
//               IconData? icon;
//               switch (filterType) {
//                 case ArchitectSpecialtyFilter.all:
//                   label = 'All';
//                   break;
//                 case ArchitectSpecialtyFilter.nearby:
//                   label = 'Nearby';
//                   icon = Icons.send; // Example icon, could be location icon
//                   break;
//                 case ArchitectSpecialtyFilter.residential:
//                   label = 'Residential';
//                   break;
//                 case ArchitectSpecialtyFilter.commercial:
//                   label = 'Commercial';
//                   break;
//                 case ArchitectSpecialtyFilter.landscape:
//                   label = 'Landscape';
//                   break;
//                 case ArchitectSpecialtyFilter.sustainable:
//                   label = 'Sustainable';
//                   break;
//                 case ArchitectSpecialtyFilter.interior:
//                   label = 'Interior';
//                   break;
//                 case ArchitectSpecialtyFilter.urban:
//                   label = 'Urban';
//                   break;
//               }

//               final isSelected = provider.selectedFilter == filterType;
//               const Color primaryBlue = Color(0xFF2962FF); // A vibrant blue
//               final Color textColor = isSelected ? Colors.white : const Color(0xFF263238);

//               return Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: ChoiceChip(
//                   label: Text(label),
//                   avatar: icon != null ? Icon(icon, size: 18, color: textColor) : null,
//                   selected: isSelected,
//                   selectedColor: primaryBlue,
//                   backgroundColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: textColor,
//                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                     fontSize: 14,
//                   ),
//                   side: BorderSide(
//                     color: isSelected ? primaryBlue : Colors.grey.shade300,
//                     width: 1.0,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                   onSelected: (selected) {
//                     if (selected) {
//                       provider.setSelectedFilter(filterType);
//                     }
//                   },
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }

// // Custom Widget for Architect Card
// class ArchitectCard extends StatelessWidget {
//   final Architect architect;

//   const ArchitectCard({super.key, required this.architect});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 35,
//                 backgroundImage: NetworkImage(architect.imageUrl),
//                 backgroundColor: Colors.grey[200],
//               ),
//               const SizedBox(width: 16.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       architect.name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF263238),
//                       ),
//                     ),
//                     const SizedBox(height: 4.0),
//                     Text(
//                       architect.specialty,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     RatingStars(rating: architect.rating),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Viewing profile for ${architect.name}')),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2962FF), // Blue color
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 elevation: 2,
//               ),
//               child: const Text(
//                 'View Profile',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Widget for Star Ratings
// class RatingStars extends StatelessWidget {
//   final double rating;
//   final int starCount;

//   const RatingStars({
//     super.key,
//     required this.rating,
//     this.starCount = 5,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(starCount, (index) {
//         IconData icon;
//         Color color = Colors.amber;
//         if (index >= rating) {
//           icon = Icons.star_border;
//           color = Colors.grey.shade400; // Unfilled star color
//         } else if (index > rating - 1 && index < rating) {
//           icon = Icons.star_half;
//         } else {
//           icon = Icons.star;
//         }
//         return Icon(
//           icon,
//           color: color,
//           size: 18,
//         );
//       })
//         ..add(
//           Padding(
//             padding: const EdgeInsets.only(left: 6.0),
//             child: Text(
//               rating.toStringAsFixed(1),
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ),
//         ),
//     );
//   }
// }

// // Root application widget
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ArchitectsProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Verified Architects',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           fontFamily: 'Roboto', // Default font, can be customized (e.g., 'Montserrat')
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//           ),
//         ),
//         home: const VerifiedArchitectsScreen(),
//       ),
//     );
//   }
// }



