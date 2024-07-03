// import 'package:flutter/material.dart';

// class DropDownButtonWidget extends StatefulWidget {
//   final String? selectedItem;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;

//   DropDownButtonWidget({
//     required this.selectedItem,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   _DropDownButtonWidgetState createState() => _DropDownButtonWidgetState();
// }

// class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       hint: Text('Pilih Item'),
//       value: widget.selectedItem,
//       isExpanded: true, // Untuk mengisi lebar penuh
//       items: widget.items.map((item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Text(item),
//         );
//       }).toList(),
//       onChanged: widget.onChanged,
//     );
//   }
// }
import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatelessWidget {
  final String? selectedItem;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  DropDownButtonWidget({
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedItem,
          icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
          iconSize: 36,
          elevation: 16,
          style: TextStyle(color: Colors.black, fontSize: 16),
          hint: Text('Pilih Tahun Ajaran', style: TextStyle(color: Colors.grey)),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}