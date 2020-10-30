<img src="https://github.com/Barney-m/tarccaring_app/blob/master/assets/images/logo/TARC_Caring_Advertise.PNG?raw=true" width="500">

# **TARC Caring** 

TARC Caring is a mobile-based feedback system to provide a more easy way to **_make feedback_** to **_TARUC_**. This is a final year project which is contributed by:

|Name|Student ID|Modules|
|----|----------|-------|
|Chong Ken Shen|19WMR09572|Staff & Public Feedback Management|
|Cheah Poh Reng|19WMR09562|User & Admin Feedback Management|

## Features

  - Campus Facilities Feedback
  - Canteen Food Feedback
  - Education Quality Feedback
  - Service Attitude Feedback
 
## Technologies
   - Flutter
   - Laravel 8
   - MySQL

## Languages
   - Dart
   - PHP

## Commands
```flutter doctor -v``` : This command is to get details information of the Flutter SDK.\
```flutter devices``` : This command is to show all the devices currently existing.\
```flutter run``` : This command is to run your flutter project.


The link to [TARC Caring Backend](https://github.com/Barney-m/tarc_caring_backend).


Future<void> _action(BuildContext context, String action) async {
    var data = {
      'id' : widget.id.toInt(),
      'action' : action,
    };

    var result = await APIService().postMethod(data, 'manage/action');
    var message = json.decode(result.body);

    if(message['message'] != null && message['success'] == true){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext  context) {
          return SimpleDialog(
            title: Text(message['message'],
                      style: new TextStyle(
                              fontSize: 20.0,
                            ),
                      ),
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: SimpleDialogOption(
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed(UserNavigationRoute);
                  },
                  child: const Text('OK')
                ),
              ),
            ],
          );
        },
      );
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext  context) {
          return AlertDialog(
            title: Text("Failed!"),
            content: Text("Something went wrong...."),
          );
        },
      );
    }
  }