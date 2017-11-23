/*         
          o=======================================o
         //                                       \\ 
         O                ADX Bone                 O
        ||               by Edorenta               ||
        ||             (Paul de Renty)             ||                    
        ||           edorenta@gmail.com            ||
         O           __________________            O
         \\                                       //
          o=======================================o                                                               

*/

#property copyright     "Paul de Renty (Edorenta @ ForexFactory.com)"
#property link          "edorenta@gmail.com (mp me on FF rather than by email)"
#property description   "ADX Bone; all about the ADX"
#property version       "0.2"
#property strict

//--- external variables

extern int adx_ln = 50;                             //ADX p
extern int adxma_ln = 25;                           //ADXMA p
extern ENUM_MA_METHOD adxma_type = MODE_SMA;        //ADXMA type

extern double atr_p = 15;                           //ATR/HiLo period for dynamic SL/TP/TS
extern double atr_x = 1;                            //ATR weight in SL/TP/TS
extern double hilo_x = 0.5;                         //HiLo weight in SL/TP/TS
double sl_p = 0;                                    //Raw pips offset

extern double pf = 3.5;                             //Targeted profit factor (x times SL)

extern bool trail_mode = true;                      //Enable trailing
extern double tf = 0.8;                             //Trailing factor (x times Sl)

enum mm     {classic        //Classic
            ,mart           //Martingale
            ,r_mart         //Anti-Martingale
            ,scale          //Scale-in Profit
            ,r_scale        //Scale-in Loss
            ,};
            
extern mm mm_mode = classic;                        //Money Management

extern double blots = 0.02;                         //Base lot size
extern double cator = 1.1;                          //Martingale multiplicator
extern double f_inc = 0.1;                          //Scaler increment
extern bool close_range = false;                    //Close on range
extern bool close_r = false;                        //Close on direction change
extern bool r_signal = false;                       //Reversed signal

extern bool gui = true;                             //Show The EA GUI

extern color color1 = LightGray;                    //EA's name color
extern color color2 = DarkOrange;                   //EA's balance & info color
extern color color3 = Turquoise;                    //EA's profit color
extern color color4 = Magenta;                      //EA's loss color

extern int Slippage = 3;                          
extern int MagicNumber = 001;                       //Magic

//--- inner variables

int ThisBarTrade           =  0;
string version = "0.2";

double max_acc_dd = 0;
double max_acc_dd_pc = 0;
double max_dd = 0;
double max_dd_pc = 0;
double max_acc_runup = 0;
double max_acc_runup_pc = 0;
double max_runup = 0;
double max_runup_pc = 0;
int max_chain_win = 0;
int max_chain_loss = 0;
int spread = 0;
//---

int init() {
   return (0);
}

int deinit() {
   return (0);
}

//---

/*       ________________________________________________
         T                                              T
         T               ON TICK FUNCTION               T
         T______________________________________________T
*/

