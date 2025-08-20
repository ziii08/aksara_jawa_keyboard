import 'package:flutter/material.dart';
import 'package:in_app_keyboard/in_app_keyboard.dart';
import 'package:scaled_app/scaled_app.dart';

void main() {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) {
      const double widthOfDesign = 400;
      return deviceSize.width / widthOfDesign;
    },
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In App Keyboard Trial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomePage(),
      routes: {
        '/numeric': (context) => NumericKeyboardPage(),
        '/alphanumeric': (context) => AlphanumericKeyboardPage(),
        '/mixed_layout': (context) => MixedLayoutPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In App Keyboard Trial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.keyboard,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 30),
            Text(
              'Pilih Halaman untuk Trial Keyboard',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            _buildNavigationCard(
              context,
              'Numeric Keyboard',
              'Trial keyboard angka saja',
              Icons.numbers,
              Colors.green,
              '/numeric',
            ),
            SizedBox(height: 20),
            _buildNavigationCard(
              context,
              'Alphanumeric Keyboard',
              'Trial keyboard huruf dan angka',
              Icons.keyboard_alt,
              Colors.orange,
              '/alphanumeric',
            ),
            SizedBox(height: 20),
            _buildNavigationCard(
              context,
              'Mixed Layout Keyboard',
              'Trial berbagai layout (English/Arabic)',
              Icons.language,
              Colors.purple,
              '/mixed_layout',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String route,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

// Page 1: Numeric Keyboard Trial
class NumericKeyboardPage extends StatefulWidget {
  @override
  _NumericKeyboardPageState createState() => _NumericKeyboardPageState();
}

class _NumericKeyboardPageState extends State<NumericKeyboardPage> {
  final _priceController = TextEditingController();
  final _priceFocusNode = FocusNode();
  final _quantityController = TextEditingController();
  final _quantityFocusNode = FocusNode();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numeric Keyboard Trial'),
        backgroundColor: Colors.green.withOpacity(0.1),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trial Keyboard Numeric',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Keyboard ini hanya menampilkan angka 0-9. Cocok untuk input harga, jumlah, nomor telepon, dll.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    focusNode: _priceFocusNode,
                    controller: _priceController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Harga (Rp)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _quantityFocusNode,
                    controller: _quantityController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Jumlah',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.inventory),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _phoneFocusNode,
                    controller: _phoneController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Nomor Telepon',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Text('Sembunyikan Keyboard'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _priceController.clear();
                            _quantityController.clear();
                            _phoneController.clear();
                          },
                          child: Text('Clear All'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.blue.withOpacity(0.1),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.navigation, color: Colors.blue[700]),
                              SizedBox(width: 8),
                              Text(
                                'Navigasi ke Halaman Lain:',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700],
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/alphanumeric');
                                  },
                                  icon: Icon(Icons.keyboard_alt, size: 16),
                                  label: Text('Alphanumeric',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/mixed_layout');
                                  },
                                  icon: Icon(Icons.language, size: 16),
                                  label: Text('Mixed Layout',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/',
                                  (route) => false,
                                );
                              },
                              icon: Icon(Icons.home, size: 16),
                              label: Text('Kembali ke Home'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue[700],
                                side: BorderSide(color: Colors.blue[300]!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppKeyboard(
            width: 400,
            focusNodes: [_priceFocusNode, _quantityFocusNode, _phoneFocusNode],
            textControllers: [
              _priceController,
              _quantityController,
              _phoneController
            ],
            keyboardTypes: [
              KeyboardType.Numeric,
              KeyboardType.Numeric,
              KeyboardType.Numeric
            ],
            defaultLayouts: [
              KeyboardDefaultLayouts.English,
              KeyboardDefaultLayouts.English,
              KeyboardDefaultLayouts.English,
            ],
            onShow: (isShow) {
              print('Numeric Keyboard is ${isShow ? 'visible' : 'hidden'}');
            },
          ),
        ],
      ),
    );
  }
}

// Page 2: Alphanumeric Keyboard Trial
class AlphanumericKeyboardPage extends StatefulWidget {
  @override
  _AlphanumericKeyboardPageState createState() =>
      _AlphanumericKeyboardPageState();
}

