
const kLOG_TAG = "[on_demand_customer]";
const kLOG_ENABLE = true;
DateTime? loginClickTime;


bool isRedundentClick(DateTime currentTime){
  if(loginClickTime==null){
    loginClickTime = currentTime;
    print("first click");
    return false;
  }
  print('diff is ${currentTime.difference(loginClickTime!).inSeconds}');
  if(currentTime.difference(loginClickTime!).inSeconds<3){//set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}
