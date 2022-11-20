import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
    
void main() {
    runApp(const MyApp());
}
    
class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);
    
    @override
    _MyAppState createState() => _MyAppState();
}
    
class _MyAppState extends State<MyApp> {
    
    //_get berfungsi untuk menampung data dari internet nanti
    List _get = [];
    
    @override
    void initState() {
        // ignore: todo
        // TODO: implement initState
        super.initState();
        _getData();
    }
    
    //method untuk merequest/mengambil data dari internet
    Future _getData() async {
        try {
          
        final response = await http.get(Uri.parse(
            "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9d8b62b7dc424bc69d925fecaa16dde3"
          )
        );
    
        // cek respon berhasil
        if (response.statusCode == 200) {
    
            final data = jsonDecode(response.body);
    
            setState(() {
                //memasukan data yang di dapat dari internet ke variabel _get
                _get = data['articles'];
            });
          }
        } catch (e) {
          //tampilkan error di terminal
          print(e);
        }
      }
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
    
          //menghilangkan debug label
          debugShowCheckedModeBanner: false,
          home: Scaffold(
    
            
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 73, 125, 221),
              title: Center(
                child: Text(
                  "Berita Terkini",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255)
                  ),
                ),
              ),
            ),
            body: ListView.builder(
              // itemcount adalah total panjang data yang ingin ditampilkan
              // _get.length adalah total panjang data dari data berita yang diambil
              itemCount: _get.length,
    
              // itembuilder adalah bentuk widget yang akan ditampilkan, wajib menggunakan 2 parameter.
              itemBuilder: (context, index){
    
                
                //menggunakan edgeInsets.only untuk membuat jarak hanya pada bagian atas saja
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 20, 
                  ),
    
                  child: ListTile(
                    leading: Image.network(
                      //menampilkan data gamabr
                      _get[index]['urlToImage'] ??  "https://techcrunch.com/wp-content/uploads/2021/11/Gopuff_bag1.jpg?resize=1200,800",
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    title: Text(
                      //menampilkan data judul
                      _get[index]['title'],
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis, 
                    ),
                    subtitle: Text(
                      //menampilkan deskripsi berita
                      _get[index]['description'],
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }, 
            )
          ),
        );
      }
    }
