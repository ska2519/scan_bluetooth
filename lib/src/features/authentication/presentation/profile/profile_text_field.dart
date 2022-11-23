import '../../../../constants/resources.dart';

/// Search field used to filter products by name
class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    super.key,
    this.initialValue,
    this.labelText,
    this.canEdit = true,
    this.maxLines = 1,
    this.onSubmit,
    required this.controller,
    required this.submitted,
  });
  final String? initialValue;
  final String? labelText;
  final bool? canEdit;
  final int? maxLines;
  final TextEditingController controller;
  final bool? submitted;
  final VoidCallback? onSubmit;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  TextEditingController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return Column(
          children: [
            if (widget.labelText != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${widget.labelText}',
                    style: textTheme(context).bodyLarge,
                  ),
                ),
              ),
            gapH4,
            TextFormField(
              enabled: widget.canEdit,
              controller: controller,
              style: Theme.of(context).textTheme.bodyMedium,
              autovalidateMode: widget.submitted!
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              maxLines: widget.maxLines,
              onEditingComplete: widget.onSubmit,
              validator: (text) {
                // if (text == null || text.isEmpty) {
                //   return 'Can\'t be empty';
                // }
                // if (text.length < 3) {
                //   return 'text length should longer than 4 ⌨️';
                // }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                hintText: widget.labelText,
                suffixIcon: value.text.isNotEmpty
                    ? IconButton(
                        onPressed: controller.clear,
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
