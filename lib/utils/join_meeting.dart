import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

joinMeeting(nextClass) async {
  final base64Decoded = base64.decode(base64.normalize(
      nextClass!.studentMeetingLink.split('token=')[1].split('.')[1]));
  final urlObject = utf8.decode(base64Decoded);
  final jsonRes = json.decode(urlObject);
  final String roomId = jsonRes['room'];
  final String tokenMeeting = nextClass!.studentMeetingLink.split('token=')[1];

  Map<String, Object> featureFlags = {};

  var options = JitsiMeetingOptions(
    roomNameOrUrl: roomId,
    serverUrl: 'https://meet.lettutor.com',
    //subject: subjectText.text,
    token: tokenMeeting,
    isAudioMuted: true,
    isAudioOnly: false,
    isVideoMuted: true,
    //userDisplayName: userDisplayNameText.text,
    //userEmail: userEmailText.text,
    featureFlags: featureFlags,
  );

  await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
  );
}
