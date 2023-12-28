import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextFormField extends StatelessWidget {

  final String? label;
  final String? hinttext;
  final int? lengthlimit;
  final String? mainError;
  final String? lengthError;
  final TextEditingController? controller;
  final TextInputType keyboardtype;
  final int? maxlines;

  const ReusableTextFormField(
      {super.key, this.label,
       required this.hinttext,
        this.lengthlimit,
        required this.mainError,
        this.lengthError,
        required this.controller,
      required this.keyboardtype,
      this.maxlines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(lengthlimit)
      ],
      maxLength: lengthlimit,
      maxLines: maxlines,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
          label: Text(label!),
          hintText: (hinttext!),
          focusColor: Colors.amber,
          labelStyle: const TextStyle(color: Colors.amber),
          fillColor: Colors.amber,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10))),
      validator: (value){
        if(value==null || value.isEmpty || value == " "){
          return mainError;
        }
        if(value.length<lengthlimit!){
          return lengthError;
        }
        return null;
      },
    );
  }
}


class VoucherContainer extends StatelessWidget {

  final String month;
  final String invoice;
  final String amount;
  final String status;


  const VoucherContainer({super.key, required this.month, required this.invoice, required this.amount, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Row(
        children: [

          const SizedBox(
            width: 8,
          ),

          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFf5bf53)
            ),
            child: Center(
              child: Text(month,style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.normal
              ),),
            ),
          ),

          Container(
            margin:const EdgeInsets.only(left: 14,top: 4) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Invoice #",style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                ),),
                Text(invoice,style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w800
                ),),
                Text("Amount",style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                ),),
                Text(amount,style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w800
                ),),
                Text("Due Date",style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                ),),
                Text("12-$month-2023",style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w800
                ),),
              ],
            ),
          ),

          const Spacer(),

          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 80,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: status=="Unpaid"?const Color(0xFFFD8181):status=="Pending"?const Color(
                    0xFFFDB581):const Color(0xFF9DFD81)
            ),
            child: Center(
              child:  Text(status,style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: status=="Unpaid"?const Color(0xFFA10000):status=="Pending"?const Color(
                      0xFFE07D00):const Color(0xFF23A100),
                  fontWeight: FontWeight.w800
              ),),
            ),
          ),

        ],
      ),
    );
  }
}

class AttendanceContainer extends StatelessWidget {
  const AttendanceContainer({
    super.key,
    required this.currentBook,
    required this.bookSession,
    required this.studentStatus,
    required this.bookSessionNo
  });

  final String currentBook;
  final String bookSession;
  final String studentStatus;
  final String bookSessionNo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10
            )
          ],
          borderRadius: BorderRadius.circular(14)
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 14,top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Book:",style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),),
            Text(currentBook,style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w800
            ),),
            Text("Session No.",style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),),
            Text(bookSessionNo,style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w800
            ),),
            Text("Session Details",style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),),
            Text(bookSession,style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w800
            ),),
            Text("Status",style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),),
            Container(
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                  color: studentStatus=="Absent"?Colors.red:Colors.green,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 5,top: 1),
                child: Text(studentStatus,style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventContainer extends StatelessWidget {
  const EventContainer({
    super.key,
    required this.eventImage,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
  });

  final String eventImage;
  final String eventTitle;
  final String eventDescription;
  final String eventDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 280,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10
                )
              ],
              color: Colors.white
          ),
        ),
        Container(
          width: double.infinity,
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange.shade50,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: eventDate=="25-12-2023"?ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken):ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstOut),
                  image: NetworkImage(eventImage))
          ),
        ),

        Container(
          margin: const EdgeInsets.only(left: 200,top: 150),
          width: 120,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month,color: Colors.grey,size: 20,),
              const SizedBox(
                width: 8,
              ),
              Text(eventDate,style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w400
              ),overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),


        Container(
          margin: const EdgeInsets.only(top: 200),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eventTitle,style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                ),overflow: TextOverflow.ellipsis,),

                const SizedBox(
                  height: 6,
                ),

                Text(eventDescription,style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CurrentEvent extends StatelessWidget {
  const CurrentEvent({super.key});
  @override
  Widget build(BuildContext context) {
    List eventDates = ["20-12-2023","18-11-2023","06-10-2023","05-09-2023"];
    return Column(
       children: [
         const SizedBox(
           height: 30,
         ),

         Container(
           margin: const EdgeInsets.only(left: 20),
           child: Text("Current Event:",style: GoogleFonts.poppins(
               fontSize: 16,
               color: Colors.black,
               fontWeight: FontWeight.w600
           ),overflow: TextOverflow.ellipsis,),
         ),

         Container(
           margin: const EdgeInsets.only(left: 20),
           width: 80,
           child: const Divider(
             color: Colors.black,
             thickness: 1,
           ),
         ),

         const SizedBox(
           height: 10,
         ),

         const EventContainer(
           eventImage: "https://images.inc.com/uploaded_files/image/1920x1080/getty_479977238_253066.jpg",
           eventDate: "25-12-2023",
           eventTitle: "Techwiz 5",
           eventDescription: "askdjfhksjfd sakdjfhkjsdahfkasdf jksadhfkljasdhf",
         ),

         const SizedBox(
           height: 30,
         ),

         Container(
           margin: const EdgeInsets.only(left: 20),
           child: Text("Previous Event:",style: GoogleFonts.poppins(
               fontSize: 16,
               color: Colors.black,
               fontWeight: FontWeight.w600
           ),overflow: TextOverflow.ellipsis,),
         ),

         Container(
           margin: const EdgeInsets.only(left: 20),
           width: 80,
           child: const Divider(
             color: Colors.black,
             thickness: 1,
           ),
         ),

         const SizedBox(
           height: 10,
         ),

         CarouselSlider.builder(
             itemCount: eventDates.length,
             itemBuilder: (context, index, realIndex) {
               return EventContainer(
                 eventImage: "https://images.inc.com/uploaded_files/image/1920x1080/getty_479977238_253066.jpg",
                 eventDate: "${eventDates[index]}",
                 eventTitle: "Techwiz 5",
                 eventDescription: "askdjfhksjfd sakdjfhkjsdahfkasdf jksadhfkljasdhf",
               );
             }, options: CarouselOptions(
             autoPlay: true,
             viewportFraction: 1,
             height: 280,
             autoPlayCurve: Curves.easeIn
         ))
       ],
    );
  }
}

class UpComingEvent extends StatelessWidget {
  const UpComingEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),

        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text("UpComing's",style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),overflow: TextOverflow.ellipsis,),
        ),

        Container(
          margin: const EdgeInsets.only(left: 20),
          width: 80,
          child: const Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        const EventContainer(
          eventImage: "https://images.inc.com/uploaded_files/image/1920x1080/getty_479977238_253066.jpg",
          eventDate: "25-12-2023",
          eventTitle: "Techwiz 5",
          eventDescription: "askdjfhksjfd sakdjfhkjsdahfkasdf jksadhfkljasdhf",
        ),

      ],
    );
  }
}

