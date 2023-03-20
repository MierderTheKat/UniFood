// ignore_for_file: avoid_print, unnecessary_string_interpolations, camel_case_types, unused_field

import 'routes.dart';

// AMBOS

class Card_PerfilPhoto extends StatefulWidget {
  const Card_PerfilPhoto({super.key});

  @override
  State<Card_PerfilPhoto> createState() => _Card_PerfilPhotoState();
}

class _Card_PerfilPhotoState extends State<Card_PerfilPhoto> {
  bool _isClicked = false;
  File? _image;

  Future _image_(String source) async {
    try{
      // ignore: prefer_typing_uninitialized_variables
      final image;
      if(source == 'gallery'){
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      else{
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }
      if (image == null) return;
      setState(() {
        //_image = File(image.path);
        _cropImage(File(image.path));
      } );
    }
    on PlatformException catch (e) {
      print(e);
    }
  }

  _cropImage(File image) async {

    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );

    if(croppedImage == null) return null;
    setState(() {
        _image = File(croppedImage.path);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: 280),
        //Boton inicial
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: 
          _image == null
            ? TextButton(
              onPressed: () {
                setState(() {
                  _isClicked = !_isClicked;
                });
              },
              style: TextButton.styleFrom(                          
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                backgroundColor: Color(color_5),
                foregroundColor: Color(color_4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
              ),
              child: const FaIcon(
                  FontAwesomeIcons.solidUser,
                  size: 150,
                )
            )
            : TextButton(
              onPressed: () {
                setState(() {
                  _isClicked = !_isClicked;
                });
              },
              style: TextButton.styleFrom(                          
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                backgroundColor: Color(color_5),
                foregroundColor: Color(color_4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
              ),
              child:  Container(
                width: 162,
                height: 165,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(color_5)
                ),
              ),
            ),
        ),
        //Botones emergentes
        _isClicked ? Positioned(
          top: 5,
          left: 210,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                  _image_('camera');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  backgroundColor: Color(color_8),
                  foregroundColor: Color(color_4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.cameraRetro,
                  size: 30,
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                  _image_('gallery');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  backgroundColor: Color(color_8),
                  foregroundColor: Color(color_4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.image,
                  size: 30,
                ),
              ),
            ],
          )
        )
        : const SizedBox.shrink(),
      ],
    );
  }
}


// USUARIO NORMAL

// Menu
class Card_Menu extends StatefulWidget {

  final String nombre;
  final String descripcion;
  final int precio;
  final String imagen;

  const Card_Menu({super.key, required this.nombre, required this.descripcion, required this.precio, required this.imagen });

  @override
  State<Card_Menu> createState() => _Card_MenuState();
}

class _Card_MenuState extends State<Card_Menu> {

  late String _nombre;
  late String _descripcion;
  late int _precio;
  late String _imagen;

   options(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          padding:const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child:SizedBox(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$_nombre',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(color_4)
                                    ),
                                  ),
                                ]
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$_descripcion',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(color_4)
                                    ),
                                  ),
                                ]
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('$_imagen'),
                            fit: BoxFit.scaleDown,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(color_5)
                        ),
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: 100,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(color_5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'MX\$ $_precio',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Variación 1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            productCounter(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Variación 1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            productCounter(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          backgroundColor: Color(color_7),
                          foregroundColor: Color(color_4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),
                        ),
                        onPressed: (){},
                        child: const Text('Agregar al carrito')
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Total:'),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(color_5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'MX\$ $_precio',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  )
                ],
              )
            ),
        );
      }
    );
  }


  @override
  void initState() {
    super.initState();
    _nombre = widget.nombre;
    _descripcion = widget.descripcion;
    _precio = widget.precio;
    _imagen = widget.imagen;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 10,
      //color: Color(color_5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [

          TextButton(
            onPressed: () {
              options(context);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child:SizedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$_nombre',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(color_4)
                                  ),
                                ),
                              ]
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$_descripcion',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(color_4)
                                  ),
                                ),
                              ]
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('$_imagen'),
                          fit: BoxFit.scaleDown,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(color_5)
                      ),
                    ),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(color_5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'MX\$ $_precio',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            )
          ),
        ]
      ),
    );
  }
}


