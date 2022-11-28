import 'package:hive_flutter/hive_flutter.dart';
import 'package:timero/current_user/data/current_user.dart';

class CurrentUserRepository {
  CurrentUserRepository(
    this.currentUserBox,
  );

  final Box<CurrentUser> currentUserBox;

  CurrentUser get currentUser =>
      currentUserBox.get('user', defaultValue: CurrentUser.loggedOut())!;
  Stream<CurrentUser> get currentUserStream =>
      currentUserBox.watch(key: 'user').map((event) {
        final user = event.value;
        return user ?? CurrentUser.loggedOut();
      });

  void set(CurrentUser user) {
    currentUserBox.put('user', user);
  }

  void logOut() {
    currentUserBox.delete('user');
  }

  void deleteCurrentUser() {
    currentUserBox.delete('user');
  }
}
