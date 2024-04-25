import 'package:flutter/material.dart';
import 'package:leafloom/provider/address/address_provider.dart';
import 'package:leafloom/view/address/screens/edit_address.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddEditAddressButtons extends StatelessWidget {
  AddEditAddressButtons({
    required this.id,
    required this.fullname,
    required this.pincode,
    required this.city,
    required this.state,
    required this.phone,
    required this.house,
    required this.area,
    super.key,
  });
  String id;
  String fullname;
  String pincode;
  String city;
  String state;
  String phone;
  String house;
  String area;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 9.0, bottom: 20, right: 5, left: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditAddressScreen(
                    area: area,
                    city: city,
                    fullname: fullname,
                    house: house,
                    id: id,
                    phone: phone,
                    pincode: pincode,
                    state: state,
                  ),
                ),
              );
              debugPrint('======== pressed');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                Text(
                  '  Edit Address',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9.0, bottom: 20, right: 1),
          child: ElevatedButton(
            onPressed: () async {
              context.read<AddressProvider>().deleteAddress(id);
              debugPrint('$id================== =');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                Text(
                  ' Remove Address',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