// Carrito Card
class Card_Car extends StatefulWidget {

  final String nombre;
  final String descripcion;
  final int precio;
  final String imagen;

  const Card_Car({super.key, required this.nombre, required this.descripcion, required this.precio, required this.imagen });

  @override
  State<Card_Car> createState() => _Card_CarState();
}

class _Card_CarState extends State<Card_Car> {

  late String _nombre;
  late String _descripcion;
  late int _precio;
  late String _imagen;
/*
  int _counter = 0;
*/
  @override
  void initState() {
    super.initState();
    _nombre = widget.nombre;
    _descripcion = widget.descripcion;
    _precio = widget.precio;
    _imagen = widget.imagen;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 10,
      //color: Color(color_5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$_nombre',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(color_4)
                                ),
                              ),
                            ]
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$_descripcion',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(color_4)
                                ),
                              ),
                            ]
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('$_imagen'),
                          fit: BoxFit.scaleDown,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(color_5)
                      ),
                    ),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(color_5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'MX\$ $_precio',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const productCounter(),
                  ],
                ),

              ],
            )
          ),
        ]
      ),
    );
  }

/*
  void _incrementCounter() {
    setState(() {
      _counter++;
      //print('+ pressed');
    });
  }

  void _decrementCounter() {
    setState(() {
      if(_counter > 0){
        _counter--;
      }
      //print('- pressed');
    });
  }
*/

}


// Contador de productos
class productCounter extends StatefulWidget {
  const productCounter({super.key});

  @override
  State<productCounter> createState() => _productCounterState();
}

class _productCounterState extends State<productCounter> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      //print('+ pressed');
    });
  }

  void _decrementCounter() {
    setState(() {
      if(_counter > 0){
        _counter--;
      }
      //print('- pressed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: Color(color_5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Color(color_8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.remove,
                color: Color(color_4),
                size: 15,
              ),
              onPressed: () {
                _decrementCounter();
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              '$_counter',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
            ),
          ),

          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Color(color_7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Color(color_4),
                size: 15,
              ),
              onPressed: () {
                _incrementCounter();
              },
            ),
          ),
        ],
      ),
    );
  }
}


// Carrito Ordenar

class Card_Car_Order extends StatefulWidget {

  final int total;

  const Card_Car_Order({super.key, required this.total});

  @override
  State<Card_Car_Order> createState() => _Card_Car_OrderState();
}

class _Card_Car_OrderState extends State<Card_Car_Order> {

  late int _total;

  @override
  void initState() {
    super.initState();
    _total = widget.total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 10,
      //color: Color(color_5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.price_change_sharp,
                            size: 60,
                            color: Color(color_7),
                          ),
                          const VerticalDivider(),
                          Text("MX\$ $_total"),
                        ],
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(color_8), Color(color_7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Color(color_4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Ordenar",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            )
          ),
        ]
      ),
    );
  }
}


// Home Grafica
class Card_Home_Chart extends StatefulWidget {
  const Card_Home_Chart({super.key});

  @override
  State<Card_Home_Chart> createState() => _Card_Home_ChartState();
}

class _Card_Home_ChartState extends State<Card_Home_Chart> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      //elevation: 0,
      color: Color(color_5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 50,
                  left: (screenWidth / 2) - 120,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '32',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'productos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'comprados a',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'la semana',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 100,
                      sections: sectionsChartUser),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Burrito',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(color_4),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'Gordita',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(color_4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'Sandwitch',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(color_4),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.purple,
                            ),
                          ),
                          Text(
                            'Hamburguesa',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(color_4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

// Home Gastado
class Card_Home_Gastado extends StatelessWidget {
  final int gastado;
  const Card_Home_Gastado({super.key, required this.gastado});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'MXN \$$gastado',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(color_4),
          ),
        ),
        Text(
          'Gastados en la semana',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(color_4),
          ),
        ),
      ],
    );
  }
}



