import 'dart:async';

import 'package:image_picker/image_picker.dart';

import '../../../../common_widgets/avatar.dart';
import '../../../../common_widgets/loading_stack_body.dart';
import '../../../../constants/resources.dart';
import '../../application/profile_service.dart';
import '../../domain/app_user.dart';
import '../../domain/profile.dart';
import 'profile_screen_controller.dart';
import 'profile_text_field.dart';

class ProfileSubmitForm extends StatefulHookConsumerWidget {
  const ProfileSubmitForm(this.user, {super.key});
  final AppUser user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileSubmitFormState();
}

class _ProfileSubmitFormState extends ConsumerState<ProfileSubmitForm> {
  final _formKey = GlobalKey<FormState>();
  AppUser get user => widget.user;
  List<Profile> profiles = [];

  File? _pickedImage;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    if (user.profiles.isNotEmpty) {
      profiles = user.profiles.toList();
      logger.i('profiles: ${profiles.toString()}');
    }
  }

  Future<void> submit() async {
    try {
      setState(() => _submitted = true);
      if (_formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();
        final controller = ref.read(profileScreenControllerProvider.notifier);
        final profileService = ref.watch(profileServiceProvider);
        await controller.updatProfile(
          user.copyWith(
            profiles: [
              user.profiles.isNotEmpty
                  ? user.profiles[0].copyWith(
                      nickname: profileService.nicknameEditingCtr.text,
                      aboutMe: profileService.aboutMeEditingCtr.text)
                  : Profile(
                      nickname: profileService.nicknameEditingCtr.text,
                      aboutMe: profileService.aboutMeEditingCtr.text)
            ],
          ),
        );
      }
    } catch (e) {
      logger.e('_submit e: $e');
    }
  }

  Future<void> _pickProfileImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
      );
      if (pickedFile != null) {
        setState(() => _pickedImage = File(pickedFile.path));

        await ref
            .read(profileScreenControllerProvider.notifier)
            .uploadProfileImage(
              user: user,
              filePath: _pickedImage!.path,
            );
        _pickedImage = null;
      }
    } catch (e) {
      logger.e('_pickProfileImage e: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      profileScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(profileScreenControllerProvider);
    final profileService = ref.watch(profileServiceProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: LoadingStackBody(
        isLoading: state.isLoading,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH24,
              Center(
                child: _pickedImage?.path != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        foregroundImage: FileImage(File(_pickedImage!.path)),
                      )
                    : Avatar(
                        radius: 80,
                        imageFilePath: _pickedImage?.path,
                        photoUrl: user.profiles.isNotEmpty
                            ? user.profiles[0].photoUrls[0]
                            : null,
                        onTap: _pickProfileImage,
                      ),
              ),
              gapH24,
              Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus && !state.isLoading) submit();
                },
                child: ProfileTextField(
                  submitted: _submitted,
                  initialValue: profiles.isNotEmpty ? profiles[0].nickname : '',
                  labelText: 'Nickname',
                  controller: profileService.nicknameEditingCtr,
                ),
              ),
              gapH24,
              Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus && !state.isLoading) submit();
                },
                child: ProfileTextField(
                  submitted: _submitted,
                  initialValue: profiles.isNotEmpty ? profiles[0].aboutMe : '',
                  labelText: 'About Me',
                  controller: profileService.aboutMeEditingCtr,
                  maxLines: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
