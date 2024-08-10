import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  //final Product product;
  const DetailsScreen({
    super.key,
    //required this.product
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int currentImage = 0;
  int currentColor = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: height * 0.25,
            width: width,
            color: const Color(0xff283148),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 13.0, right: 13),
              child: Row(
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13)),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13)),
                        hintText: '',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.14, left: width * 0.04),
            child: Container(
              height: height * 0.2,
              width: width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/mainbanner.png'))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.36, left: width * 0.05, right: width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hot Deals',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr1.png'))),
                          ),
                          const Text(
                            '\$120',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Men's Shoes ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr2.png'))),
                          ),
                          const Text(
                            '\$102',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Leather bag ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr3.png'))),
                          ),
                          const Text(
                            '\$85',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Wallet For Men's",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weekly top',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr4.png'))),
                          ),
                          const Text(
                            '\$250',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Watches",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr5.png'))),
                          ),
                          const Text(
                            '\$102',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "WI-FI",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr6.png'))),
                          ),
                          const Text(
                            '\$20',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "T-Shirt",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trendly',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr1.png'))),
                          ),
                          const Text(
                            '\$120',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Men's Shoes ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr2.png'))),
                          ),
                          const Text(
                            '\$102',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Leather bag ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pr3.png'))),
                          ),
                          const Text(
                            '\$85',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Wallet For Men's",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: Color(0xFFFCFCFC),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Image(
    //           image: AssetImage('assets/bandicam 2023-06-15 13-25-33-107.jpg')),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(18.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               'Trendy Trench Set',
    //               style: TextStyle(
    //                   fontSize: 30,
    //                   fontFamily: 'BigFont',
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             SizedBox(
    //               height: 13,
    //             ),
    //             Text(
    //               'Mango',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 13,
    //             ),
    //             Text(
    //               'Our product are made u'
    //               'sing sustainable fibers or'
    //               ' prosess that'
    //               'that reduce thire environmantal impact',
    //               style: TextStyle(fontSize: 17),
    //             )
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 22.0, right: 22),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               height: 60,
    //               width: 60,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(80),
    //                 color: Colors.white,
    //                 border: Border.all(color: Colors.grey),
    //               ),
    //               child: Icon(
    //                 Icons.favorite,
    //                 color: Colors.orange,
    //               ),
    //             ),
    //             Container(
    //               height: 60,
    //               width: 250,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(80),
    //                   color: Color(0xff161616)),
    //               child: Center(
    //                   child: Text(
    //                 'Buy For \$220.88',
    //                 style: TextStyle(color: Colors.white, fontSize: 20),
    //               )),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}




// Scaffold(
//       backgroundColor: Color.fromARGB(255, 182, 145, 145),
//       // for add to cart , icon and quantity
//       //floatingActionButton: AddToCart(product: widget.product),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // for back button share and favorite,
//             // DetailAppBar(product: widget.product,),
//             // for detail image slider
//             ImageSlider(
//               image: "assets/marwa.jpg",
//               onChange: (index) {
//                 setState(() {
//                   currentImage = index;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 5,
//                 (index) => AnimatedContainer(
//                   duration: const Duration(microseconds: 300),
//                   width: currentImage == index ? 15 : 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 3),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: currentImage == index
//                         ? Colors.black
//                         : Colors.transparent,
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: double.infinity,
//               //height: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(40),
//                   topLeft: Radius.circular(40),
//                 ),
//               ),
//               padding: const EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 top: 20,
               
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // for product name, price, rating, and seller
//                   // ItemsDetails(product: widget.product),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Color",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: List.generate(
//                       2,
//                       (index) => GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             currentColor = index;
//                           });
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: currentColor == index
//                                 ? Colors.white
//                                 : Colors.black,
//                             border: currentColor == index
//                                 ? Border.all(
//                                     color: Colors.black,
//                                   )
//                                 : null,
//                           ),
//                           padding: currentColor == index
//                               ? const EdgeInsets.all(2)
//                               : null,
//                           margin: const EdgeInsets.only(right: 10),
//                           child: Container(
//                             width: 35,
//                             height: 35,
//                             decoration: BoxDecoration(
//                                 color: Colors.red, shape: BoxShape.circle),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   // for description
//                   // Description(description: widget.product.description,)
//                 ],
//               ),
//             )
//           ],
//         ),
//       )),
//     );