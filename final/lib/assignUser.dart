import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'applicationState.dart';

class UserElement {
  const UserElement({
    required this.userId,
    required this.name,
    required this.email,
    required this.statusMessage,
    required this.path,
  });

  final String userId ;
  final String name ;
  final String email ;
  final String statusMessage ;
  final String path ;

  static UserElement reset() {
    return const UserElement(
      userId: '',
      name: '',
      email: '',
      statusMessage: '',
      path: '',
    );
  }
}

class AssignUser extends StatefulWidget{
  const AssignUser({
    required this.assignUser,
  });

  final UserElement assignUser;

  @override
  _AssignUserState createState() => _AssignUserState();
}

class _AssignUserState extends State<AssignUser> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.only(left: 90.0, right: 90, bottom: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    widget.assignUser.path,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Text(
                '<${widget.assignUser.userId}>',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const Divider(
                height: 30,
                thickness: 1,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                widget.assignUser.email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                widget.assignUser.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Consumer<ApplicationState>(
                builder: (context, appState, _) => EditStatusMessage(
                  state: appState.editProfile,
                  statusMessage: widget.assignUser.statusMessage,
                  onEdit: appState.onEdit,
                  editStatusMessage: (statusMessage) => appState.editStatusMessage(statusMessage),
                  statusMessageController: TextEditingController(text: widget.assignUser.statusMessage),
                  scrollController: _scrollController,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditStatusMessage extends StatelessWidget {
  const EditStatusMessage({required this.state, required this.statusMessage, required this.onEdit, required this.editStatusMessage, required this.statusMessageController, required this.scrollController});
  final bool state;
  final String statusMessage ;
  final void Function() onEdit;
  final FutureOr<void> Function(String statusMessage) editStatusMessage;
  final TextEditingController statusMessageController;
  final ScrollController scrollController;

  void upDownScroll(double size){
    scrollController.animateTo(size,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease
    );
  }

  @override
  Widget build(BuildContext context) {
    return
    state ?
    Column(
      children: [
        TextField(
          controller: statusMessageController,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          minLines: 1,
          maxLines: 5,
          onTap: () => upDownScroll(200),
          onEditingComplete: () => upDownScroll(-200),
        ),
        ButtonBar(
          buttonPadding: EdgeInsets.zero,
          alignment: MainAxisAlignment.start,
          children : [
            TextButton(
              onPressed: () => {
                onEdit(),
                upDownScroll(-200),
                editStatusMessage(statusMessageController.text),
              },
              child: const Text('save'),
            ),
          ],
        )
      ],
    ) :
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            statusMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 5,
          ),
        ),
        ButtonBar(
          buttonPadding: EdgeInsets.zero,
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () => {
                onEdit()
              },
              child: const Text('edit'),
            ),
          ],
        )
      ],
    ) ;
  }
}