class _AlphanumericKeyboardPageState extends State<AlphanumericKeyboardPage> {
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _addressController = TextEditingController();
  final _addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphanumeric Keyboard Trial'),
        backgroundColor: Colors.orange.withOpacity(0.1),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trial Keyboard Alphanumeric',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Keyboard ini menampilkan huruf A-Z, angka 0-9, dan karakter @ dan . Cocok untuk input nama, email, alamat, dll.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _addressFocusNode,
                    controller: _addressController,
                    keyboardType: TextInputType.none,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Text('Sembunyikan Keyboard'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _nameController.clear();
                            _emailController.clear();
                            _addressController.clear();
                          },
                          child: Text('Clear All'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.blue.withOpacity(0.1),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.navigation, color: Colors.blue[700]),
                              SizedBox(width: 8),
                              Text(
                                'Navigasi ke Halaman Lain:',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700],
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/numeric');
                                  },
                                  icon: Icon(Icons.numbers, size: 16),
                                  label: Text('Numeric',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/mixed_layout');
                                  },
                                  icon: Icon(Icons.language, size: 16),
                                  label: Text('Mixed Layout',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/',
                                  (route) => false,
                                );
                              },
                              icon: Icon(Icons.home, size: 16),
                              label: Text('Kembali ke Home'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue[700],
                                side: BorderSide(color: Colors.blue[300]!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppKeyboard(
            width: 400,
            focusNodes: [_nameFocusNode, _emailFocusNode, _addressFocusNode],
            textControllers: [
              _nameController,
              _emailController,
              _addressController
            ],
            keyboardTypes: [
              KeyboardType.Alphanumeric,
              KeyboardType.Alphanumeric,
              KeyboardType.Alphanumeric,
            ],
            defaultLayouts: [
              KeyboardDefaultLayouts.English,
              KeyboardDefaultLayouts.English,
              KeyboardDefaultLayouts.English,
            ],
            onShow: (isShow) {
              print(
                  'Alphanumeric Keyboard is ${isShow ? 'visible' : 'hidden'}');
            },
          ),
        ],
      ),
    );
  }
}

// Page 3: Mixed Layout Trial
class MixedLayoutPage extends StatefulWidget {
  @override
  _MixedLayoutPageState createState() => _MixedLayoutPageState();
}

class _MixedLayoutPageState extends State<MixedLayoutPage> {
  final _englishController = TextEditingController();
  final _englishFocusNode = FocusNode();
  final _arabicController = TextEditingController();
  final _arabicFocusNode = FocusNode();
  final _mixedController = TextEditingController();
  final _mixedFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mixed Layout Trial'),
        backgroundColor: Colors.purple.withOpacity(0.1),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trial Mixed Layout Keyboard',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[700],
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Trial keyboard dengan layout berbeda: English, Arabic, dan campuran. Setiap field memiliki layout yang berbeda.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    focusNode: _englishFocusNode,
                    controller: _englishController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'English Layout (Alphanumeric)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.language),
                      suffixText: 'EN',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _arabicFocusNode,
                    controller: _arabicController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Arabic Layout (Alphanumeric)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.translate),
                      suffixText: 'AR',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _mixedFocusNode,
                    controller: _mixedController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'Mixed Input (Numeric)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shuffle),
                      suffixText: 'NUM',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Text('Sembunyikan Keyboard'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _englishController.clear();
                            _arabicController.clear();
                            _mixedController.clear();
                          },
                          child: Text('Clear All'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.blue.withOpacity(0.1),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.navigation, color: Colors.blue[700]),
                              SizedBox(width: 8),
                              Text(
                                'Navigasi ke Halaman Lain:',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700],
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/numeric');
                                  },
                                  icon: Icon(Icons.numbers, size: 16),
                                  label: Text('Numeric',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/alphanumeric');
                                  },
                                  icon: Icon(Icons.keyboard_alt, size: 16),
                                  label: Text('Alphanumeric',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/',
                                  (route) => false,
                                );
                              },
                              icon: Icon(Icons.home, size: 16),
                              label: Text('Kembali ke Home'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue[700],
                                side: BorderSide(color: Colors.blue[300]!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Info Layout:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 8),
                          Text('• Field 1: English Alphanumeric'),
                          Text('• Field 2: Arabic Alphanumeric'),
                          Text('• Field 3: Numeric (English base)'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppKeyboard(
            width: 400,
            focusNodes: [_englishFocusNode, _arabicFocusNode, _mixedFocusNode],
            textControllers: [
              _englishController,
              _arabicController,
              _mixedController
            ],
            keyboardTypes: [
              KeyboardType.Alphanumeric,
              KeyboardType.Alphanumeric,
              KeyboardType.Numeric,
            ],
            defaultLayouts: [
              KeyboardDefaultLayouts.English,
              KeyboardDefaultLayouts.Arabic,
              KeyboardDefaultLayouts.English,
            ],
            onShow: (isShow) {
              print(
                  'Mixed Layout Keyboard is ${isShow ? 'visible' : 'hidden'}');
            },
          ),
        ],
      ),
    );
  }
}
