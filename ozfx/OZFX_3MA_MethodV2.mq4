#define SIGNAL_NONE 0
#define SIGNAL_BUY   1
#define SIGNAL_SELL  2
#define SIGNAL_CLOSEBUY 3
#define SIGNAL_CLOSESELL 4

#property copyright "Ronald Raygun"

extern string Remark1 = "== Main Settings ==";
extern int MagicNumber = 0;
extern bool SignalMail = False;
extern bool EachTickMode = True;
extern double Lots = 0.1;
extern int Slippage = 5;
extern bool UseStopLoss = True;
extern int StopLoss = 100;
extern bool UseTakeProfit = False;
extern int TakeProfit = 60;
extern bool UseTrailingStop = False;
extern int TrailingStop = 30;
extern int MAPrimary = 30;
extern int MASecondary = 50;
extern int MATertiary = 200;
extern bool MoveStopOnce = False;
extern int MoveStopWhenPrice = 50;
extern int MoveStopTo = 1;


//Version 2.01

int BarCount;
int Current;
bool TickCheck = False;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init() {
   BarCount = Bars;

   if (EachTickMode) Current = 0; else Current = 1;

   return(0);
}
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit() {
   return(0);
}
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start() {
   int Order = SIGNAL_NONE;
   int Total, Ticket;
   double StopLossLevel, TakeProfitLevel;



   if (EachTickMode && Bars != BarCount) TickCheck = False;
   Total = OrdersTotal();
   Order = SIGNAL_NONE;

   //+------------------------------------------------------------------+
   //| Variable Begin                                                   |
   //+------------------------------------------------------------------+


double Buy1_1 = iAC(NULL, 0, Current + 0);
double Buy1_2 = 0;
double Buy2_1 = iAC(NULL, 0, Current + 1);
double Buy2_2 = 0;
double Buy3_1 = iClose(NULL, 0, Current + 0);
double Buy3_2 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Buy4_1 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Buy4_2 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Buy5_1 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Buy5_2 = iMA(NULL, 0, MATertiary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Buy6_1 = iStochastic(NULL, 0, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, Current + 0);
double Buy6_2 = 50;

double Sell1_1 = iAC(NULL, 0, Current + 0);
double Sell1_2 = 0;
double Sell2_1 = iAC(NULL, 0, Current + 1);
double Sell2_2 = 0;
double Sell3_1 = iClose(NULL, 0, Current + 0);
double Sell3_2 = iMA(NULL, 0, MAPrimary, PRICE_CLOSE, MODE_SMA, PRICE_CLOSE, Current + 0);
double Sell4_1 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Sell4_2 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Sell5_1 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Sell5_2 = iMA(NULL, 0, MATertiary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double Sell6_1 = iStochastic(NULL, 0, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, Current + 0);
double Sell6_2 = 50;

double CloseBuy1_1 = iAC(NULL, 0, Current + 0);
double CloseBuy1_2 = 0;
double CloseBuy2_1 = iAC(NULL, 0, Current + 1);
double CloseBuy2_2 = 0;
double CloseBuy3_1 = iClose(NULL, 0, Current + 0);
double CloseBuy3_2 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseBuy4_1 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseBuy4_2 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseBuy5_1 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseBuy5_2 = iMA(NULL, 0, MATertiary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseBuy6_1 = iStochastic(NULL, 0, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, Current + 0);
double CloseBuy6_2 = 50;

double CloseSell1_1 = iAC(NULL, 0, Current + 0);
double CloseSell2_1 = iAC(NULL, 0, Current + 1);
double CloseSell1_2 = 0;
double CloseSell2_2 = 0;
double CloseSell3_1 = iClose(NULL, 0, Current + 0);
double CloseSell3_2 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseSell4_1 = iMA(NULL, 0, MAPrimary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseSell4_2 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseSell5_1 = iMA(NULL, 0, MASecondary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseSell5_2 = iMA(NULL, 0, MATertiary, 0, MODE_SMA, PRICE_CLOSE, Current + 0);
double CloseSell6_1 = iStochastic(NULL, 0, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, Current + 0);
double CloseSell6_2 = 50;

   
   //+------------------------------------------------------------------+
   //| Variable End                                                     |
   //+------------------------------------------------------------------+

   //Check position
   bool IsTrade = False;

   for (int i = 0; i < Total; i ++) {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if(OrderType() <= OP_SELL &&  OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
         IsTrade = True;
         if(OrderType() == OP_BUY) {
            //Close

            //+------------------------------------------------------------------+
            //| Signal Begin(Exit Buy)                                           |
            //+------------------------------------------------------------------+

                     if (CloseBuy1_1 < CloseBuy1_2 && CloseBuy2_1 > CloseBuy2_2 && CloseBuy3_1 < CloseBuy3_2 && CloseBuy4_1 < CloseBuy4_2 && CloseBuy5_1 < CloseBuy5_2 && CloseBuy6_1 < CloseBuy6_2) Order = SIGNAL_CLOSEBUY;


            //+------------------------------------------------------------------+
            //| Signal End(Exit Buy)                                             |
            //+------------------------------------------------------------------+

            if (Order == SIGNAL_CLOSEBUY && ((EachTickMode && !TickCheck) || (!EachTickMode && (Bars != BarCount)))) {
               OrderClose(OrderTicket(), OrderLots(), Bid, Slippage, MediumSeaGreen);
               if (SignalMail) SendMail("[Signal Alert]", "[" + Symbol() + "] " + DoubleToStr(Bid, Digits) + " Close Buy");
               if (!EachTickMode) BarCount = Bars;
               IsTrade = False;
               continue;
            }
             //MoveOnce
            if(MoveStopOnce && MoveStopWhenPrice > 0) {
               if(Bid - OrderOpenPrice() >= Point * MoveStopWhenPrice) {
                  if(OrderStopLoss() < OrderOpenPrice() + Point * MoveStopTo) {
                  OrderModify(OrderTicket(),OrderOpenPrice(), OrderOpenPrice() + Point * MoveStopTo, OrderTakeProfit(), 0, Red);
                     if (!EachTickMode) BarCount = Bars;
                     continue;
                  }
               }
            }
            //Trailing stop
            if(UseTrailingStop && TrailingStop > 0) {                 
               if(Bid - OrderOpenPrice() > Point * TrailingStop) {
                  if(OrderStopLoss() < Bid - Point * TrailingStop) {
                     OrderModify(OrderTicket(), OrderOpenPrice(), Bid - Point * TrailingStop, OrderTakeProfit(), 0, MediumSeaGreen);
                     if (!EachTickMode) BarCount = Bars;
                     continue;
                  }
               }
            }
         } else {
            //Close

            //+------------------------------------------------------------------+
            //| Signal Begin(Exit Sell)                                          |
            //+------------------------------------------------------------------+

                     if (CloseSell1_1 > CloseSell1_2 && CloseSell2_1 < CloseSell2_2 && CloseSell3_1 > CloseSell3_2 && CloseSell4_1 > CloseSell4_2 && CloseSell5_1 > CloseSell5_2 && CloseSell6_1 > CloseSell6_2) Order = SIGNAL_CLOSESELL;


            //+------------------------------------------------------------------+
            //| Signal End(Exit Sell)                                            |
            //+------------------------------------------------------------------+

            if (Order == SIGNAL_CLOSESELL && ((EachTickMode && !TickCheck) || (!EachTickMode && (Bars != BarCount)))) {
               OrderClose(OrderTicket(), OrderLots(), Ask, Slippage, DarkOrange);
               if (SignalMail) SendMail("[Signal Alert]", "[" + Symbol() + "] " + DoubleToStr(Ask, Digits) + " Close Sell");
               if (!EachTickMode) BarCount = Bars;
               IsTrade = False;
               continue;
            }
            //MoveOnce
            if(MoveStopOnce && MoveStopWhenPrice > 0) {
               if(OrderOpenPrice() - Ask >= Point * MoveStopWhenPrice) {
                  if(OrderStopLoss() > OrderOpenPrice() - Point * MoveStopTo) {
                  OrderModify(OrderTicket(),OrderOpenPrice(), OrderOpenPrice() - Point * MoveStopTo, OrderTakeProfit(), 0, Red);
                     if (!EachTickMode) BarCount = Bars;
                     continue;
                  }
               }
            }
            //Trailing stop
            if(UseTrailingStop && TrailingStop > 0) {                 
               if((OrderOpenPrice() - Ask) > (Point * TrailingStop)) {
                  if((OrderStopLoss() > (Ask + Point * TrailingStop)) || (OrderStopLoss() == 0)) {
                     OrderModify(OrderTicket(), OrderOpenPrice(), Ask + Point * TrailingStop, OrderTakeProfit(), 0, DarkOrange);
                     if (!EachTickMode) BarCount = Bars;
                     continue;
                  }
               }
            }
         }
      }
   }

   //+------------------------------------------------------------------+
   //| Signal Begin(Entry)                                              |
   //+------------------------------------------------------------------+

   if (Buy1_1 > Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && Buy4_1 > Buy4_2 && Buy5_1 > Buy5_2 && Buy6_1 > Buy6_2) Order = SIGNAL_BUY;

   if (Sell1_1 < Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && Sell4_1 < Sell4_2 && Sell5_1 < Sell5_2 && Sell6_1 < Sell6_2) Order = SIGNAL_SELL;


   //+------------------------------------------------------------------+
   //| Signal End                                                       |
   //+------------------------------------------------------------------+

   //Buy
   if (Order == SIGNAL_BUY && ((EachTickMode && !TickCheck) || (!EachTickMode && (Bars != BarCount)))) {
      if(!IsTrade) {
         //Check free margin
         if (AccountFreeMargin() < (1000 * Lots)) {
            Print("We have no money. Free Margin = ", AccountFreeMargin());
            return(0);
         }

         if (UseStopLoss) StopLossLevel = Ask - StopLoss * Point; else StopLossLevel = 0.0;
         if (UseTakeProfit) TakeProfitLevel = Ask + TakeProfit * Point; else TakeProfitLevel = 0.0;

         Ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, Slippage, StopLossLevel, TakeProfitLevel, "Buy(#" + MagicNumber + ")", MagicNumber, 0, DodgerBlue);
         if(Ticket > 0) {
            if (OrderSelect(Ticket, SELECT_BY_TICKET, MODE_TRADES)) {
				Print("BUY order opened : ", OrderOpenPrice());
                if (SignalMail) SendMail("[Signal Alert]", "[" + Symbol() + "] " + DoubleToStr(Ask, Digits) + " Open Buy");
			} else {
				Print("Error opening BUY order : ", GetLastError());
			}
         }
         if (EachTickMode) TickCheck = True;
         if (!EachTickMode) BarCount = Bars;
         return(0);
      }
   }

   //Sell
   if (Order == SIGNAL_SELL && ((EachTickMode && !TickCheck) || (!EachTickMode && (Bars != BarCount)))) {
      if(!IsTrade) {
         //Check free margin
         if (AccountFreeMargin() < (1000 * Lots)) {
            Print("We have no money. Free Margin = ", AccountFreeMargin());
            return(0);
         }

         if (UseStopLoss) StopLossLevel = Bid + StopLoss * Point; else StopLossLevel = 0.0;
         if (UseTakeProfit) TakeProfitLevel = Bid - TakeProfit * Point; else TakeProfitLevel = 0.0;

         Ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, Slippage, StopLossLevel, TakeProfitLevel, "Sell(#" + MagicNumber + ")", MagicNumber, 0, DeepPink);
         if(Ticket > 0) {
            if (OrderSelect(Ticket, SELECT_BY_TICKET, MODE_TRADES)) {
				Print("SELL order opened : ", OrderOpenPrice());
                if (SignalMail) SendMail("[Signal Alert]", "[" + Symbol() + "] " + DoubleToStr(Bid, Digits) + " Open Sell");
			} else {
				Print("Error opening SELL order : ", GetLastError());
			}
         }
         if (EachTickMode) TickCheck = True;
         if (!EachTickMode) BarCount = Bars;
         return(0);
      }
   }

   if (!EachTickMode) BarCount = Bars;

   return(0);
}
//+------------------------------------------------------------------+