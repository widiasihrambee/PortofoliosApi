import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  String url = 'https://api-wikukarno.wikukarno.id/api/portofolios';

  Future getPortofolio() async {
    var response = await http.get(Uri.parse(url));  
    print(json.decode(response.body));
    return json.decode(response.body);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //menambah icon add 
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Portofolios'),
      ),
      body: FutureBuilder(
        future: getPortofolio(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 180,
                    child: Card(
                      elevation: 7,
                      child: Row(
                        children:  [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 120,
                            width: 120,
                            child: Image.network(
                              'https://api-wikukarno.wikukarno.id/storage/' +
                              snapshot.data['data'] [index] ['thumbnail'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        //ubah terlebih dahulu clomn jadi wrap widget lalu ganti Expanded untuk memperbaik overflowed by pixels 
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(                                
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //Align untuk membuat text sejajar jika kekiri
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                         snapshot.data['data'][index]['title'],
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child:  Text(snapshot.data['data'][index]['kategori'],                    
                                  ),
                                  ),                                 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data['data'][index]['url']),
                                      Text(snapshot.data['data'][index]['published']
                                      ),
                                        ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              
          } else {
            return Text("DATA ERROR");
          }
        },
      ),
    );
  }
}