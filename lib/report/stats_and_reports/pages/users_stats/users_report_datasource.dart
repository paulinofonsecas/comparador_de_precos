import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsersReportDataSource extends DataGridSource {
  UsersReportDataSource({List<UserProfile> users = const []}) {
    _users = users
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'nomeCompleto', value: e.nomeCompleto),
              DataGridCell<String>(columnName: 'bi', value: e.bi),
              DataGridCell<String?>(
                columnName: 'telefone',
                value: e.telefone,
              ),
              DataGridCell<String?>(
                columnName: 'tipo_usuario',
                value: e.tipoUsuario.name,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _users = [];

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
