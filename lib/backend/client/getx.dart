// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:rescuesync/backend/client/auth.dart';

class UserController extends GetxController {
  var role = 'Loading...'.obs;
  var invite = 'Loading...'.obs;
  var room = 'Loading...'.obs;
  var changedRoom = 'Loading...'.obs;
  var changedInvite = 'Loading...'.obs;
  var users = ''.obs;
  final Auth _auth = Auth();

  Future<void> fetchRole(String username) async {
    String fetchedRole =
        await _auth.auth(username: username, action: 'getRole');
    // print('Role Fetch Yanıtı: $fetchedRole'); // Yanıtı terminale yazdır
    role.value = fetchedRole.isNotEmpty ? fetchedRole : 'None.';
  }

  Future<void> fetchInvite(String username) async {
    String fetchedInvite =
        await _auth.auth(username: username, action: 'getInvite');
    // print('Invite Fetch Yanıtı: $fetchedInvite'); // Yanıtı terminale yazdır
    invite.value = fetchedInvite.isNotEmpty ? fetchedInvite : 'None';
  }

  Future<void> fetchRoom(String username) async {
    String fetchedInvite =
        await _auth.auth(username: username, action: 'getRoom');
   // print('Room Fetch Yanıtı: $fetchedInvite'); // Yanıtı terminale yazdır
    room.value = fetchedInvite.isNotEmpty ? fetchedInvite : 'None';
  }

  Future<String> joinRoom(String username, String room) async {
    String changedNewRoom =
        await _auth.auth(username: username, action: 'changeRoom', room: room);
   // print('Kullanıcı odası değişikliği yanıtı: $changedNewRoom');
    if (changedNewRoom == 'true') {
      // Backend 'true' dönerse
      changedRoom.value = 'Room joined successfully';
    } else if (changedNewRoom == 'An error occurred.') {
      changedRoom.value = 'Sunucu kaynaklı bir hata oluştu, üzgünüm.';
    } else if (changedNewRoom ==
            'Exception: ClientException with SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 185.254.28.25, port = 35506, uri=http://185.254.28.25/rescuesync/process' ||
        changedNewRoom ==
            ' Exception: ClientException with SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 185.254.28.25, port = 35506, uri=http://185.254.28.25/rescuesync/process') {
      changedRoom.value = 'Lütfen internet bağlantınızı kontrol ediniz';
    } else {
      changedRoom.value = changedNewRoom; // Gelen hatayı aktar
    }

    return changedRoom.value;
  }

  Future<List<Map<String, String>>> getUsers(
      String username, String room) async {
    dynamic fetchedUsers =
        await _auth.auth(username: username, action: 'getUsers', room: room);
   // print('Kullanıcılar: $fetchedUsers'); // Gelen veriyi kontrol edin

    if (fetchedUsers is List) {
      try {
        return fetchedUsers
            .map((user) => {
                  'username': user['username'].toString(),
                  'role': user['role'].toString(),
                })
            .toList();
      } catch (e) {
        // print('JSON Decode Hatası: $e');
        throw Exception('JSON Decode Hatası');
      }
    } else {
      // print('Hata: Geçersiz veri formatı. Data: $fetchedUsers');
      return [];
    }
  }

    Future<void> changeInvite(String username, String room) async {
    String fetchedInvite =
        await _auth.auth(username: username, action: 'changeInvite', room: room);
    // print('Invite Fetch Yanıtı: $fetchedInvite'); // Yanıtı terminale yazdır
    changedInvite.value = fetchedInvite.isNotEmpty ? fetchedInvite : 'None';
  }
}


