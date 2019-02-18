import 'dart:async';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/member_wrap.dart';
import 'package:dwarf_doc/http/member_api.dart';
import 'package:dwarf_doc/page/member_contract.dart' as MemberContract;

class MemberPresenter implements MemberContract.Presenter {
  MemberContract.View _view;
  String _username;
  MemberApi _memberApi;
  StreamSubscription _memberSubscription;

  MemberPresenter(this._view, this._username) {
    _memberApi = MemberApi(Application.getInstance().httpModule);
  }

  @override
  void start() {
    _memberSubscription = _fetchMember(_username)
        .asStream()
        .listen((memberWrap) => _view.displayUser(memberWrap));
  }

  Future<MemberWrap> _fetchMember(String username) async {
    return _memberApi
        .queryUserByName(_username)
        .then((value) => MemberWrap(value));
  }

  @override
  void detach() {
    if (_memberSubscription != null) {
      _memberSubscription.cancel();
    }
  }
}
