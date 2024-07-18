import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: UjianPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[900],
    ),
  ));
}

class UjianPage extends StatefulWidget {
  @override
  _UjianPageState createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianPage> {
  int _jumlahUjian = 0; // Variabel untuk menyimpan jumlah ujian
  List<TextEditingController> _namaMataKuliahControllers = [];
  List<TextEditingController> _tanggalUjianControllers = [];
  List<TextEditingController> _lokasiUjianControllers = [];
  List<TextEditingController> _namaDosenControllers = [];
  DateTime? _selectedDate;

  @override
  void dispose() {
    for (var controller in _namaMataKuliahControllers) {
      controller.dispose();
    }
    for (var controller in _tanggalUjianControllers) {
      controller.dispose();
    }
    for (var controller in _lokasiUjianControllers) {
      controller.dispose();
    }
    for (var controller in _namaDosenControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Ujian'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Ujian:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _jumlahUjian = int.tryParse(value) ?? 0;
                          _namaMataKuliahControllers.clear();
                          _tanggalUjianControllers.clear();
                          _lokasiUjianControllers.clear();
                          _namaDosenControllers.clear();
                          for (int i = 0; i < _jumlahUjian; i++) {
                            _namaMataKuliahControllers.add(TextEditingController());
                            _tanggalUjianControllers.add(TextEditingController());
                            _lokasiUjianControllers.add(TextEditingController());
                            _namaDosenControllers.add(TextEditingController());
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jumlah Ujian',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.format_list_numbered, color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Tambah Jadwal Ujian:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 10.0),
              Column(
                children: List.generate(
                  _jumlahUjian,
                  (index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ujian ${index + 1}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _namaMataKuliahControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Nama Mata Kuliah',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.book, color: Colors.blue[900]),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              _selectDate(context, index);
                            },
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _tanggalUjianControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Tanggal Ujian',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.calendar_today, color: Colors.blue[900]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _lokasiUjianControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Lokasi Ujian',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.location_on, color: Colors.blue[900]),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _namaDosenControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Nama Dosen',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person, color: Colors.blue[900]),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  List<Map<String, String>> jadwalUjian = [];
                  for (int i = 0; i < _jumlahUjian; i++) {
                    jadwalUjian.add({
                      'Nama Mata Kuliah': _namaMataKuliahControllers[i].text,
                      'Tanggal Ujian': _tanggalUjianControllers[i].text,
                      'Lokasi Ujian': _lokasiUjianControllers[i].text,
                      'Nama Dosen': _namaDosenControllers[i].text,
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutputPage(jadwalUjian: jadwalUjian),
                    ),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Tambah',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _tanggalUjianControllers[index].text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
  }
}

class OutputPage extends StatelessWidget {
  final List<Map<String, String>> jadwalUjian;

  OutputPage({required this.jadwalUjian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Ujian'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: jadwalUjian.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ujian ${index + 1}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          ...jadwalUjian[index].entries.map((entry) {
                            return Text('${entry.key}: ${entry.value}');
                          }).toList(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Logic to add to calendar
                            },
                            icon: Icon(Icons.calendar_today, color: Colors.white),
                            label: Text(
                              'Tambah ke Kalender',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
