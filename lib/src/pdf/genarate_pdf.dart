import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:http/http.dart' show get;
import 'package:servicemangerapp/src/data/model/service_order_new.dart';
import 'package:servicemangerapp/src/utils/utils.dart';

class GeneratePdf {
  ServiceOrderCar serviceOrderCar;
  GeneratePdf({required this.serviceOrderCar});

  Future<List<MemoryImage>> listImages() async {
    List<MemoryImage> _list = [];
    for (var path in serviceOrderCar.pathImages) {
      if (path.isNotEmpty) {
        var response = await get(Uri.parse(path));
        var data = response.bodyBytes;
        final image = MemoryImage(data);
        _list.add(image);
      }
    }
    return _list;
  }

  Future<File> createPdf() async {
    var url = serviceOrderCar.pathSign;
    var response = await get(Uri.parse(url));
    var data = response.bodyBytes;
    final imageSing = MemoryImage(data);
    PdfPageFormat pdfPageFormat = PdfPageFormat.a4.copyWith(
        marginBottom: 10, marginLeft: 10, marginRight: 10, marginTop: 10);

    List<MemoryImage> listMemoryImagem = await listImages();

    MemoryImage imageLogo = MemoryImage(
        (await rootBundle.load('lib/assets/logo-funilaria.png'))
            .buffer
            .asUint8List());

    MemoryImage imageSignRamon = MemoryImage(
        (await rootBundle.load('lib/assets/assinatura-ramon.png'))
            .buffer
            .asUint8List());

    final pdf = Document();
    pdf.addPage(
      index: 0,
      Page(
        pageFormat: pdfPageFormat,
        build: (context) {
          return Container(
            margin: EdgeInsets.all(20),
            // height: context.page.pageFormat.availableHeight,
            // width: context.page.pageFormat.availableWidth,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Finularia Esperança'),
                        Text('Reparos de Funilaria'),
                        Text(
                            'Rua Hipólito Trigo Santiago, 373 - Jd. Cruzeiro - Franco da Rocha - SP'),
                        Text('(11) 96950-5655'),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image(imageLogo),
                    )
                  ],
                ),
                Divider(),
                Center(
                    child: Text('ORDEM DE SERVIÇO: ${serviceOrderCar.id}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DADOS DO CLIENTE'),
                    Text('Nome: ${serviceOrderCar.client.name}'),
                    Text('Telefone: ${serviceOrderCar.client.phone}'),
                    Text('Email: ${serviceOrderCar.client.email}'),
                  ],
                ),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DADOS DO CARRO'),
                    Text('Marca: ${serviceOrderCar.car.brand}'),
                    Text('Modelo: ${serviceOrderCar.car.model}'),
                    Text('Ano: ${serviceOrderCar.car.year}'),
                    Text('Cor: ${serviceOrderCar.car.color}'),
                    Text('Data entrada oficina: ${serviceOrderCar.car.date}'),
                    Text('Defeito relatado: ${serviceOrderCar.description}')
                  ],
                ),
                // Divider(),
                // Text('Fotos do equipamento'),
                // Row(
                //     children: List<Widget>.generate(listMemoryImagem.length,
                //         (int index) {
                //   return Expanded(
                //       child: Container(
                //           height: 100,
                //           margin: const EdgeInsets.all(5),
                //           color: PdfColors.amber,
                //           child: Image(listMemoryImagem[index])));
                // })),
                Divider(),
                Spacer(),
                Center(child: Text('Assinaturas')),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image(imageSing, width: 100, height: 100),
                          ),
                          SizedBox(width: 100, child: Divider()),
                          Text('Cliente: ${serviceOrderCar.client.name}'),
                        ],
                      ), //imageSignRamon
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child:
                                Image(imageSignRamon, width: 100, height: 100),
                          ),
                          SizedBox(width: 100, child: Divider()),
                          Text('Técnico: Beto'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // Column(
          //     children: listMemoryImagem.map((element) {
          //   return Image(element);
          // }).toList()),
        },
      ),
    );

    int i = 1;
    for (var element in listMemoryImagem) {
      pdf.addPage(
          index: i,
          Page(
              pageFormat: pdfPageFormat,
              build: (context) {
                return Image(element);
              }));
      i++;
    }

    final output = await getApplicationCacheDirectory();
    final file = File("${output.path}/exemple.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
