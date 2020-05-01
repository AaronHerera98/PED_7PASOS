import 'package:los_7_pasos/control/CtipoCita.dart';
import 'package:los_7_pasos/model/MCita.dart';
import 'package:flutter/material.dart';
import 'package:los_7_pasos/view/VCita.dart';

class CitaTitle extends StatelessWidget {
  final Cita _cita;

  CitaTitle(this._cita);

  _getTipo(context) {
    if (CTipoCita.tipoCita == null)
    {
      CTipoCita.getTipocita(_cita.id_datosCita);
      if(CTipoCita.tipoCita!=null)
      {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondRoute(citaUnica: _cita),
      ),
    ); 
      }
    } 
    else
     {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondRoute(citaUnica: _cita),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Cita',
              style: TextStyle(fontSize: 25.0),
            ),
            subtitle: Text(
              'Fecha: ${_cita.fecha_cita.replaceAll('T00:00:00', '')}\nHora: ${_cita.hora_cita.replaceRange(5, 8, '')}',
              style: TextStyle(fontSize: 20.0),
            ),

            onTap: () {
              //CTipoCita.getTipocita(_cita.id_tipocita);
              _getTipo(context);
            }, // onTap
          ),
          Divider(),
        ],
      );
}
