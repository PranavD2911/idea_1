import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddToGoogleWalletWidget extends StatelessWidget {
  const AddToGoogleWalletWidget({super.key});

  @override
  Widget build(BuildContext context) => AddToGoogleWalletButton(
        pass: _examplePass,
        onError: (Object error) => _onError(context, error),
        onSuccess: () => _onSuccess(context),
        onCanceled: () => _onCanceled(context),
      );

  void _onError(BuildContext context, Object error) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString()),
        ),
      );

  void _onSuccess(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content:
              Text('Pass has been successfully added to the Google Wallet.'),
        ),
      );

  void _onCanceled(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.yellow,
          content: Text('Adding a pass has been canceled.'),
        ),
      );
}

final String _passId = const Uuid().v4();
final String _passId1 = const Uuid().v4();
const String _passClass = 'DemoTicket';
const String _issuerId = '3388000000022883323';
const String _issuerEmail = 'anujyeole23@gmail.com';

final String _examplePass = """
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#FFF6EC",
            "logo": {
              "sourceUri": {
                "uri": "https://activityplanner.blob.core.windows.net/experience-gallery/bulk-events-v2/Site-Logos/black/etereo.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Mexican Wine Club"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Guest"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Anuj Yeole"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "https://staging-portal.vacay4me.com/"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          },
          {
            "id": "$_issuerId.$_passId1",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#FFF6EC",
            "logo": {
              "sourceUri": {
                "uri": "https://activityplanner.blob.core.windows.net/experience-gallery/bulk-events-v2/Site-Logos/black/etereo.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Mexican Wine Club"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Guest"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Kapil Deore"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "https://staging-portal.vacay4me.com/"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
