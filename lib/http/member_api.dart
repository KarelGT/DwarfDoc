import 'package:dwarf_doc/http/http_module.dart';
import 'package:dwarf_doc/http/member_resp.dart';

class MemberApi {
  HttpModule _httpModule;

  MemberApi(this._httpModule);

  Future<MemberResp> queryUserByName(String username) async {
    Map respone = await _httpModule.get('/api/members/show.json',
        params: <String, String>{'username': username});
    MemberResp resp = MemberResp.fromJson(respone);
    return resp;
  }
}