int start(){
             
if (gui) {
      HUD();
      Popup();
      Earnings();
}

if (Bars != ThisBarTrade ) {// To avoid more order in one bar!
   Comment("");
            
   double spread = MarketInfo(Symbol(), MODE_SPREAD) * Point;
   double pt = MarketInfo (Symbol(), MODE_POINT);

//--- Max DD calculation



//--- ATR for Sl / HiLo MA for SL

   double atr1 = iATR(NULL,0,atr_p,0);// Period 15
   double atr2 = iATR(NULL,0,2*atr_p,0);// Period 30
   double atr3 = NormalizeDouble(((atr1+atr2)/2)*atr_x,Digits);// Atr weight 1 in SL?TP/TSL
   
   double ma1 = iMA(NULL,0,atr_p*2,0,MODE_LWMA,PRICE_HIGH,0);// 30 MA High
   double ma2 = iMA(NULL,0,atr_p*2,0,MODE_LWMA,PRICE_LOW,0);// 30 Ma Low
   double ma3 = NormalizeDouble(hilo_x*(ma1 - ma2),Digits);// HiLo weight 0.5 in SL/TP/TSL

//--- SL & TP calculation 

   double sl_p1 = NormalizeDouble(Point*sl_p/((1/(Close[0]+(spread/2)))),Digits);
   
   double SLp = sl_p1 + atr3 + ma3;// (atr15+atr30)/2 + (ma30High-ma30Low)/2
   double TPp = NormalizeDouble(pf*(SLp),Digits); // 3.5 SLP
   double TSp = NormalizeDouble(tf*(SLp),Digits); //0.8 SLP
   
//--- Win / Loss Counter

   int WinCount = Counta(6);
   int LossCount = Counta(5);

//--- Money Management

double mlots=0;
 
switch(mm_mode){

//Martingale
   case mart: if (OrdersHistoryTotal()!=0) mlots=NormalizeDouble(blots*(MathPow(cator,(LossCount))),2); else mlots = blots; break;
   
//Reversed Martingale
   case r_mart: if (OrdersHistoryTotal()!=0) mlots=NormalizeDouble(blots*(MathPow(cator,(WinCount))),2); else mlots = blots; break;
   
//Scale after loss (Fixed)
   case scale: if (OrdersHistoryTotal()!=0) mlots=blots+(f_inc*WinCount); else mlots = blots; break;
   
//Scale after win (Fixed)
   case r_scale: if (OrdersHistoryTotal()!=0) mlots=blots+(f_inc*LossCount); else mlots = blots; break;
   
//Classic
   case classic: mlots = blots; break;
};

//--- Inner Indicators

double ADX=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,0,0);
double ADXMA=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,1,0);
double DIP=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,2,0);
double DIM=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,3,0);

double PADX=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,0,1);
double PADXMA=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,1,1);
double PDIP=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,2,1);
double PDIM=iCustom(Symbol(),0,"ADX+ADXMA",adx_ln,adxma_ln,adxma_type,3,1);

/*
double ATR1=iCustom(Symbol(),0,"ATR+ATRMA",atr_ln,atrma_ln,0,0);
double ATRMA1=iCustom(Symbol(),0,"ATR+ATRMA",atr_ln,atrma_ln,1,0);   

double PATR1=iCustom(Symbol(),0,"ATR+ATRMA",atr_ln,atrma_ln,0,1);
double PATRMA1=iCustom(Symbol(),0,"ATR+ATRMA",atr_ln,atrma_ln,1,1);
*/

//--- Signals

int signal_1 = 0, signal_2 = 0, direction = 0;
bool is_trend = false, cross = false;

   if (ADX > ADXMA) is_trend = true;
   if (ADX < ADXMA) is_trend = false;
   
   if ( (ADX > ADXMA && PADX <= PADXMA)) cross = true;  
   
   if (DIP > DIM) direction = 1;
   if (DIP < DIM) direction = -1;
   
   if ( cross==true && direction == 1 ) signal_1 = 1;
   if ( cross==true && direction == -1 ) signal_1 = -1;
   
   signal_2 = signal_1;
   
if (r_signal==true) signal_2 = -signal_1;
   
/*       ________________________________________________
         T                                              T
         T                 ENTRY RULES                  T
         T______________________________________________T
*/

  if( TotalOrdersCount()==0 ) 
  {
     int result=0;
     //--- Long
     if(signal_2==1)
     {
        result=OrderSend(Symbol(),OP_BUY,mlots,Ask,Slippage,0,0,"ADX Bone - long "+DoubleToStr(mlots,2)+" on "+Symbol(),MagicNumber,0,Turquoise);
        if(result>0)
        {
         ThisBarTrade = Bars;
         Comment("\n   This Bar has already been traded");
         ObjectDelete(version + "98");
         ObjectDelete(version + "100");
         
         double TP = 0, SL = 0;
         if(TPp>0) TP=Ask+TPp;
         if(SLp>0) SL=Ask-SLp;
         OrderSelect(result,SELECT_BY_TICKET);
         OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(SL,Digits),NormalizeDouble(TP,Digits),0,Green);
        }

        return(0);
     }
     //--- Short rule
     if(signal_2==-1)
     {   
        result=OrderSend(Symbol(),OP_SELL,mlots,Bid,Slippage,0,0,"ADX Bone - short "+DoubleToStr(mlots,2)+" on "+Symbol(),MagicNumber,0,Magenta);
        if(result>0)
        {
         ThisBarTrade = Bars;
         Comment("\n   This Bar has already been traded");
         ObjectDelete(version + "98");
         ObjectDelete(version + "100");
         
         double TP = 0, SL = 0;
         if(TPp>0) TP=Bid-TPp;
         if(SLp>0) SL=Bid+SLp;
         OrderSelect(result,SELECT_BY_TICKET);
         OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(SL,Digits),NormalizeDouble(TP,Digits),0,Green);
        }

        return(0);
     }
  }

