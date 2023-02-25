import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:weather/app/data/model/provinci_model.dart';
import 'package:weather/app/data/model/citiy_model.dart';
import '../controllers/home_controller.dart';
import 'package:dio/dio.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check Ongkos Kirim'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            DropdownSearch<Provinci?>(
              itemAsString: (item) => "${item!.province}",
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Pilih Provinsi"),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {
                    "key": "9777b9232689716dc4df5dd0cacba63b",
                  },
                );

                return Provinci.fromJSONList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.provId.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<City?>(
              itemAsString: (item) => "${item!.type} ${item.cityName}",
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Pilih Kota"),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?&province=${controller.provId}",
                  queryParameters: {
                    "key": "9777b9232689716dc4df5dd0cacba63b",
                  },
                );
                return City.fromJSONList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.cityId.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<Provinci?>(
              itemAsString: (item) => "${item!.province}",
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Pilih Provinsi Tujuan"),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {
                    "key": "9777b9232689716dc4df5dd0cacba63b",
                  },
                );

                return Provinci.fromJSONList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.provToId.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<City?>(
              itemAsString: (item) => "${item!.type} ${item.cityName}",
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Pilih Kota Tujuan"),
                ),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?&province=${controller.provToId}",
                  queryParameters: {
                    "key": "9777b9232689716dc4df5dd0cacba63b",
                  },
                );
                return City.fromJSONList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.cityToId.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.beratC,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Berat",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch(
              items: ["jne", "pos", "tiki"],
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Pilih Kurir"),
                ),
              ),
              onChanged: (value) => controller.kurir = value!,
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.CheckOngkir();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? "Check Ongkos Kirim"
                    : "Loading"))),
          ],
        ));
  }
}