// Pedidos Acordion
class Card_Pedidos_Accordion extends StatefulWidget {
  final String nombreAlumno;
  final String orden;
  final String fecha;
  final String hora;
  /*
  final String nombreProducto;
  final int cantidadProducto;
  */
  final int total;
  final Map<String, Map<String, dynamic>> productos;


  const Card_Pedidos_Accordion({super.key, required this.nombreAlumno, required this.orden, required this.fecha, required this.hora, required this.productos, /*required this.nombreProducto, required this.cantidadProducto,*/ required this.total});

  @override
  State<Card_Pedidos_Accordion> createState() => _Card_Pedidos_AccordionState();
}

class _Card_Pedidos_AccordionState extends State<Card_Pedidos_Accordion> {
  bool _isExpanded = false;

  late String _nombreAlumno;
  late String _orden;
  late String _fecha;
  late String _hora;
  late Map<String, Map<String, dynamic>> _productos;
  /*
  late String _nombreProducto;
  late int _cantidadProducto;
  */
  late int _total;

  @override
  void initState() {
    super.initState();
    _nombreAlumno = widget.nombreAlumno;
    _orden = widget.orden;
    _fecha = widget.fecha;
    _hora = widget.hora;
    _productos = widget.productos;
    /*
    _nombreProducto = widget.nombreProducto;
    _cantidadProducto = widget.cantidadProducto;
    */
    _total = widget.total;
  }

  @override
  Widget build(BuildContext context) {
/*
    print(_productos['producto2']);
    print(_productos['producto1']);
*/

    return Card(
      //elevation: 10,
      //color: Color(color_5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              foregroundColor: Color(color_4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$_nombreAlumno'),
                                Text('$_orden'),
                              ],
                            ),
                            Row(
                              children: [
                                VerticalDivider(
                                  color: Colors.grey[400],
                                  thickness: 2,
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$_fecha'),
                                    Text('$_hora'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 30,
                    ),
                  ],
                ),
                _isExpanded ?
                Divider(
                  color: Colors.grey[400],
                  thickness: 2,
                  height: 0,
                )
                : const SizedBox.shrink(),

                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 150),
                  crossFadeState:
                      _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: const SizedBox.shrink(),
                  secondChild:Container(
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${_productos['producto1']!['nombreProducto']}'),
                                  const Divider(height: 5),
                                  Text('${_productos['producto2']!['nombreProducto']}'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('MX\$ ${_productos['producto1']!['cantidadProducto']}'),
                                  const Divider(height: 5),
                                  Text('MX\$ ${_productos['producto2']!['cantidadProducto']}'),
                                ],
                              ),

                              /*
                                ListView.builder (
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _productos.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Text('${_productos['nombreProducto${index+1}']}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Text('${_productos['cantidadProducto${index+1}']}'),
                                          ],
                                        ),
                                      ]
                                    );
                                  },
                                ),
                              */

                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(color_5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'MX\$ $_total',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

/*
                _isExpanded
                  ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${_productos['producto1']!['nombreProducto']}'),
                                  Text('${_productos['producto2']!['nombreProducto']}'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('MX\$ ${_productos['producto1']!['cantidadProducto']}'),
                                  Text('MX\$ ${_productos['producto2']!['cantidadProducto']}'),
                                ],
                              ),

                              /*
                                ListView.builder (
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _productos.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Text('${_productos['nombreProducto${index+1}']}'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Text('${_productos['cantidadProducto${index+1}']}'),
                                          ],
                                        ),
                                      ]
                                    );
                                  },
                                ),
                              */

                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(color_5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'MX\$ $_total',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : const SizedBox.shrink(),
                  */
              ],
            )
          ),
        ]
      ),
    );
  }
}


/*
class _Card_Pedidos_AccordionState extends State<Card_Pedidos_Accordion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 30,
              ),
            ],
          ),
        ),
        _isExpanded
            ? Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  widget.content,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
*/


//FINAL