/*       ________________________________________________
         T                                              T
         T            EXIT RULES & TRAILING             T
         T______________________________________________T
*/
  
  for(int cnt=0;cnt<OrdersTotal();cnt++)
     {
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType()<=OP_SELL &&   
         OrderSymbol()==Symbol() &&
         OrderMagicNumber()==MagicNumber 
         )  
        {
        //--- Close long
         if(OrderType()==OP_BUY)  
           {
              if( (close_range==true && is_trend==false) || (close_r==true && direction==-1) )
              {
                   OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),Slippage,Red);
                   ThisBarTrade = Bars;
                   ObjectDelete(version + "98");
                   ObjectDelete(version + "100");
              }
            if(TSp>0 && trail_mode==true)
              {                 
               if(Bid-OrderOpenPrice()>TSp)
                 {
                  if(OrderStopLoss()<Bid-TSp)
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TSp,OrderTakeProfit(),0,Turquoise);
                     ThisBarTrade = Bars;
                     return(0);
                    }
                 }
              }
           }
        //--- Close Short
         if(OrderType()==OP_SELL) 
           {
              if( (close_range==true && is_trend==false) || (close_r==true && direction==1) )
              {
                 OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),Slippage,Red);
                 ThisBarTrade = Bars;
                 ObjectDelete(version + "98");
                 ObjectDelete(version + "100");
              }
            if(TSp>0 && trail_mode==true)  
              {                 
               if((OrderOpenPrice()-Ask)>(TSp))
                 {
                  if((OrderStopLoss()>(Ask+TSp)) || (OrderStopLoss()==0))
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TSp,OrderTakeProfit(),0,Magenta);
                     ThisBarTrade = Bars;
                     return(0);
                    }
                 }
              }
           }
        }
     }
  }
    return(0);
}

/*       ________________________________________________
         T                                              T
         T                WRITE ON CHART                T
         T______________________________________________T
*/

//--- stats

double Earnings(int shift) {
   double aggregated_profit = 0;
   for (int position = 0; position < OrdersHistoryTotal(); position++) {
      if (!(OrderSelect(position, SELECT_BY_POS, MODE_HISTORY))) break;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
         if (OrderCloseTime() >= iTime(Symbol(), PERIOD_D1, shift) && OrderCloseTime() < iTime(Symbol(), PERIOD_D1, shift) + 86400) aggregated_profit = aggregated_profit + OrderProfit() + OrderCommission() + OrderSwap();
   }
   return (aggregated_profit);
}

//--- Key can either be total_win, total_loss, total_profit, total_volume!

