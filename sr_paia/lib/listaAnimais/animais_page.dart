import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sr_paia/listaAnimais/animais_controller.dart';


class AnimaisPage extends GetView<AnimaisController> {
//repository and controller  injection bindings
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animais')),
      body: Container(
        child: GetX<AnimaisController>(
            //initState: (state) {
            //   Get.find<AnimaisController>().getAnimais(); },
            builder: (_) {
              return 
              _.animaisList.length < 1
              ? Center(child: CircularProgressIndicator(),)
              :
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_.animaisList[index].nome),
                    subtitle: Text(_.animaisList[index].raca +  _.animaisList[index].descricao ),
                    onTap: () => controller.toCad_animais( _.animaisList[index].idAnimal),
                  );
                },
                itemCount: _.animaisList.length,
              );
            }),
      ),
    );
  }
}  