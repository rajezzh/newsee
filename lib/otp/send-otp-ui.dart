import 'package:flutter/material.dart';

class OTPPAGE extends StatelessWidget {
  const OTPPAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Center(
          child: Text('Login Otp',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          ),
          
        ),
        
        backgroundColor: Colors.indigo,
      
        actions: [

          IconButton(onPressed: (){}, icon: Icon(Icons.close),
          color: const Color.fromARGB(255, 10, 8, 8),
          ),
          // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),
          // color: const Color.fromARGB(255, 10, 8, 8)),
          
        ],

     
      ),
      body: Container(
        child: Column(
          children: [
            Center(child: Image.asset('images/log.png', width: 200, height: 100)), 
              SizedBox(height: 20),
             Align(
              alignment:Alignment.center,
              child: Text('Username - GLRO',
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 27, 109, 59),
                fontWeight: FontWeight.bold

              ),
              
              ),
             ),

            //  SizedBox(height: 90),

              Center(child: Image.asset('images/otp.jpg', width: 200, height: 500)), 
              SizedBox(height: 20),


            
          ],
        ),
      ),
    );
  }
}