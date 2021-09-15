// ignore: import_of_legacy_library_into_null_safe
import 'package:hasura/hasura.dart';
import 'package:sr_paia/app/model/animais/animais_model.dart';

class AnimaisRepository {
 final HasuraConnect _hasuraConnect;

  AnimaisRepository(this._hasuraConnect);

  Future<List<AnimaisModel>> getAnimais() async {
    List<AnimaisModel> listAnimais = [];
    AnimaisModel animaisModel;
    var query = '''
      query MyQuery {
  Cachorro {
    Id_cachorro
    Nome
    Raca
    Cor
    Sexo
    Descricao
  }
}
    ''';

    var snapshot = await _hasuraConnect.query(query);
    for (var json in (snapshot['data']['animais']) as List) {
      animaisModel = AnimaisModel.fromJson(json);
      listAnimais.add(animaisModel);
    }
    return listAnimais;
  }
  
  // novo método adicionado
  Future<String> addAnimais(String name, String raca, String cor, String sexo, String descricao) async {
    var query = """
      mutation addAnimais(\$name:String!, \$raca:String!, \$cor:String!, \$sexo:String!, \$description:String!) {
      insert_animais(objects: {name: \$name, raca: \$raca, cor: \$cor, sexo: \$sexo, descricao: \$descricao}) {
        affected_rows
        returning {
          name
        }
      }
    }
    """;
    var data = await _hasuraConnect.mutation(query, variables: {
      "name": name,
      "raca": raca,
      "cor": cor,
      "sexo": sexo,
      "descricao": descricao,
    });
    return data["data"]['insert_animais']['returning'][0]['name'];
  }
}