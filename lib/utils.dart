import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all = [email, browser1, browser2, whatsapp];

  static const email = 'write email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
  static const whatsapp = 'write whatsapp';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.email)) {
      final body = _getTextAfterCommand(text: text, command: Command.email);

      openEmail(body: body);
    }

    if (text.contains(Command.browser1)) {
      final site = _getTextAfterCommand(text: text, command: Command.browser1);

      openBrowser(site: site);
    }
    if (text.contains(Command.browser2)) {
      final site = _getTextAfterCommand(text: text, command: Command.browser2);

      openBrowser(site: site);
    }
    if (text.contains(Command.whatsapp)) {
      final message = _getTextAfterCommand(text: text, command: Command.whatsapp);

      openWhatsApp(message: message);
    }
  }

  static String _getTextAfterCommand({
    @required String text,
    @required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future openEmail({
    @required String body,
  }) async {
    final url = 'mailto:?body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  static Future openBrowser({
    @required String site,
  }) async {
    if (site.trim().isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl("https://$site");
    }
  }

  static Future openWhatsApp({
    @required String message,
  }) async {
    await _launchUrl("https://wa.me/+6289531039862/?text=${Uri.parse(message)}");
    // if (site.trim().isEmpty) {
    //   await _launchUrl('https://google.com');
    // } else {
    //   await _launchUrl("https://$site");
    // }
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {

      await launch(url);
    }
  }
}
