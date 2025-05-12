import 'package:flutter/material.dart';

class LoginpageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo1.jpg',
                  width: 200,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello,\nGayathri",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.notifications_none,
                      size: 30,
                      color: Colors.deepPurpleAccent,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cust ID ***1249",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.visibility_off),
                      label: Text("View balance"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    gradient: LinearGradient(
                      colors: [const Color.fromARGB(255, 241, 236, 241), Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Icon(Icons.fingerprint, size: 60, color: const Color.fromARGB(255, 43, 17, 149)),
                      Text(
                        "Login with Fingerprint",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Frequently used features & special offers at your fingertips",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          
                
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.currency_rupee),
                                      iconSize: 40,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      'Currency',
                                      style: TextStyle(color: Colors.amber, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.local_offer),
                                      iconSize: 40,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Send Money',
                                      style: TextStyle(
                                        color: Colors.black, 
                                        fontSize: 14
                                        ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.shopping_bag),
                                      iconSize: 40,
                                      color: Colors.pink,
                                    ),
                                    Text(
                                      'pay Bills',
                                      style: TextStyle
                                      (
                                        color: Colors.black,
                                        fontSize: 14
                                        ),
                                    ),
                                  ],
                                ),
                              ],

                                ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.login),
                    label: Text("Login with Account",    
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),              
                    
                    ),
                    style: ButtonStyle(
                     minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                     backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 72, 33, 243)), 
                    ),
                  ),
                ),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             TextButton(onPressed: () {}, child: Text("Or, login with mPIN")),
              TextButton(onPressed: () {}, child: Text("Forgot mPIN?")),
              ],
            
            ),
              SizedBox(height: 50),

                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
              IconButton(onPressed: (){}, 
              icon: Icon(Icons.medical_information),
         
              ),
              Text(
                'Maintenance',
              ),
                IconButton(onPressed: (){}, 
              icon: Icon(Icons.medical_information),
         
              ),
              Text(
                'Reach Us',
              ),
                IconButton(onPressed: (){}, 
              icon: Icon(Icons.medical_information),
         
              ),
              Text(
                'More',
              ),
              
             
              ],
            
            )
              
             
            ],
          ),

          
        ),

      
      ),
    );
  }
}

