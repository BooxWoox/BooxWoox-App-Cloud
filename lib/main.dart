import 'package:bookollab/UI/AllBooksPage.dart';
import 'package:bookollab/UI/Chat/ConversationPage.dart';
import 'package:bookollab/UI/Chat/RequestsPage.dart';
import 'package:bookollab/UI/Payment/checkout.dart';
import 'package:bookollab/UI/Transactions/the_transactions.dart';
import 'package:bookollab/UI/filters.dart';
import 'package:flutter/material.dart';
import 'UI/SplashScreen.dart';
import 'UI/Onboarding.dart';
import 'UI/LoginPage.dart';
import 'UI/CreateAccountPage.dart';
import 'UI/Homepage.dart';
import 'UI/maindisplaypage.dart';
import 'UI/OTPverify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/ProfilePage.dart';
import 'UI/Book_info.dart';
import 'UI/Chat/chat_homepage.dart';
import 'UI/Notification/notification.dart';
import 'UI/Chat/ChatsPage.dart';
import 'UI/Payment/testpayment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UI/AddBookPage.dart';
import 'UI/Transactions/Transactions_Buyer.dart';
import 'UI/Transactions/BuyerTransaction_Category/Ongoing_transaction.dart';
import 'UI/Transactions/BuyerTransaction_Category/Failed_transaction.dart';
import 'UI/Transactions/BuyerTransaction_Category/Completed_transaction.dart';
import 'UI/Transactions/Transactions_Seller.dart';
import 'UI/Transactions/SellerTransaction_Category/Completed_Seller_Transaction.dart';
import 'UI/Transactions/AllTransactions.dart';
import 'UI/Profile/Aboutus.dart';
import 'UI/Profile/ContactUs.dart';
import 'UI/Profile/Mybooks.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(bookollab());
}

class bookollab extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        Onboarding.id: (context) => Onboarding(),
        LoginPage.id: (context) => LoginPage(),
        CreateAccountPage.id: (context) => CreateAccountPage(),
        Homepage.id: (context) => Homepage(),
        maindisplaypage.id: (context) => maindisplaypage(),
        ProfilePage.id: (context) => ProfilePage(),
        Book_info.id: (context) => Book_info(),
        Chat_homepage.id: (context) => Chat_homepage(),
        notification.id: (context) => notification(),
        ChatsPage.id: (context) => ChatsPage(),
        ConversationsPage.id: (context) => ConversationsPage(),
        RequestsPage.id: (context) => RequestsPage(),
        AddBookPage.id: (context) => AddBookPage(),
        AllBooksPage.id: (context) => AllBooksPage(),
        testpayment.id: (context) => testpayment(),
        Transactions_Buyer.id: (context) => Transactions_Buyer(),
        Transactions_Seller.id: (context) => Transactions_Seller(),
        Ongoing_transaction_Buyer.id: (context) => Ongoing_transaction_Buyer(),
        Failed_transaction_Buyer.id: (context) => Failed_transaction_Buyer(),
        Completed_transaction_Buyer.id: (context) =>
            Completed_transaction_Buyer(),
        Completed_Seller_Transaction.id: (context) =>
            Completed_Seller_Transaction(),
        AllTransactions.id: (context) => AllTransactions(),
        Aboutus.id:(context) => Aboutus(),
        ContactUs.id:(context) =>ContactUs(),
        Mybooks.id:(context) => Mybooks(),
        TheTransactions.id: (context) => TheTransactions(),
        Checkout.id: (context) => Checkout(),
        Filters.id: (context) => Filters(),

      },
    );
  }
}
