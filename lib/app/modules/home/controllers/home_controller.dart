import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:ongkir/app/data/model/ongkir_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxString provId = "0".obs;
  RxString cityId = "0".obs;
  RxString provToId = "0".obs;
  RxString cityToId = "0".obs;
  String kurir = "";

  List<OngkirModel> hasil = [];

  TextEditingController beratC = TextEditingController();

  void CheckOngkir() async {
    if (provId != "0" &&
        cityId != "0" &&
        provToId != "0" &&
        cityToId != "0" &&
        beratC.text != "") {
      try {
        isLoading.value = true;
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {
            "key": "9777b9232689716dc4df5dd0cacba63b",
            "content-type": "application/x-www-form-urlencoded"
          },
          body: {
            "origin": cityId.value,
            "destination": cityToId.value,
            "weight": beratC.text,
            "courier": kurir,
          },
        );
        isLoading.value = false;
        List rajaongkir = jsonDecode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        hasil = OngkirModel.fromJSONList(rajaongkir);

        Get.defaultDialog(
            title: "Ongkos Kirim",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hasil
                    .map((text) => ListTile(
                          title: Text("${text.service}"),
                          subtitle: Text("${text.cost![0].value}"),
                        ))
                    .first,
                hasil
                    .map((text) => ListTile(
                          title: Text("${text.service}"),
                          subtitle: Text("${text.cost![0].value}"),
                        ))
                    .elementAt(1),
                hasil
                    .map((text) => ListTile(
                          title: Text("${text.service}"),
                          subtitle: Text("${text.cost![0].value}"),
                        ))
                    .last,
                // hasil
                //     .map((text) => ListTile(
                //           title: Text("${text.service}"),
                //           subtitle: Text("${text.cost![0].value}"),
                //         ))
                //     .single
              ],
            ));
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Tidak dapat mengecheck ongkos kirim");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Lengkapi data terlebih dahulu!");
    }
  }
}
