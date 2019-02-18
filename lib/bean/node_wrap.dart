import 'package:dwarf_doc/http/node_resp.dart';
import 'package:dwarf_doc/util/logger.dart';
import 'package:dwarf_doc/util/string_utils.dart';

class NodeWrap {
  static final String TAG = 'NodeWrap';
  String title;
  String header;
  String footer;
  int id;
  int topics;
  NodeResp resp;

  NodeWrap(NodeResp resp) {
    title = StringUtils.safeString(resp.title);
    header = StringUtils.safeString(resp.header);
    footer = StringUtils.safeString(resp.footer);
    Logger.d(TAG, "title: " + title);
    Logger.d(TAG, "header: " + header);
    Logger.d(TAG, "footer: " + footer);

    id = resp.id;
    topics = resp.topics;
    this.resp = resp;
  }
}
