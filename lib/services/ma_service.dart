import 'package:ms_service_test/services/model/migraeneanfall.dart';

import 'mabackend_service_provider.dart';
import 'model/object_not_found_exception.dart';

class MAService {
  /* Nutzer */

  Future<List<Migraeneanfall>> getMigraeneanfallList() async {
    return await MABackendServiceProvider.getObjectList<Migraeneanfall>(
        resourcePath: "migraeneanfall", parseBody: migraeneanfallListFromJson);
  }

  Future<Migraeneanfall> getMigraeneanfallById({required int id}) async {
    var result = await MABackendServiceProvider.getObjectById<Migraeneanfall>(
      id: id,
      resourcePath: "migraeneanfall",
      parseBody: migraeneanfallFromJson,
    );

    if (result.isEmpty) {
      throw ObjectNotFoundException();
    }

    return result[0];
  }

  Future<bool> deleteMigraeneanfallById({required int id}) async {
    var result = await MABackendServiceProvider.deleteObjectById(
      id: id,
      resourcePath: "migraeneanfall",
    );
    return result;
  }

}