double Counta (int key){

   double count_tot = 0;
   double balance = AccountBalance();
   double equity = AccountEquity();
   double drawdown = 0;
   double profit = 0;
   double lots = 0;
   double runup = 0;
   
   switch (key) {
   
   //All time wins counter
   case(1):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()>0) //total number of loss
		    {count_tot++;}
     }
   break;

   //All time loss counter
   case(2):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()<0) //total number of loss
		    {count_tot++;}
     }
   break;
   
   //All time profit
   case(3):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //total profit
		    {profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     count_tot = profit;
   break;

   //All time lots
   case(4):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //total profit
		    {lots = lots + OrderLots();}
     }
     count_tot = lots;
   break;
   
   //Chain Loss
   case(5):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()<0) 
		    {count_tot++;}
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()>0)
          {count_tot=0;}
     }
   break;
   
   //Chain Win
   case(6):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()<0) 
		    {count_tot=0;}
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()>0)
          {count_tot++;}
     }
   break;
   
   //Chart Drawdown %
   case(7):
     for (int i = 0; i < OrdersTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //current profit
		    { profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     if (profit>0) drawdown = 0; else drawdown = NormalizeDouble( (profit/balance)*100,2 );
     count_tot = drawdown;
   break;
   
   //Acc Drawdown %
   case(8):
      if (equity >= balance) drawdown = 0; else drawdown = NormalizeDouble( ((equity-balance)*100) / balance,2 );
      count_tot = drawdown;
   break;

   //Chart dd money
   case(9):
     for (int i = 0; i < OrdersTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //current profit
		    { profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     if (profit >= 0) drawdown = 0; else drawdown = profit;
     count_tot = drawdown;
   break; 

   //Acc dd money
   case(10):
     if (equity >= balance) drawdown = 0; else drawdown = equity - balance;
     count_tot = drawdown;
   break; 
   
   //Chart Runup %
   case(11):
     for (int i = 0; i < OrdersTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //current profit
		    { profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     if (profit<0) runup = 0; else runup = NormalizeDouble( (profit/balance)*100,2 );
     count_tot = runup;
   break;
   
   //Acc Runup %
   case(12):
      if (equity < balance) runup = 0; else runup = NormalizeDouble( ((equity-balance)*100) / balance,2 );
      count_tot = runup;
   break;

   //Chart runup money
   case(13):
     for (int i = 0; i < OrdersTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //current profit
		    { profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     if (profit < 0) runup = 0; else runup = profit;
     count_tot = runup;
   break; 

   //Acc runup money
   case(14):
     if (equity < balance) runup = 0; else runup = equity - balance;
     count_tot = runup;
   break;
   
   //Current profit here
   case(15):
     for (int i = 0; i < OrdersTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()) //current profit
		    {profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     count_tot = profit;
   break;
   
   //Current profit acc
   case(16):
      count_tot = AccountProfit();
   break;

   //Gross profits
   case(17):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()>0)
		    {profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     count_tot = profit;
   break;

   //Gross loss
   case(18):
     for (int i = 0; i < OrdersHistoryTotal(); i++) 
	  {
         if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) 
		    continue;
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderProfit()<0) //total profit
		    {profit = profit + OrderProfit() + OrderCommission() + OrderSwap();}
     }
     count_tot = profit;
   break;

 }
 return(count_tot);
 
}

//--- Order Counter to enter only when result = 0

int TotalOrdersCount()
{
  int result=0;
  for(int i=0;i<OrdersTotal();i++)
  {
     OrderSelect(i,SELECT_BY_POS ,MODE_TRADES);
     if (OrderMagicNumber()==MagicNumber && OrderSymbol()==Symbol()) result++;
   }
  return (result);
}

//--- Write stuff

//--- HUD Rectangle
void HUD()
  {
  ObjectCreate(ChartID(),"HUD",OBJ_RECTANGLE_LABEL,0,0,0);
//--- set label coordinates
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_XDISTANCE,290);
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_YDISTANCE,28);
//--- set label size
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_XSIZE,285);
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_YSIZE,510);
//--- set background color
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_BGCOLOR,clrBlack);
//--- set border type
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_BORDER_TYPE,BORDER_FLAT);
//--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
//--- set flat border color (in Flat mode)
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_COLOR,clrWhite);
//--- set flat border line style
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_STYLE,STYLE_SOLID);
//--- set flat border width
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_WIDTH,1);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_BACK,false);
//--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_SELECTABLE,false);
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_SELECTED,false);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_HIDDEN,true);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(ChartID(),"HUD",OBJPROP_ZORDER,0);
}

