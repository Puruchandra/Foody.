import 'package:first_app/scoped-model/connection_model.dart';
import 'package:scoped_model/scoped_model.dart';


class MainModel extends Model with ProductScopedModel, UserScopedModel, ConnectionModel {
}