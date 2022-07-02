import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/network/DAO.dart';

class NewCustomerScreenLogic extends ChangeNotifier{


  static  Map<String, String> newCustomerMap = {
      'name' : '',
      'surname' : '',
      'email' : '',
      'phoneNumber' : '',
      };



    void setParameters (String field , String value){
          newCustomerMap[field] = value;
          notifyListeners();
      }

void addCustomer(){
      DAO().newCustomer();
}





  }