void Earnings() {

   int total_wins = Counta(1);
   int total_loss = Counta(2);   
   int total_trades = total_wins + total_loss;
   
   double total_profit = Counta(3);
   double total_volumes = Counta(4);
   int chain_loss = Counta(5);
   int chain_win = Counta(6);
   
   double chart_dd_pc = Counta(7);
   double acc_dd_pc = Counta(8);
   double chart_dd = Counta(9);
   double acc_dd = Counta(10);
   
   double chart_runup_pc = Counta(11);
   double acc_runup_pc = Counta(12);
   double chart_runup = Counta(13);
   double acc_runup = Counta(14);   
   
   double chart_profit = Counta(15);
   double acc_profit = Counta(16);

   double gross_profits= Counta(17);
   double gross_loss = Counta(18);
   
   //pnl vs profit factor
   double profit_factor;
   if (gross_loss!=0 && gross_profits!=0) profit_factor = NormalizeDouble(gross_profits/MathAbs(gross_loss),2);

   //Total volumes vs Average
   double av_volumes;
   if (total_volumes!=0 && total_trades!=0) av_volumes = NormalizeDouble(total_volumes/total_trades,2);

   //Total trades vs winrate
   int winrate;
   if (total_trades!=0) winrate = (total_wins*100/total_trades);

   //Relative DD vs Max DD %
   if (chart_dd_pc < max_dd_pc) max_dd_pc = chart_dd_pc;
   if (acc_dd_pc < max_acc_dd_pc) max_acc_dd_pc = acc_dd_pc;
   //Relative DD vs Max DD $$
   if (chart_dd < max_dd) max_dd = chart_dd;
   if (acc_dd < max_acc_dd) max_acc_dd = acc_dd;

   //Relative runup vs Max runup %
   if (chart_runup_pc > max_runup_pc) max_runup_pc = chart_runup_pc;
   if (acc_runup_pc > max_acc_runup_pc) max_acc_runup_pc = acc_runup_pc;
   //Relative runup vs Max runup $$
   if (chart_runup > max_runup) max_runup = chart_runup;
   if (acc_runup > max_acc_runup) max_acc_runup = acc_runup;
   
   //Spread vs Maxspread
   if (MarketInfo(Symbol(), MODE_SPREAD) > spread) spread = MarketInfo(Symbol(), MODE_SPREAD);
   
   //Chains vs Max chains
   if (chain_loss > max_chain_loss) max_chain_loss = chain_loss;
   if (chain_win > max_chain_win) max_chain_win = chain_win; 
 
//--- Currency crypt

   string curr = "none";

   if (AccountCurrency() == "USD") curr = "$";
   if (AccountCurrency() == "JPY") curr = "¥";
   if (AccountCurrency() == "EUR") curr = "€";
   if (AccountCurrency() == "GBP") curr = "£";
   if (AccountCurrency() == "CHF") curr = "CHF";
   if (AccountCurrency() == "AUD") curr = "A$";
   if (AccountCurrency() == "CAD") curr = "C$";
   if (AccountCurrency() == "RUB") curr = "руб";
   
   if (curr == "none") curr = AccountCurrency();

//--- Equity / balance / floating

   string txt1, content;
   int content_len=StringLen(content);
   
   txt1 = version + "50";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 10);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);
   
   txt1 = version + "51";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 116);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 29);
   }
   ObjectSetText(txt1, "Portfolio", 9, "Century Gothic", color1);

   txt1 = version + "52";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 34);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);

   txt1 = version + "100";
   if(AccountEquity() >= AccountBalance()){
         if (ObjectFind(txt1) == -1) {
            ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
            ObjectSet(txt1, OBJPROP_CORNER, 1);
            ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
            ObjectSet(txt1, OBJPROP_YDISTANCE, 52);
         }
   
         if(chart_profit==0) ObjectSetText(txt1, "Equity : " + DoubleToStr(AccountEquity(), 2) + curr, 16, "Century Gothic", color3);
         if(chart_profit!=0) ObjectSetText(txt1, "Equity : " + DoubleToStr(AccountEquity(), 2) + curr, 11, "Century Gothic", color3);
   }
   if(AccountEquity() < AccountBalance()){
         if (ObjectFind(txt1) == -1) {
            ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
            ObjectSet(txt1, OBJPROP_CORNER, 1);
            ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
            ObjectSet(txt1, OBJPROP_YDISTANCE, 52);
         }
         if(chart_profit==0) ObjectSetText(txt1, "Equity : " + DoubleToStr(AccountEquity(), 2) + curr, 16, "Century Gothic", color4);
         if(chart_profit!=0) ObjectSetText(txt1, "Equity : " + DoubleToStr(AccountEquity(), 2) + curr, 11, "Century Gothic", color4);
   }

   txt1 = version + "101";
   if(chart_profit>0){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 70);
      }
      ObjectSetText(txt1, "Floating chart P&L : +" + DoubleToStr(chart_profit,2) + curr, 9, "Century Gothic", color3);
   }
   if(chart_profit<0){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 70);
      }
      ObjectSetText(txt1, "Floating chart P&L : " + DoubleToStr(chart_profit,2) + curr, 9, "Century Gothic", color4);
   }
   if(OrdersTotal()==0) ObjectDelete(txt1);

   txt1 = version + "102";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      if(TotalOrdersCount()==0) ObjectSet(txt1, OBJPROP_YDISTANCE, 87);
      if(TotalOrdersCount()!=0) ObjectSet(txt1, OBJPROP_YDISTANCE, 87);
   }
   if(TotalOrdersCount()==0) ObjectSetText(txt1, "Balance : " + DoubleToStr(AccountBalance(), 2) + curr, 9, "Century Gothic", color2);
   if(TotalOrdersCount()!=0) ObjectSetText(txt1, "Balance : " + DoubleToStr(AccountBalance(), 2) + curr, 9, "Century Gothic", color2);
   
