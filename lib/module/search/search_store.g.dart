// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStoreBase, Store {
  Computed<String>? _$searchComputed;

  @override
  String get search => (_$searchComputed ??=
          Computed<String>(() => super.search, name: '_SearchStoreBase.search'))
      .value;
  Computed<List<UserModel>>? _$listUserComputed;

  @override
  List<UserModel> get listUser =>
      (_$listUserComputed ??= Computed<List<UserModel>>(() => super.listUser,
              name: '_SearchStoreBase.listUser'))
          .value;
  Computed<List<UserModel>>? _$listUserSelectedComputed;

  @override
  List<UserModel> get listUserSelected => (_$listUserSelectedComputed ??=
          Computed<List<UserModel>>(() => super.listUserSelected,
              name: '_SearchStoreBase.listUserSelected'))
      .value;

  late final _$_searchAtom =
      Atom(name: '_SearchStoreBase._search', context: context);

  @override
  String get _search {
    _$_searchAtom.reportRead();
    return super._search;
  }

  @override
  set _search(String value) {
    _$_searchAtom.reportWrite(value, super._search, () {
      super._search = value;
    });
  }

  late final _$_listUserAtom =
      Atom(name: '_SearchStoreBase._listUser', context: context);

  @override
  ObservableList<UserModel> get _listUser {
    _$_listUserAtom.reportRead();
    return super._listUser;
  }

  @override
  set _listUser(ObservableList<UserModel> value) {
    _$_listUserAtom.reportWrite(value, super._listUser, () {
      super._listUser = value;
    });
  }

  late final _$_listUserSelectedAtom =
      Atom(name: '_SearchStoreBase._listUserSelected', context: context);

  @override
  ObservableSet<UserModel> get _listUserSelected {
    _$_listUserSelectedAtom.reportRead();
    return super._listUserSelected;
  }

  @override
  set _listUserSelected(ObservableSet<UserModel> value) {
    _$_listUserSelectedAtom.reportWrite(value, super._listUserSelected, () {
      super._listUserSelected = value;
    });
  }

  late final _$_requestAllUsersAsyncAction =
      AsyncAction('_SearchStoreBase._requestAllUsers', context: context);

  @override
  Future<void> _requestAllUsers() {
    return _$_requestAllUsersAsyncAction.run(() => super._requestAllUsers());
  }

  late final _$_SearchStoreBaseActionController =
      ActionController(name: '_SearchStoreBase', context: context);

  @override
  void setSearch(String search) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.setSearch');
    try {
      return super.setSearch(search);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addUserSelected(UserModel user) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.addUserSelected');
    try {
      return super.addUserSelected(user);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeUserSelected(UserModel user) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.removeUserSelected');
    try {
      return super.removeUserSelected(user);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
listUser: ${listUser},
listUserSelected: ${listUserSelected}
    ''';
  }
}
