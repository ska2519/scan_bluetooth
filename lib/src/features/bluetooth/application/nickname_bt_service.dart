import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/nickname_bt_repo.dart';
import '../domain/nickname.dart';

final nicknameBTServiceProvider =
    Provider<NicknameBTService>(NicknameBTService.new);

class NicknameBTService {
  NicknameBTService(this.ref);
  final Ref ref;

  Future<void> updateNickname({
    required String deviceId,
    required Nickname nickname,
  }) async {
    await ref.read(nickNameBluetoothRepoProvider).updateNickname(
          deviceId: deviceId,
          nickname: nickname,
        );

    // TODO: 이게 꼭 필요한지 고민해보자 예)주위에 블루투스가 하나도 없을 때
    //본인 폰도 안잡힐때 리스트가 리셋이 될까?
  }
}