//--- Analytics

   txt1 = version + "53";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 91);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);

   txt1 = version + "54";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 116);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 110);
   }
   ObjectSetText(txt1, "Analytics", 9, "Century Gothic", color1);

   txt1 = version + "55";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 115);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);

   txt1 = version + "200";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 135);
   }
   if(chart_runup >= 0){
      ObjectSetText(txt1, "Chart runup : " + DoubleToString(chart_runup_pc, 2) + "% [" + DoubleToString(chart_runup, 2) + curr + "]", 8, "Century Gothic", color3);
   }
   if(chart_dd < 0) {
      ObjectSetText(txt1, "Chart drawdown : " + DoubleToString(chart_dd_pc, 2) + "% [" + DoubleToString(chart_dd, 2) + curr + "]", 8, "Century Gothic", color4);
   }
   
   txt1 = version + "201";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 147);
   }
   if(acc_runup >= 0){
      ObjectSetText(txt1, "Acc runup : " + DoubleToString(acc_runup_pc, 2) + "% [" + DoubleToString(acc_runup, 2) + curr + "]" , 8, "Century Gothic", color3);
   }
   if(acc_dd < 0){
      ObjectSetText(txt1, "Acc DD : " + DoubleToString(acc_dd_pc, 2) + "% [" + DoubleToString(acc_dd, 2) + curr + "]" , 8, "Century Gothic", color4);
   }

   txt1 = version + "202";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 159);
   }
   ObjectSetText(txt1, "Max chart runup : " + DoubleToString(max_runup_pc, 2) + "% [" + DoubleToString(max_runup,2) + curr + "]", 8, "Century Gothic", color2);

   txt1 = version + "203";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 171);
   }
   ObjectSetText(txt1, "Max chart drawdon : " + DoubleToString(max_dd_pc, 2) + "% [" + DoubleToString(max_dd,2) + curr + "]", 8, "Century Gothic", color2);

   txt1 = version + "204";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 183);
   }
   ObjectSetText(txt1, "Max acc runup : " + DoubleToString(max_acc_runup_pc, 2) + "% [" + DoubleToString(max_acc_runup,2) + curr + "]", 8, "Century Gothic", color2);

   txt1 = version + "205";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 195);
   }
   ObjectSetText(txt1, "Max acc drawdown : " + DoubleToString(max_acc_dd_pc, 2) + "% [" + DoubleToString(max_acc_dd,2) + curr + "]", 8, "Century Gothic", color2);

   txt1 = version + "206";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 207);
   }
   ObjectSetText(txt1, "Trades won : " + IntegerToString(total_wins, 0) + " II Trades lost : " + IntegerToString(total_loss, 0) + " [" + DoubleToString(winrate,0) + "% winrate]", 8, "Century Gothic", color2);

   txt1 = version + "207";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 219);
   }
   ObjectSetText(txt1, "W-Chain : " + IntegerToString(chain_win, 0) + " [Max : " + IntegerToString(max_chain_win,0) + "] II L-Chain : " + IntegerToString(chain_loss, 0) + " [Max : " + IntegerToString(max_chain_loss,0) + "]", 8, "Century Gothic", color2);

   txt1 = version + "208";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 231);
   }
   ObjectSetText(txt1, "Overall volume traded : " + DoubleToString(total_volumes, 2) + " lots", 8, "Century Gothic", color2);

   txt1 = version + "209";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 243);
   }
   ObjectSetText(txt1, "Average volume /trade : " + DoubleToString(av_volumes, 2) + " lots", 8, "Century Gothic", color2);

   txt1 = version + "210";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 255);
   }
   string expectancy;
   if(total_trades!=0) expectancy = DoubleToStr(total_profit/total_trades, 2);
   
   if(total_trades!=0 && total_profit/total_trades > 0){
      ObjectSetText(txt1, "Payoff expectancy /trade : " + expectancy + curr, 8, "Century Gothic", color3);
   }
   if(total_trades!=0 && total_profit/total_trades < 0){
      ObjectSetText(txt1, "Payoff expectancy /trade : " + expectancy + curr, 8, "Century Gothic", color4);
   }
   if(total_trades==0){
      ObjectSetText(txt1, "Payoff expectancy /trade : NA", 8, "Century Gothic", color3);
   }

   txt1 = version + "211";
   if(total_trades !=0 && profit_factor >= 1){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 267);
      }
      ObjectSetText(txt1, "Profit factor : " + DoubleToString(profit_factor, 2), 8, "Century Gothic", color3);
   }
   if(total_trades !=0 && profit_factor < 1){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 267);
      }
      ObjectSetText(txt1, "Profit factor : " + DoubleToString(profit_factor, 2), 8, "Century Gothic", color4);
   }
   if(total_trades == 0){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 267);
      }
      ObjectSetText(txt1, "Profit factor : NA", 8, "Century Gothic", color3);
   }  
