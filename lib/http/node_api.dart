import 'package:dwarf_doc/http/http_module.dart';
import 'package:dwarf_doc/http/node_resp.dart';

class NodeApi {
  static final String TAG = 'NodeApi';
  HttpModule httpModule;

  NodeApi(this.httpModule);

  Future<List<NodeResp>> queryAllNodes() async {
    List response = await httpModule.get("/api/nodes/all.json");
    List<NodeResp> resps = response.map((value) => NodeResp.fromJson(value)).toList();
    return resps;
  }
}
