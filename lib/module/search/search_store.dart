// ignore_for_file: prefer_final_fields

import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'search_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  _SearchStoreBase() {
    _requestAllUsers();
  }

  @observable
  String _search = '';

  @computed
  String get search => _search;

  @action
  void setSearch(String search) {
    _search = search;
  }

  @observable
  ObservableList<UserModel> _listUser = <UserModel>[].asObservable();

  @computed
  List<UserModel> get listUser {
    final temp = <UserModel>[];
    for (var element in _listUser) {
      if (element.nickname.contains(search) || element.registry.contains(search)) {
        temp.add(element);
      }
    }

    return temp;
  }

  @action
  Future<void> _requestAllUsers() async {
    final List users = await Rest.get(path: '/users');

    _listUser.clear();
    for (var element in users) {
      final user = UserModel.fromMap(element);
      if (user.registry == GetIt.instance.get<UserModel>().registry) continue;
      _listUser.add(user);
    }
  }
}