//--- Earnings

   txt1 = version + "56";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 270);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);

   txt1 = version + "57";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 116);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 289);
   }
   ObjectSetText(txt1, "Earnings", 9, "Century Gothic", color1);

   txt1 = version + "58";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 295);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);
   
   double profitx = Earnings(0);
   txt1 = version + "300";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 315);
   }
   ObjectSetText(txt1, "Earnings today : " + DoubleToStr(profitx, 2) + curr, 8, "Century Gothic", color2);

   profitx = Earnings(1);
   txt1 = version + "301";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 327);
   }
   ObjectSetText(txt1, "Earnings yesterday : " + DoubleToStr(profitx, 2) + curr, 8, "Century Gothic", color2);

   profitx = Earnings(2);
   txt1 = version + "302";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 339);
   }
   ObjectSetText(txt1, "Earnings before yesterday : " + DoubleToStr(profitx, 2) + curr, 8, "Century Gothic", color2);

   txt1 = version + "303";
   if(total_profit >= 0){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 351);
      }
      ObjectSetText(txt1, "All time profit : " + DoubleToString(total_profit, 2) + curr, 8, "Century Gothic", color3);
   }
   if(total_profit < 0){
      if (ObjectFind(txt1) == -1) {
         ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
         ObjectSet(txt1, OBJPROP_CORNER, 1);
         ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
         ObjectSet(txt1, OBJPROP_YDISTANCE, 351);
      }
      ObjectSetText(txt1, "All time loss : " + DoubleToString(total_profit, 2) + curr, 8, "Century Gothic", color4);
   }

//--- Broker & Account

   txt1 = version + "59";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 354);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);

   txt1 = version + "60";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 81);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 373);
   }
   ObjectSetText(txt1, "Broker Information", 9, "Century Gothic", color1);

   txt1 = version + "61";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 378);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);
   
   txt1 = version + "400";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 398);
   }
   ObjectSetText(txt1, "Spread : " + DoubleToString(MarketInfo(Symbol(), MODE_SPREAD), 0) + " pts [Max : " + DoubleToString(spread, 0) + " pts]", 8, "Century Gothic", color2);

   txt1 = version + "401";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 410);
   }
   ObjectSetText(txt1, "ID : " + AccountCompany(), 8, "Century Gothic", color2);

   txt1 = version + "402";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 422);
   }
   ObjectSetText(txt1, "Server : " + AccountServer(), 8, "Century Gothic", color2);

   txt1 = version + "403";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 434);
   }
   ObjectSetText(txt1, "Freeze lvl : " + IntegerToString(MarketInfo(Symbol(), MODE_FREEZELEVEL), 0) + " pts II Stop lvl : " + IntegerToString(MarketInfo(Symbol(), MODE_STOPLEVEL), 0) + " pts", 8, "Century Gothic", color2);

   txt1 = version + "404";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 446);
   }
   ObjectSetText(txt1, "L-Swap : " + DoubleToStr(MarketInfo(Symbol(), MODE_SWAPLONG), 2) + curr + "/lot II S-Swap : " + DoubleToStr(MarketInfo(Symbol(), MODE_SWAPSHORT), 2) + curr + "/lot", 8, "Century Gothic", color2);

   txt1 = version + "62";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 449);
   }
   ObjectSetText(txt1, "_______________________________", 10, "Century Gothic", color1);

   txt1 = version + "63";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 116);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 468);
   }
   ObjectSetText(txt1, "Account", 9, "Century Gothic", color1);

   txt1 = version + "64";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 473);
   }
   ObjectSetText(txt1, "_______________________________",  10, "Century Gothic", color1);

   txt1 = version + "500";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 493);
   }
   ObjectSetText(txt1, "ID : " + AccountName() + " [#" + IntegerToString(AccountNumber(),0) + "]", 8, "Century Gothic", color2);

   txt1 = version + "501";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 505);
   }
   ObjectSetText(txt1, "Leverage : " + AccountLeverage() + ":1", 8, "Century Gothic", color2);

   txt1 = version + "502";
   if (ObjectFind(txt1) == -1) {
      ObjectCreate(txt1, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt1, OBJPROP_CORNER, 1);
      ObjectSet(txt1, OBJPROP_XDISTANCE, 10);
      ObjectSet(txt1, OBJPROP_YDISTANCE, 517);
   }
   ObjectSetText(txt1, "Currency : " + AccountCurrency() + " [" + curr + "]", 8, "Century Gothic", color2);
}

//--- Write EA's Name

void Popup() {
   string txt2 = version + "20";
   if (ObjectFind(txt2) == -1) {
      ObjectCreate(txt2, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt2, OBJPROP_CORNER, 0);
      ObjectSet(txt2, OBJPROP_XDISTANCE, 402);
      ObjectSet(txt2, OBJPROP_YDISTANCE, 4);
   }
   ObjectSetText(txt2, "ADX Bone",25, "Century Gothic", color1);
   
   txt2 = version + "21";
   if (ObjectFind(txt2) == -1) {
      ObjectCreate(txt2, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt2, OBJPROP_CORNER, 0);
      ObjectSet(txt2, OBJPROP_XDISTANCE, 432);
      ObjectSet(txt2, OBJPROP_YDISTANCE, 49);
   }
   ObjectSetText(txt2, "by Edorenta || version " + version, 8, "Arial", Gray);
   
   txt2 = version + "22";
   if (ObjectFind(txt2) == -1) {
      ObjectCreate(txt2, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt2, OBJPROP_CORNER, 0);
      ObjectSet(txt2, OBJPROP_XDISTANCE, 398);
      ObjectSet(txt2, OBJPROP_YDISTANCE, 35);
   }
   ObjectSetText(txt2, "______________________________", 8, "Arial", Gray);
   
   txt2 = version + "23";
   if (ObjectFind(txt2) == -1) {
      ObjectCreate(txt2, OBJ_LABEL, 0, 0, 0);
      ObjectSet(txt2, OBJPROP_CORNER, 0);
      ObjectSet(txt2, OBJPROP_XDISTANCE, 398);
      ObjectSet(txt2, OBJPROP_YDISTANCE, 50);
   }
   ObjectSetText(txt2, "______________________________", 8, "Arial", Gray);
}

/*       ________________________________________________
         T                                              T
         T              BYE BYE /terminate              T
         T______________________________________________T

*/
