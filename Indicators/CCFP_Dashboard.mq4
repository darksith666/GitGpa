
#property copyright "GVC"
#property link      "http://www.metaquotes.net"
#property version   "1.00"
#property strict
#include <stdlib.mqh>
#include <WinUser32.mqh>
#include <ChartObjects\ChartObjectsTxtControls.mqh>

#define BullColor Lime
#define BearColor Red

input string suffix           ="";
input int    Magic_Number     = 1234;
input double lot              = 0.01;
input int  Basket_Target      = 0; 
input int  Basket_StopLoss    = 0; 
input int   x_axis            =10;
input int   y_axis            =50;
input bool UseDefaultPairs    =true;
input bool UseCurrent         =true;
input bool UseC1ForR1              =false;
input bool UseC2ForR1              =false;
input bool UseC3ForR1              =false;
input bool UseC4ForR1              =false;
input bool UseH1ForR1              =false;
input bool UseH4ForR1              =false;
input bool UseD1ForR1              =false;
input bool UseW1ForR1              =false;
input bool UseMNForR1              =false;

input bool UseC1ForR2              =false;
input bool UseC2ForR2              =false;
input bool UseC3ForR2              =false;
input bool UseC4ForR2              =false;
input bool UseH1ForR2              =false;
input bool UseH4ForR2              =false;
input bool UseD1ForR2              =false;
input bool UseW1ForR2              =false;
input bool UseMNForR2              =false;
input bool UseR1ForSig             =true;
input bool UseR2ForSig             =false;


string button_close_basket_All = "btn_Close ALL"; 
string button_buy_basket_1 = "btn_buy_basket";  
string button_sell_basket_1 = "btn_sell_basket";
string button_close_basket_1 = "btn_Close Order";
string button_buy_basket_2 = "btn_buy_basket2";  
string button_sell_basket_2 = "btn_sell_basket2";
string button_close_basket_2 = "btn_Close Order2";
string button_buy_basket_3 = "btn_buy_basket3";  
string button_sell_basket_3 = "btn_sell_basket3";
string button_close_basket_3 = "btn_Close Order3";
string button_buy_basket_4 = "btn_buy_basket4";  
string button_sell_basket_4 = "btn_sell_basket4";
string button_close_basket_4 = "btn_Close Order4";
string button_buy_basket_5 = "btn_buy_basket5";  
string button_sell_basket_5 = "btn_sell_basket5";
string button_close_basket_5 = "btn_Close Order5";
string button_buy_basket_6 = "btn_buy_basket6";  
string button_sell_basket_6 = "btn_sell_basket6";
string button_close_basket_6 = "btn_Close Order6";
string button_buy_basket_7 = "btn_buy_basket7";  
string button_sell_basket_7 = "btn_sell_basket7";
string button_close_basket_7 = "btn_Close Order7";
string button_buy_basket_8 = "btn_buy_basket8";  
string button_sell_basket_8 = "btn_sell_basket8";
string button_close_basket_8 = "btn_Close Order8";
string button_buy_basket_9 = "btn_buy_basket9";  
string button_sell_basket_9 = "btn_sell_basket9";
string button_close_basket_9 = "btn_Close Order9";
string button_buy_basket_10 = "btn_buy_basket10";  
string button_sell_basket_10 = "btn_sell_basket10";
string button_close_basket_10 = "btn_Close Order10";
string button_buy_basket_11 = "btn_buy_basket11";  
string button_sell_basket_11 = "btn_sell_basket11";
string button_close_basket_11 = "btn_Close Order11";
string button_buy_basket_12 = "btn_buy_basket12";  
string button_sell_basket_12 = "btn_sell_basket12";
string button_close_basket_12 = "btn_Close Order12";
string button_buy_basket_13 = "btn_buy_basket13";  
string button_sell_basket_13 = "btn_sell_basket13";
string button_close_basket_13 = "btn_Close Order13";
string button_buy_basket_14 = "btn_buy_basket14";  
string button_sell_basket_14 = "btn_sell_basket14";
string button_close_basket_14 = "btn_Close Order14";
string button_buy_basket_15 = "btn_buy_basket15";  
string button_sell_basket_15 = "btn_sell_basket15";
string button_close_basket_15 = "btn_Close Order15";
string button_buy_basket_16 = "btn_buy_basket16";  
string button_sell_basket_16 = "btn_sell_basket16";
string button_close_basket_16 = "btn_Close Order16";
string button_buy_basket_17 = "btn_buy_basket17";  
string button_sell_basket_17 = "btn_sell_basket17";
string button_close_basket_17 = "btn_Close Order17";
string button_buy_basket_18 = "btn_buy_basket18";  
string button_sell_basket_18 = "btn_sell_basket18";
string button_close_basket_18 = "btn_Close Order18";
string button_buy_basket_19 = "btn_buy_basket19";  
string button_sell_basket_19 = "btn_sell_basket19";
string button_close_basket_19 = "btn_Close Order19";
string button_buy_basket_20 = "btn_buy_basket20";  
string button_sell_basket_20 = "btn_sell_basket20";
string button_close_basket_20 = "btn_Close Order20";
string button_buy_basket_21 = "btn_buy_basket21";  
string button_sell_basket_21 = "btn_sell_basket21";
string button_close_basket_21 = "btn_Close Order21";
string button_buy_basket_22 = "btn_buy_basket22";  
string button_sell_basket_22 = "btn_sell_basket22";
string button_close_basket_22 = "btn_Close Order22";
string button_buy_basket_23 = "btn_buy_basket23";  
string button_sell_basket_23 = "btn_sell_basket23";
string button_close_basket_23 = "btn_Close Order23";
string button_buy_basket_24 = "btn_buy_basket24";  
string button_sell_basket_24 = "btn_sell_basket24";
string button_close_basket_24 = "btn_Close Order24";
string button_buy_basket_25 = "btn_buy_basket25";  
string button_sell_basket_25 = "btn_sell_basket25";
string button_close_basket_25 = "btn_Close Order25";
string button_buy_basket_26 = "btn_buy_basket26";  
string button_sell_basket_26 = "btn_sell_basket26";
string button_close_basket_26 = "btn_Close Order26";
string button_buy_basket_27 = "btn_buy_basket27";  
string button_sell_basket_27 = "btn_sell_basket27";
string button_close_basket_27 = "btn_Close Order27";
string button_buy_basket_28 = "btn_buy_basket28";  
string button_sell_basket_28 = "btn_sell_basket28";
string button_close_basket_28 = "btn_Close Order28";
 
string   _font="Consolas";
double PairPip;
double Pips[28],Spread[28],Signalm1[28],Signalm5[28],Signalm15[28],Signalm30[28],Signalh1[28],Signalh4[28],Signald1[28],
       Signalw1[28],Signalmn[28],Signalhah4[28],Signalhad1[28],Signalhaw1[28];
color ProfitColor,ProfitColor1,ProfitColor2,ProfitColor3,PipsColor,Color,Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8,Color9,Color10,
      Color11,LotColor,LotColor1,OrdColor,OrdColor1;
color BackGrnCol =clrDarkGray;
color LineColor=clrBlack;
color TextColor=clrBlack;
double adr1[28],adr5[28],adr10[28],adr20[28],adr[28];
int ticket,pipsfactor;
int    orders  = 0;
double blots[28],slots[28],bprofit[28],sprofit[28],tprofit[28],bpos[28],spos[28];
bool CloseAll;
string TradePair[];
int SymbolCount=0;
string Defaultpairs[28]={ "AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD","CADCHF","CADJPY",
                       "CHFJPY","EURAUD","EURCAD","EURCHF","EURGBP","EURJPY",
                       "EURNZD","EURUSD","GBPAUD","GBPCAD","GBPCHF",
                       "GBPJPY","GBPNZD","GBPUSD","NZDCAD",
                       "NZDCHF","NZDJPY","NZDUSD","USDCAD",
                       "USDCHF","USDJPY" };
int offset = 1;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {   
   if (UseDefaultPairs == true) {
      ArrayCopy(TradePair,Defaultpairs);
      for(int i=0;i<28;i++)
         TradePair[i] = TradePair[i]+suffix;
  } else {
      CreateSymbolList();
  } 
   OnTick();
//--- indicator buffers mapping
   EventSetTimer(10);
//---
   if (UseCurrent == true)
      offset = 0;
   else
      offset = 1;

//   Print("ICUSTOM");
//   iCustom(Symbol(),PERIOD_M1,"CCFp-Diff_[v2.0]","",1,1930,0,1930,0,"",PERIOD_H1,true,false,0,0);
//   iCustom(Symbol(),PERIOD_M1,"CCFp-Diff_[v2.0]","",2,1930,0,1930,0,"",PERIOD_D1,true,false,0,0);
//   iCustom(Symbol(),PERIOD_M1,"CCFp-Diff_[v2.0]","",3,1930,0,1930,0,"",PERIOD_W1,true,false,0,0);
//   iCustom(Symbol(),PERIOD_M1,"CCFp-Diff_[v2.0]","",4,1930,0,1930,0,"",PERIOD_M1,true,false,0,0);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   ObjectsDeleteAll();
      
  }
//--------------------------------------------------------------------------------------------

string Currency[] =  {  "USD", "EUR", "GBP", "CHF", "JPY", "AUD", "CAD", "NZD"};
 string CreateSymbolList() {
   string allsyms;
    string TempSymbol;
   
  
   int Sym = ArrayRange(Currency, 0);
   for (int i = 0; i < Sym; i++) {
      for (int a = 0; a < Sym; a++) {
         TempSymbol = Currency[i] + Currency[a] + suffix;
         if (MarketInfo(TempSymbol, MODE_BID) > 0.0) {
            ArrayResize(TradePair, SymbolCount + 1);
            TradePair[SymbolCount] = TempSymbol;
            allsyms = allsyms + TempSymbol;            
            SymbolCount++;
         }
       
         }
}
   return (allsyms);
}  

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+  
void OnTick()
  {
  
   for(int i=0;i<ArraySize(TradePair);i++)
     {
      
      if(Point==0.0001 || Point==0.01) 
        {
         PairPip=MarketInfo(TradePair[i],MODE_POINT);
         pipsfactor=1;
           } else if(Point==0.00001 || Point==0.001) {
         PairPip=MarketInfo(TradePair[i],MODE_POINT)*10;
         pipsfactor=10;
        }
     
           
      Spread[i]=MarketInfo(TradePair[i],MODE_SPREAD)/pipsfactor;  

      double Openm1    = iOpen(TradePair[i], PERIOD_M1,offset);
      double Closem1   = iClose(TradePair[i],PERIOD_M1,offset);
      double Openm5    = iOpen(TradePair[i], PERIOD_M5,offset);
      double Closem5   = iClose(TradePair[i],PERIOD_M5,offset);
      double Openm15    = iOpen(TradePair[i], PERIOD_M15,offset);
      double Closem15   = iClose(TradePair[i],PERIOD_M15,offset);
      double Openm30    = iOpen(TradePair[i], PERIOD_M30,offset);
      double Closem30   = iClose(TradePair[i],PERIOD_M30,offset);
      double Openh1    = iOpen(TradePair[i], PERIOD_H1,offset);
      double Closeh1   = iClose(TradePair[i],PERIOD_H1,offset);
      double OpenP    = iOpen(TradePair[i], PERIOD_D1,offset);
      double CloseP   = iClose(TradePair[i],PERIOD_D1,offset);
      double Open4    = iOpen(TradePair[i], PERIOD_H4,offset);
      double Close4   = iClose(TradePair[i],PERIOD_H4,offset);
      double Openw    = iOpen(TradePair[i], PERIOD_W1,offset);
      double Closew   = iClose(TradePair[i],PERIOD_W1,offset);
      double Openmn    = iOpen(TradePair[i], PERIOD_MN1,offset);
      double Closemn   = iClose(TradePair[i],PERIOD_MN1,offset);

      Pips[i]=(iClose(TradePair[i],PERIOD_D1,0)-iOpen(TradePair[i], PERIOD_D1,0))/MarketInfo(TradePair[i],MODE_POINT)/pipsfactor;
//      if(Closem1>Openm1)Signalm1[i]=1;
//      if(Closem1<Openm1)Signalm1[i]=-1;
//      if(Closem5>Openm5)Signalm5[i]=1;
//      if(Closem5<Openm5)Signalm5[i]=-1;
//      if(Closem15>Openm15)Signalm15[i]=1;
//      if(Closem15<Openm15)Signalm15[i]=-1;
//      if(Closem30>Openm30)Signalm30[i]=1;
//      if(Closem30<Openm30)Signalm30[i]=-1;
      if(Closeh1>Openh1)Signalh1[i]=1;
      if(Closeh1<Openh1)Signalh1[i]=-1;
      if(Close4>Open4)Signalh4[i]=1;
      if(Close4<Open4)Signalh4[i]=-1;
      if(CloseP>OpenP)Signald1[i]=1;
      if(CloseP<OpenP)Signald1[i]=-1;
      if(Closew>Openw)Signalw1[i]=1;
      if(Closew<Openw)Signalw1[i]=-1;
      if(Closemn>Openmn)Signalmn[i]=1;
      if(Closemn<Openmn)Signalmn[i]=-1;

// CCFP for Signalm1 -> Signalm30
      getCCFPSignals(i);
// End
      double s=0.0;
      int n=1;     
      for(int a=1;a<=20;a++)
        {
         s=s+(iHigh(TradePair[i],PERIOD_D1,n)-iLow(TradePair[i],PERIOD_D1,n))/PairPip;
         if(a==1) adr1[i]=MathRound(s);
         if(a==5) adr5[i]=MathRound(s/5);
         if(a==10) adr10[i]=MathRound(s/10);
         if(a==20) adr20[i]=MathRound(s/20);
         n++; 
        }
      adr[i]=MathRound((adr1[i]+adr5[i]+adr10[i]+adr20[i])/4.0);

      
      double BB1=iMA(TradePair[i],PERIOD_H4,12,0,MODE_SMA,PRICE_CLOSE,0);      
      double BB10 = iMA(TradePair[i], PERIOD_D1,12,0,MODE_SMA,PRICE_CLOSE,0);       
      
//      if(Close4>BB1 )Signalhah4[i]=1;
//      if(Close4<BB1 )Signalhah4[i]=-1;
//      if(CloseP>BB10 )Signalhad1[i]=1;
//      if(CloseP<BB10 )Signalhad1[i]=-1;
      Signalhad1[i] = 0;
      Signalhah4[i] = 0;      
      if (UseC1ForR1 == true || UseC2ForR1 == true || UseC3ForR1 == true || UseC4ForR1 == true ||
          UseH1ForR1 == true || UseH4ForR1 == true || UseD1ForR1 == true || UseW1ForR1 == true || UseMNForR1 == true) {
      if ((UseC1ForR1 == false || Signalm1[i] == 1) &&
         (UseC2ForR1 == false || Signalm5[i] == 1) &&
         (UseC3ForR1 == false || Signalm15[i] == 1) &&
         (UseC4ForR1 == false || Signalm30[i] == 1) &&
         (UseH1ForR1 == false || Signalh1[i] == 1) &&
         (UseH4ForR1 == false || Signalh4[i] == 1) &&
         (UseD1ForR1 == false || Signald1[i] == 1) &&
         (UseW1ForR1 == false || Signalw1[i] == 1) &&
         (UseMNForR1 == false || Signalmn[i] == 1))
         Signalhah4[i] = 1;
      if ((UseC1ForR1 == false || Signalm1[i] == -1) &&
         (UseC2ForR1 == false || Signalm5[i] == -1) &&
         (UseC3ForR1 == false || Signalm15[i] == -1) &&
         (UseC4ForR1 == false || Signalm30[i] == -1) &&
         (UseH1ForR1 == false || Signalh1[i] == -1) &&
         (UseH4ForR1 == false || Signalh4[i] == -1) &&
         (UseD1ForR1 == false || Signald1[i] == -1) &&
         (UseW1ForR1 == false || Signalw1[i] == -1) &&
         (UseMNForR1 == false || Signalmn[i] == -1))
         Signalhah4[i] = -1;
      }
      if (UseC1ForR2 == true || UseC2ForR2 == true || UseC3ForR2 == true || UseC4ForR2 == true ||
          UseH1ForR2 == true || UseH4ForR2 == true || UseD1ForR2 == true || UseW1ForR2 == true || UseMNForR2 == true) {
      if ((UseC1ForR2 == false || Signalm1[i] == 1) &&
         (UseC2ForR2 == false || Signalm5[i] == 1) &&
         (UseC3ForR2 == false || Signalm15[i] == 1) &&
         (UseC4ForR2 == false || Signalm30[i] == 1) &&
         (UseH1ForR2 == false || Signalh1[i] == 1) &&
         (UseH4ForR2 == false || Signalh4[i] == 1) &&
         (UseD1ForR2 == false || Signald1[i] == 1) &&
         (UseW1ForR2 == false || Signalw1[i] == 1) &&
         (UseMNForR2 == false || Signalmn[i] == 1))
         Signalhad1[i] = 1;
      if ((UseC1ForR2 == false || Signalm1[i] == -1) &&
         (UseC2ForR2 == false || Signalm5[i] == -1) &&
         (UseC3ForR2 == false || Signalm15[i] == -1) &&
         (UseC4ForR2 == false || Signalm30[i] == -1) &&
         (UseH1ForR2 == false || Signalh1[i] == -1) &&
         (UseH4ForR2 == false || Signalh4[i] == -1) &&
         (UseD1ForR2 == false || Signald1[i] == -1) &&
         (UseW1ForR2 == false || Signalw1[i] == -1) &&
         (UseMNForR2 == false || Signalmn[i] == -1))
         Signalhad1[i] = -1;
      }
     }


   return;
  }


   
   
   
     
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---   
int labelcolor;

    if(CloseAll)
      {
         close_basket(Magic_Number);
         if(OrdersTotal()==0)
         {
            
            CloseAll=false;
         }
      }
      //- Target
      if(Basket_Target>0 && TotalProfit()>=Basket_Target) CloseAll=true;

      //- StopLoss
      if(Basket_StopLoss>0 && TotalProfit()<(0-Basket_StopLoss)) CloseAll=true; 
      
    Trades();
   TotalProfit();  
  
   for(int i=0;i<ArraySize(TradePair);i++)  
        {
       ObjectDelete("Pips"+IntegerToString(i)); 
       ObjectDelete("TtlProf"+IntegerToString(i));
       ObjectDelete("bLots"+IntegerToString(i));
       ObjectDelete("sLots"+IntegerToString(i));
       ObjectDelete("bPos"+IntegerToString(i));
       ObjectDelete("sPos"+IntegerToString(i));  
       ObjectDelete("TProf"+IntegerToString(i));
       ObjectDelete("SProf"+IntegerToString(i));
       ObjectDelete("Sig"+IntegerToString(i));
       ObjectDelete("SGD"+IntegerToString(i));
       ObjectDelete("TotProf");
       
         if(blots[i]>0){LotColor =Orange;}        
         if(blots[i]==0){LotColor =clrWhite;}
         if(slots[i]>0){LotColor1 =Orange;}        
         if(slots[i]==0){LotColor1 =clrWhite;}
         if(bpos[i]>0){OrdColor =DodgerBlue;}        
         if(bpos[i]==0){OrdColor =clrWhite;}
         if(spos[i]>0){OrdColor1 =DodgerBlue;}        
         if(spos[i]==0){OrdColor1 =clrWhite;}
         if(bprofit[i]>0){ProfitColor =BullColor;}
         if(bprofit[i]<0){ProfitColor =BearColor;}
         if(bprofit[i]==0){ProfitColor =clrWhite;}
         if(sprofit[i]>0){ProfitColor2 =BullColor;}
         if(sprofit[i]<0){ProfitColor2 =BearColor;}
         if(sprofit[i]==0){ProfitColor2 =clrWhite;}
         if(tprofit[i]>0){ProfitColor3 =BullColor;}
         if(tprofit[i]<0){ProfitColor3 =BearColor;}
         if(tprofit[i]==0){ProfitColor3 =clrWhite;}
         if(TotalProfit()>0){ProfitColor1 =BullColor;}
         if(TotalProfit()<0){ProfitColor1 =BearColor;}
         if(TotalProfit()==0){ProfitColor1 =clrWhite;}         
         if(Pips[i]>0){PipsColor =BullColor;}
         if(Pips[i]<0){PipsColor =BearColor;} 
         if(Pips[i]==0){PipsColor =clrWhite;}       
         Color = clrNONE;
         Color1 = clrNONE;
         Color2 = clrNONE;
         Color3 = clrNONE;
         Color9 = clrNONE;
         Color10 = clrNONE;
         if(Signalm1[i]==1){Color=BullColor;}
         if(Signalm1[i]==-1){Color=BearColor;}
         if(Signalm5[i]==1){Color1=BullColor;}         
         if(Signalm5[i]==-1){Color1 =BearColor;}
         if(Signalm15[i]==1){Color2 =BullColor;}
         if(Signalm15[i]==-1){Color2=BearColor;}
         if(Signalm30[i]==1){Color3=BullColor;}
         if(Signalm30[i]==-1){Color3=BearColor;}
         if(Signalh1[i]==1){Color4=BullColor;}
         if(Signalh1[i]==-1){Color4=BearColor;}
         if(Signalh4[i]==1){Color5=BullColor;}
         if(Signalh4[i]==-1){Color5=BearColor;}
         if(Signald1[i]==1){Color6=BullColor;}
         if(Signald1[i]==-1){Color6=BearColor;}
         if(Signalw1[i]==1){Color7=BullColor;}
         if(Signalw1[i]==-1){Color7=BearColor;}
         if(Signalmn[i]==1){Color8=BullColor;}
         if(Signalmn[i]==-1){Color8=BearColor;}
         SetObjText("Sig"+IntegerToString(i),CharToStr(233),x_axis+464,(i*16)+y_axis,clrNONE,9);
         if(Signalhah4[i]==1){SetObjText("Sig"+IntegerToString(i),CharToStr(233),x_axis+464,(i*16)+y_axis,BullColor,9);Color9=BullColor;}
         if(Signalhah4[i]==-1){SetObjText("Sig"+IntegerToString(i),CharToStr(234),x_axis+464,(i*16)+y_axis+2,BearColor,9);Color9=BearColor;}
         SetObjText("SGD"+IntegerToString(i),CharToStr(233),x_axis+494,(i*16)+y_axis,clrNONE,9);
         if(Signalhad1[i]==1){SetObjText("SGD"+IntegerToString(i),CharToStr(233),x_axis+494,(i*16)+y_axis,BullColor,9);Color10=BullColor;}
         if(Signalhad1[i]==-1){SetObjText("SGD"+IntegerToString(i),CharToStr(234),x_axis+494,(i*16)+y_axis+2,BearColor,9);Color10=BearColor;}
         if(OrdersTotal()==0){SetText("CTP","No Trades To Monitor",x_axis+980,y_axis-25,Yellow,8);}
         if(OrdersTotal()>0 ){SetText("CTP","Monitoring Trades",x_axis+980,y_axis-25,Yellow,8);}
         SetText("TPr","Basket TakeProfit = "+DoubleToStr(Basket_Target,0),x_axis+980,y_axis-5,Yellow,8);
         SetText("SL","Basket StopLoss = -"+DoubleToStr(Basket_StopLoss,0),x_axis+980,y_axis+15,Yellow,8);

         labelcolor = BackGrnCol;
         if (UseR1ForSig == true || UseR2ForSig == true) {
         if ((UseR1ForSig == false || Signalhah4[i] == 1) && (UseR2ForSig == false || Signalhad1[i] == 1))
            labelcolor = clrGreen;
         else if ((UseR1ForSig == false || Signalhah4[i] == -1) && (UseR2ForSig == false || Signalhad1[i] == -1))
            labelcolor = clrRed;
         }         
         SetPanel("Bar",0,x_axis,y_axis-30,980,27,Maroon,LineColor,1);
        // SetPanel("Bar1",0,x_axis+978,y_axis-5,121,80,Maroon,Maroon,1);
         SetPanel("Panel"+IntegerToString(i),0,x_axis,(i*16)+y_axis,55,15,labelcolor,LineColor,1);
         SetPanel("Spread"+IntegerToString(i),0,x_axis+70,(i*16)+y_axis-2,25,17,Black,White,1);
         SetPanel("Pips"+IntegerToString(i),0,x_axis+100,(i*16)+y_axis-2,25,17,Black,White,1);
         SetPanel("Adr"+IntegerToString(i),0,x_axis+140,(i*16)+y_axis-2,25,17,Black,White,1);
         SetPanel("m1"+IntegerToString(i),0,x_axis+180,(i*16)+y_axis,25,15,Color,White,1);
         SetPanel("m5"+IntegerToString(i),0,x_axis+210,(i*16)+y_axis,25,15,Color1,White,1);
         SetPanel("m15"+IntegerToString(i),0,x_axis+240,(i*16)+y_axis,25,15,Color2,White,1);
         SetPanel("m30"+IntegerToString(i),0,x_axis+270,(i*16)+y_axis,25,15,Color3,White,1);
         SetPanel("h1"+IntegerToString(i),0,x_axis+300,(i*16)+y_axis,25,15,Color4,White,1);
         SetPanel("h4"+IntegerToString(i),0,x_axis+330,(i*16)+y_axis,25,15,Color5,White,1);
         SetPanel("d1"+IntegerToString(i),0,x_axis+360,(i*16)+y_axis,25,15,Color6,White,1);
         SetPanel("w1"+IntegerToString(i),0,x_axis+390,(i*16)+y_axis,25,15,Color7,White,1);
         SetPanel("mn1"+IntegerToString(i),0,x_axis+420,(i*16)+y_axis,25,15,Color8,White,1);
         SetPanel("ha4"+IntegerToString(i),0,x_axis+460,(i*16)+y_axis-2,20,17,Color9,White,1);
         SetPanel("had1"+IntegerToString(i),0,x_axis+490,(i*16)+y_axis-2,20,17,Color10,White,1);
         SetPanel("TP",0,x_axis+920,y_axis-27,55,20,Black,White,1);
         SetPanel("TP1",0,x_axis+978,y_axis-27,125,20,Black,White,1);
         SetPanel("TP2",0,x_axis+978,y_axis-8,125,20,Black,White,1);
         SetPanel("TP3",0,x_axis+978,y_axis+11,125,20,Black,White,1);


         SetText("Pair"+IntegerToString(i),TradePair[i],x_axis+2,(i*16)+y_axis+2,clrWhite,8);
         SetText("Symbol","Symbol      Spread   Pips     ADR",x_axis+4,y_axis-25,White,8);
         SetText("Direct","CCFP Suggestion               Candle Direction",x_axis+200,y_axis-30,White,8);
         SetText("Trend","C1     C2      C3      C4     H1      H4     D1     W1     MN",x_axis+183,y_axis-17,White,8);
         SetText("Signal","Signal",x_axis+465,y_axis-30,White,8);
         SetText("MA","R1      R2",x_axis+462,y_axis-17,White,8);
         SetText("Trades","Buy       Sell      Buy   Sell       Buy       Sell",x_axis+710,y_axis-17,White,8);
         SetText("TTr","Lots              Orders",x_axis+730,y_axis-30,White,8);
         SetText("Tottrade","Profit",x_axis+860,y_axis-30,White,8);
         SetText("Spr1"+IntegerToString(i),DoubleToStr(Spread[i],1),x_axis+72,(i*16)+y_axis,Orange,8);
         SetText("Pp1"+IntegerToString(i),DoubleToStr(MathAbs(Pips[i]),0),x_axis+103,(i*16)+y_axis,PipsColor,8);
         SetText("S1"+IntegerToString(i),DoubleToStr(adr[i],0),x_axis+143,(i*16)+y_axis,Yellow,8);
         SetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),x_axis+710,(i*16)+y_axis,LotColor,8);
         SetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),x_axis+750,(i*16)+y_axis,LotColor1,8);
         SetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),x_axis+790,(i*16)+y_axis,OrdColor,8);
         SetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),x_axis+820,(i*16)+y_axis,OrdColor1,8);
         SetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),x_axis+850,(i*16)+y_axis,ProfitColor,8);
         SetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),x_axis+890,(i*16)+y_axis,ProfitColor2,8);
         SetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),x_axis+940,(i*16)+y_axis,ProfitColor3,8);
         SetText("TotProf",DoubleToStr(MathAbs(TotalProfit()),2),x_axis+925,y_axis-22,ProfitColor1,8);
         
       Create_Button(button_close_basket_All,"CLOSE ALL",90 ,18,x_axis+560 ,y_axis-25,clrDarkGray,clrRed);
       Create_Button(button_buy_basket_1,"BUY",50 ,15,x_axis+520,y_axis,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_1,"SELL",50 ,15,x_axis+580 ,y_axis,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_1,"CLOSE",50 ,15,x_axis+640 ,y_axis,clrRed,clrWhite);
       Create_Button(button_buy_basket_2,"BUY",50 ,15,x_axis+520,y_axis+16,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_2,"SELL",50 ,15,x_axis+580 ,y_axis+16,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_2,"CLOSE",50 ,15,x_axis+640 ,y_axis+16,clrRed,clrWhite);
       Create_Button(button_buy_basket_3,"BUY",50 ,15,x_axis+520,y_axis+32,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_3,"SELL",50 ,15,x_axis+580 ,y_axis+32,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_3,"CLOSE",50 ,15,x_axis+640 ,y_axis+32,clrRed,clrWhite);
       Create_Button(button_buy_basket_4,"BUY",50 ,15,x_axis+520,y_axis+48,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_4,"SELL",50 ,15,x_axis+580 ,y_axis+48,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_4,"CLOSE",50 ,15,x_axis+640 ,y_axis+48,clrRed,clrWhite);
       Create_Button(button_buy_basket_5,"BUY",50 ,15,x_axis+520,y_axis+64,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_5,"SELL",50 ,15,x_axis+580 ,y_axis+64,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_5,"CLOSE",50 ,15,x_axis+640 ,y_axis+64,clrRed,clrWhite);
       Create_Button(button_buy_basket_6,"BUY",50 ,15,x_axis+520,y_axis+80,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_6,"SELL",50 ,15,x_axis+580 ,y_axis+80,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_6,"CLOSE",50 ,15,x_axis+640 ,y_axis+80,clrRed,clrWhite);
       Create_Button(button_buy_basket_7,"BUY",50 ,15,x_axis+520,y_axis+96,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_7,"SELL",50 ,15,x_axis+580 ,y_axis+96,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_7,"CLOSE",50 ,15,x_axis+640 ,y_axis+96,clrRed,clrWhite);
       Create_Button(button_buy_basket_8,"BUY",50 ,15,x_axis+520,y_axis+112,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_8,"SELL",50 ,15,x_axis+580 ,y_axis+112,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_8,"CLOSE",50 ,15,x_axis+640 ,y_axis+112,clrRed,clrWhite);
       Create_Button(button_buy_basket_9,"BUY",50 ,15,x_axis+520,y_axis+128,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_9,"SELL",50 ,15,x_axis+580 ,y_axis+128,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_9,"CLOSE",50 ,15,x_axis+640 ,y_axis+128,clrRed,clrWhite);
       Create_Button(button_buy_basket_10,"BUY",50 ,15,x_axis+520,y_axis+144,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_10,"SELL",50 ,15,x_axis+580 ,y_axis+144,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_10,"CLOSE",50 ,15,x_axis+640 ,y_axis+144,clrRed,clrWhite);
       Create_Button(button_buy_basket_11,"BUY",50 ,15,x_axis+520,y_axis+160,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_11,"SELL",50 ,15,x_axis+580 ,y_axis+160,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_11,"CLOSE",50 ,15,x_axis+640 ,y_axis+160,clrRed,clrWhite);
       Create_Button(button_buy_basket_12,"BUY",50 ,15,x_axis+520,y_axis+176,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_12,"SELL",50 ,15,x_axis+580 ,y_axis+176,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_12,"CLOSE",50 ,15,x_axis+640 ,y_axis+176,clrRed,clrWhite);
       Create_Button(button_buy_basket_13,"BUY",50 ,15,x_axis+520,y_axis+192,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_13,"SELL",50 ,15,x_axis+580 ,y_axis+192,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_13,"CLOSE",50 ,15,x_axis+640 ,y_axis+192,clrRed,clrWhite);
       Create_Button(button_buy_basket_14,"BUY",50 ,15,x_axis+520,y_axis+208,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_14,"SELL",50 ,15,x_axis+580 ,y_axis+208,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_14,"CLOSE",50 ,15,x_axis+640 ,y_axis+208,clrRed,clrWhite);
       Create_Button(button_buy_basket_15,"BUY",50 ,15,x_axis+520,y_axis+224,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_15,"SELL",50 ,15,x_axis+580 ,y_axis+224,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_15,"CLOSE",50 ,15,x_axis+640 ,y_axis+224,clrRed,clrWhite);
       Create_Button(button_buy_basket_16,"BUY",50 ,15,x_axis+520,y_axis+240,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_16,"SELL",50 ,15,x_axis+580 ,y_axis+240,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_16,"CLOSE",50 ,15,x_axis+640 ,y_axis+240,clrRed,clrWhite);
       Create_Button(button_buy_basket_17,"BUY",50 ,15,x_axis+520,y_axis+256,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_17,"SELL",50 ,15,x_axis+580 ,y_axis+256,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_17,"CLOSE",50 ,15,x_axis+640 ,y_axis+256,clrRed,clrWhite);
       Create_Button(button_buy_basket_18,"BUY",50 ,15,x_axis+520,y_axis+272,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_18,"SELL",50 ,15,x_axis+580 ,y_axis+272,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_18,"CLOSE",50 ,15,x_axis+640 ,y_axis+272,clrRed,clrWhite);
       Create_Button(button_buy_basket_19,"BUY",50 ,15,x_axis+520,y_axis+288,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_19,"SELL",50 ,15,x_axis+580 ,y_axis+288,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_19,"CLOSE",50 ,15,x_axis+640 ,y_axis+288,clrRed,clrWhite);
       Create_Button(button_buy_basket_20,"BUY",50 ,15,x_axis+520,y_axis+304,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_20,"SELL",50 ,15,x_axis+580 ,y_axis+304,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_20,"CLOSE",50 ,15,x_axis+640 ,y_axis+304,clrRed,clrWhite);
       Create_Button(button_buy_basket_21,"BUY",50 ,15,x_axis+520,y_axis+320,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_21,"SELL",50 ,15,x_axis+580 ,y_axis+320,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_21,"CLOSE",50 ,15,x_axis+640 ,y_axis+320,clrRed,clrWhite);
       Create_Button(button_buy_basket_22,"BUY",50 ,15,x_axis+520,y_axis+336,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_22,"SELL",50 ,15,x_axis+580 ,y_axis+336,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_22,"CLOSE",50 ,15,x_axis+640 ,y_axis+336,clrRed,clrWhite);
       Create_Button(button_buy_basket_23,"BUY",50 ,15,x_axis+520,y_axis+352,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_23,"SELL",50 ,15,x_axis+580 ,y_axis+352,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_23,"CLOSE",50 ,15,x_axis+640 ,y_axis+352,clrRed,clrWhite);
       Create_Button(button_buy_basket_24,"BUY",50 ,15,x_axis+520,y_axis+368,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_24,"SELL",50 ,15,x_axis+580 ,y_axis+368,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_24,"CLOSE",50 ,15,x_axis+640 ,y_axis+368,clrRed,clrWhite);
       Create_Button(button_buy_basket_25,"BUY",50 ,15,x_axis+520,y_axis+384,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_25,"SELL",50 ,15,x_axis+580 ,y_axis+384,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_25,"CLOSE",50 ,15,x_axis+640 ,y_axis+384,clrRed,clrWhite);
       Create_Button(button_buy_basket_26,"BUY",50 ,15,x_axis+520,y_axis+400,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_26,"SELL",50 ,15,x_axis+580 ,y_axis+400,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_26,"CLOSE",50 ,15,x_axis+640 ,y_axis+400,clrRed,clrWhite);
       Create_Button(button_buy_basket_27,"BUY",50 ,15,x_axis+520,y_axis+416,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_27,"SELL",50 ,15,x_axis+580 ,y_axis+416,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_27,"CLOSE",50 ,15,x_axis+640 ,y_axis+416,clrRed,clrWhite);
        Create_Button(button_buy_basket_28,"BUY",50 ,15,x_axis+520,y_axis+432,clrRoyalBlue,clrWhite);           
       Create_Button(button_sell_basket_28,"SELL",50 ,15,x_axis+580 ,y_axis+432,clrGoldenrod,clrWhite);
       Create_Button(button_close_basket_28,"CLOSE",50 ,15,x_axis+640 ,y_axis+432,clrRed,clrWhite);  
        }
  }
  
//+------------------------------------------------------------------+

void SetText(string name,string text,int x,int y,color colour,int fontsize=12)
  {
   if(ObjectCreate(0,name,OBJ_LABEL,0,0,0))
     {
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
     }
   ObjectSetString(0,name,OBJPROP_TEXT,text);
  }
//+------------------------------------------------------------------+

void SetObjText(string name,string CharToStr,int x,int y,color colour,int fontsize=12)
  {
   if(ObjectCreate(0,name,OBJ_LABEL,0,0,0))
     {
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
      ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
      ObjectSetInteger(0,name,OBJPROP_BACK,false);
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
     }
  ObjectSetString(0,name,OBJPROP_TEXT,CharToStr);
  ObjectSetString(0,name,OBJPROP_FONT,"Wingdings");
  }  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetPanel(string name,int sub_window,int x,int y,int width,int height,color bg_color,color border_clr,int border_width)
  {
   if(ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
     {
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
      ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSetInteger(0,name,OBJPROP_WIDTH,border_width);
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger(0,name,OBJPROP_BACK,true);
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
     }
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
//+------------------------------------------------------------------+
void Create_Button(string but_name,string label,int xsize,int ysize,int xdist,int ydist,int bcolor,int fcolor)
{
   if(ObjectFind(0,but_name)<0)
   {
      if(!ObjectCreate(0,but_name,OBJ_BUTTON,0,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",GetLastError());
         return;
        }
      ObjectSetString(0,but_name,OBJPROP_TEXT,label);
      ObjectSetInteger(0,but_name,OBJPROP_XSIZE,xsize);
      ObjectSetInteger(0,but_name,OBJPROP_YSIZE,ysize);
      ObjectSetInteger(0,but_name,OBJPROP_CORNER,CORNER_LEFT_UPPER);     
      ObjectSetInteger(0,but_name,OBJPROP_XDISTANCE,xdist);      
      ObjectSetInteger(0,but_name,OBJPROP_YDISTANCE,ydist);         
      ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bcolor);
      ObjectSetInteger(0,but_name,OBJPROP_COLOR,fcolor);
      ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,9);
      ObjectSetInteger(0,but_name,OBJPROP_HIDDEN,true);
      //ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,ChartGetInteger(0,CHART_COLOR_FOREGROUND));
      ObjectSetInteger(0,but_name,OBJPROP_BORDER_TYPE,BORDER_RAISED);
      
      ChartRedraw();      
   }

}
void OnChartEvent(const int id,  const long &lparam, const double &dparam,  const string &sparam)
  {
   if(id==CHARTEVENT_OBJECT_CLICK)
  ticket = OrderTicket();
  
      {
      if(sparam==button_close_basket_All)
        {
               ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Closing...");               
               close_basket(Magic_Number);
               ObjectSetInteger(0,button_close_basket_All,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_All);        
        }
//-----------------------------------------------------------------------------------------------------------------     
     if(sparam==button_buy_basket_1)
        {
               ObjectSetString(0,button_buy_basket_1,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[0],OP_BUY,lot,MarketInfo(TradePair[0],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_1,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_1,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_1);        
        }
     if(sparam==button_sell_basket_1)
        {
               ObjectSetString(0,button_sell_basket_1,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[0],OP_SELL,lot,MarketInfo(TradePair[0],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_1,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_1,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_1);         
        }
     if(sparam==button_close_basket_1)
        {
               ObjectSetString(0,button_close_basket_1,OBJPROP_TEXT,"Closing...");               
               closeOpenOrders(TradePair[0], OP_SELL);
               closeOpenOrders(TradePair[0], OP_BUY);
               ObjectSetInteger(0,button_close_basket_1,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_1,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_1);         
        }
         
//----------------------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_2)
        {
               ObjectSetString(0,button_buy_basket_2,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[1],OP_BUY,lot,MarketInfo(TradePair[1],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_2,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_2,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_2);         
        }
     if(sparam==button_sell_basket_2)
        {
               ObjectSetString(0,button_sell_basket_2,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[1],OP_SELL,lot,MarketInfo(TradePair[1],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_2,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_2,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_2);         
        }
    if(sparam==button_close_basket_2)
        {
               ObjectSetString(0,button_close_basket_2,OBJPROP_TEXT,"Closing...");               
               closeOpenOrders(TradePair[1], OP_SELL);
               closeOpenOrders(TradePair[1], OP_BUY);
               ObjectSetInteger(0,button_close_basket_2,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_2,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_2);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_3)
        {
               ObjectSetString(0,button_buy_basket_3,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[2],OP_BUY,lot,MarketInfo(TradePair[2],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_3,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_3,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_3);        
        }
     if(sparam==button_sell_basket_3)
        {
               ObjectSetString(0,button_sell_basket_3,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[2],OP_SELL,lot,MarketInfo(TradePair[2],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_3,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_3,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_3);          
        }
    if(sparam==button_close_basket_3)
        {
               ObjectSetString(0,button_close_basket_3,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[2], OP_SELL);
               closeOpenOrders(TradePair[2], OP_BUY);
               ObjectSetInteger(0,button_close_basket_3,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_3,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_3);       
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_4)
        {
               ObjectSetString(0,button_buy_basket_4,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[3],OP_BUY,lot,MarketInfo(TradePair[3],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_4,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_4,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_4);         
        }
     if(sparam==button_sell_basket_4)
        {
               ObjectSetString(0,button_sell_basket_4,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[3],OP_SELL,lot,MarketInfo(TradePair[3],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_4,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_4,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_4);        
        }
    if(sparam==button_close_basket_4)
        {
               ObjectSetString(0,button_close_basket_4,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[3], OP_SELL);
               closeOpenOrders(TradePair[3], OP_BUY);
               ObjectSetInteger(0,button_close_basket_4,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_4,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_4);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_5)
        {
               ObjectSetString(0,button_buy_basket_5,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[4],OP_BUY,lot,MarketInfo(TradePair[4],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_5,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_5,OBJPROP_TEXT,"Buy Basket"); 
                ObjectDelete(button_buy_basket_5);       
        }
     if(sparam==button_sell_basket_5)
        {
               ObjectSetString(0,button_sell_basket_5,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[4],OP_SELL,lot,MarketInfo(TradePair[4],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_5,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_5,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_5);         
        }
    if(sparam==button_close_basket_5)
        {
               ObjectSetString(0,button_close_basket_5,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[4], OP_SELL);
               closeOpenOrders(TradePair[4], OP_BUY);
               ObjectSetInteger(0,button_close_basket_5,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_5,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_5);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_6)
        {
               ObjectSetString(0,button_buy_basket_6,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[5],OP_BUY,lot,MarketInfo(TradePair[5],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_6,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_6,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_6);         
        }
     if(sparam==button_sell_basket_6)
        {
               ObjectSetString(0,button_sell_basket_6,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[5],OP_SELL,lot,MarketInfo(TradePair[5],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_6,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_6,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_6);       
        }
    if(sparam==button_close_basket_6)
        {
               ObjectSetString(0,button_close_basket_6,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[5], OP_SELL);
               closeOpenOrders(TradePair[5], OP_BUY);
               ObjectSetInteger(0,button_close_basket_6,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_6,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_6);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_7)
        {
               ObjectSetString(0,button_buy_basket_7,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[6],OP_BUY,lot,MarketInfo(TradePair[6],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_7,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_7,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_7);        
        }
     if(sparam==button_sell_basket_7)
        {
               ObjectSetString(0,button_sell_basket_7,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[6],OP_SELL,lot,MarketInfo(TradePair[6],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_7,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_7,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_7);      
        }
    if(sparam==button_close_basket_7)
        {
               ObjectSetString(0,button_close_basket_7,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[6], OP_SELL);
               closeOpenOrders(TradePair[6], OP_BUY);
               ObjectSetInteger(0,button_close_basket_7,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_7,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_7);           
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_8)
        {
               ObjectSetString(0,button_buy_basket_8,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[7],OP_BUY,lot,MarketInfo(TradePair[7],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_8,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_8,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_8);        
        }
     if(sparam==button_sell_basket_8)
        {
               ObjectSetString(0,button_sell_basket_8,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[7],OP_SELL,lot,MarketInfo(TradePair[7],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_8,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_8,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_8);         
        }
    if(sparam==button_close_basket_8)
        {
               ObjectSetString(0,button_close_basket_8,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[7], OP_SELL);
               closeOpenOrders(TradePair[7], OP_BUY);
               ObjectSetInteger(0,button_close_basket_8,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_8,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_8);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_9)
        {
               ObjectSetString(0,button_buy_basket_9,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[8],OP_BUY,lot,MarketInfo(TradePair[8],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_9,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_9,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_9);      
        }
     if(sparam==button_sell_basket_9)
        {
               ObjectSetString(0,button_sell_basket_9,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[8],OP_SELL,lot,MarketInfo(TradePair[8],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_9,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_9,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_9);        
        }
    if(sparam==button_close_basket_9)
        {
               ObjectSetString(0,button_close_basket_9,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[8], OP_SELL);
               closeOpenOrders(TradePair[8], OP_BUY);
               ObjectSetInteger(0,button_close_basket_9,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_9,OBJPROP_TEXT,"Close Basket");  
               ObjectDelete(button_close_basket_9);        
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_10)
        {
               ObjectSetString(0,button_buy_basket_10,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[9],OP_BUY,lot,MarketInfo(TradePair[9],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_10,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_10,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_10);         
        }
     if(sparam==button_sell_basket_10)
        {
               ObjectSetString(0,button_sell_basket_10,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[9],OP_SELL,lot,MarketInfo(TradePair[9],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_10,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_10,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_10);         
        }
    if(sparam==button_close_basket_10)
        {
               ObjectSetString(0,button_close_basket_10,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[9], OP_SELL);
               closeOpenOrders(TradePair[9], OP_BUY);
               ObjectSetInteger(0,button_close_basket_10,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_10,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_10);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_11)
        {
               ObjectSetString(0,button_buy_basket_11,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[10],OP_BUY,lot,MarketInfo(TradePair[10],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_11,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_11,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_11);        
        }
     if(sparam==button_sell_basket_11)
        {
               ObjectSetString(0,button_sell_basket_11,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[10],OP_SELL,lot,MarketInfo(TradePair[10],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_11,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_11,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_11);        
        }
    if(sparam==button_close_basket_11)
        {
               ObjectSetString(0,button_close_basket_11,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[10], OP_SELL);
               closeOpenOrders(TradePair[10], OP_BUY);
               ObjectSetInteger(0,button_close_basket_11,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_11,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_11);          
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_12)
        {
               ObjectSetString(0,button_buy_basket_12,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[11],OP_BUY,lot,MarketInfo(TradePair[11],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_12,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_12,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_12);        
        }
     if(sparam==button_sell_basket_12)
        {
               ObjectSetString(0,button_sell_basket_12,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[11],OP_SELL,lot,MarketInfo(TradePair[11],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_12,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_12,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_12);          
        }
    if(sparam==button_close_basket_12)
        {
               ObjectSetString(0,button_close_basket_12,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[11], OP_SELL);
               closeOpenOrders(TradePair[11], OP_BUY);
               ObjectSetInteger(0,button_close_basket_12,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_12,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_12);        
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_13)
        {
               ObjectSetString(0,button_buy_basket_13,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[12],OP_BUY,lot,MarketInfo(TradePair[12],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_13,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_13,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_13);         
        }
     if(sparam==button_sell_basket_13)
        {
               ObjectSetString(0,button_sell_basket_13,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[12],OP_SELL,lot,MarketInfo(TradePair[12],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_13,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_13,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_13);         
        }
    if(sparam==button_close_basket_13)
        {
               ObjectSetString(0,button_close_basket_13,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[12], OP_SELL);
               closeOpenOrders(TradePair[12], OP_BUY);
               ObjectSetInteger(0,button_close_basket_13,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_13,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_13);        
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_14)
        {
               ObjectSetString(0,button_buy_basket_14,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[13],OP_BUY,lot,MarketInfo(TradePair[13],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_14,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_14,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_14);       
        }
     if(sparam==button_sell_basket_14)
        {
               ObjectSetString(0,button_sell_basket_14,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[13],OP_SELL,lot,MarketInfo(TradePair[13],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_14,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_14,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_14);        
        }
    if(sparam==button_close_basket_14)
        {
               ObjectSetString(0,button_close_basket_14,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[13], OP_SELL);
               closeOpenOrders(TradePair[13], OP_BUY);
               ObjectSetInteger(0,button_close_basket_14,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_14,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_14);          
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_15)
        {
               ObjectSetString(0,button_buy_basket_15,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[14],OP_BUY,lot,MarketInfo(TradePair[14],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_15,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_15,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_15);        
        }
     if(sparam==button_sell_basket_15)
        {
               ObjectSetString(0,button_sell_basket_15,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[14],OP_SELL,lot,MarketInfo(TradePair[14],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_15,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_15,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_15);        
        }
    if(sparam==button_close_basket_15)
        {
               ObjectSetString(0,button_close_basket_15,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[14], OP_SELL);
               closeOpenOrders(TradePair[14], OP_BUY);
               ObjectSetInteger(0,button_close_basket_15,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_15,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_15);          
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_16)
        {
               ObjectSetString(0,button_buy_basket_16,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[15],OP_BUY,lot,MarketInfo(TradePair[15],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_16,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_16,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_16);        
        }
     if(sparam==button_sell_basket_16)
        {
               ObjectSetString(0,button_sell_basket_16,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[15],OP_SELL,lot,MarketInfo(TradePair[15],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_16,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_16,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_16);          
        }
    if(sparam==button_close_basket_16)
        {
               ObjectSetString(0,button_close_basket_16,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[15], OP_SELL);
               closeOpenOrders(TradePair[15], OP_BUY);
               ObjectSetInteger(0,button_close_basket_16,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_16,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_16);       
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_17)
        {
               ObjectSetString(0,button_buy_basket_17,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[16],OP_BUY,lot,MarketInfo(TradePair[16],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_17,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_17,OBJPROP_TEXT,"Buy Basket");
                ObjectDelete(button_buy_basket_17);         
        }
     if(sparam==button_sell_basket_17)
        {
               ObjectSetString(0,button_sell_basket_17,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[16],OP_SELL,lot,MarketInfo(TradePair[16],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_17,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_17,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_17);      
        }
    if(sparam==button_close_basket_17)
        {
               ObjectSetString(0,button_close_basket_17,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[16], OP_SELL);
               closeOpenOrders(TradePair[16], OP_BUY);
               ObjectSetInteger(0,button_close_basket_17,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_17,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_17);           
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_18)
        {
               ObjectSetString(0,button_buy_basket_18,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[17],OP_BUY,lot,MarketInfo(TradePair[17],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_18,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_18,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_18);        
        }
     if(sparam==button_sell_basket_18)
        {
               ObjectSetString(0,button_sell_basket_18,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[17],OP_SELL,lot,MarketInfo(TradePair[17],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_18,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_18,OBJPROP_TEXT,"Sell Basket"); 
                ObjectDelete(button_sell_basket_18);        
        }
    if(sparam==button_close_basket_18)
        {
               ObjectSetString(0,button_close_basket_18,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[17], OP_SELL);
               closeOpenOrders(TradePair[17], OP_BUY);
               ObjectSetInteger(0,button_close_basket_18,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_18,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_18);         
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_19)
        {
               ObjectSetString(0,button_buy_basket_19,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[18],OP_BUY,lot,MarketInfo(TradePair[18],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_19,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_19,OBJPROP_TEXT,"Buy Basket");  
               ObjectDelete(button_buy_basket_19);      
        }
     if(sparam==button_sell_basket_19)
        {
               ObjectSetString(0,button_sell_basket_19,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[18],OP_SELL,lot,MarketInfo(TradePair[18],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_19,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_19,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_19);         
        }
    if(sparam==button_close_basket_19)
        {
               ObjectSetString(0,button_close_basket_19,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[18], OP_SELL);
               closeOpenOrders(TradePair[18], OP_BUY);
               ObjectSetInteger(0,button_close_basket_19,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_19,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_19);       
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_20)
        {
               ObjectSetString(0,button_buy_basket_20,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[19],OP_BUY,lot,MarketInfo(TradePair[19],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_20,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_20,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_20);          
        }
     if(sparam==button_sell_basket_20)
        {
               ObjectSetString(0,button_sell_basket_20,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[19],OP_SELL,lot,MarketInfo(TradePair[19],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_20,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_20,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_20);        
        }
    if(sparam==button_close_basket_20)
        {
               ObjectSetString(0,button_close_basket_20,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[19], OP_SELL);
               closeOpenOrders(TradePair[19], OP_BUY);
               ObjectSetInteger(0,button_close_basket_20,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_20,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_20);         
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_21)
        {
               ObjectSetString(0,button_buy_basket_21,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[20],OP_BUY,lot,MarketInfo(TradePair[20],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_21,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_21,OBJPROP_TEXT,"Buy Basket");
                ObjectDelete(button_buy_basket_21);        
        }
     if(sparam==button_sell_basket_21)
        {
               ObjectSetString(0,button_sell_basket_21,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[20],OP_SELL,lot,MarketInfo(TradePair[20],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_21,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_21,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_21);          
        }
    if(sparam==button_close_basket_21)
        {
               ObjectSetString(0,button_close_basket_21,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[20], OP_SELL);
               closeOpenOrders(TradePair[20], OP_BUY);
               ObjectSetInteger(0,button_close_basket_21,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_21,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_21);        
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_22)
        {
               ObjectSetString(0,button_buy_basket_22,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[21],OP_BUY,lot,MarketInfo(TradePair[21],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_22,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_22,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_22);          
        }
     if(sparam==button_sell_basket_22)
        {
               ObjectSetString(0,button_sell_basket_22,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[21],OP_SELL,lot,MarketInfo(TradePair[21],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_22,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_22,OBJPROP_TEXT,"Sell Basket");  
               ObjectDelete(button_sell_basket_22);      
        }
    if(sparam==button_close_basket_22)
        {
               ObjectSetString(0,button_close_basket_22,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[21], OP_SELL);
               closeOpenOrders(TradePair[21], OP_BUY);
               ObjectSetInteger(0,button_close_basket_22,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_22,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_22);        
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_23)
        {
               ObjectSetString(0,button_buy_basket_23,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[22],OP_BUY,lot,MarketInfo(TradePair[22],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_23,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_23,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_23);       
        }
     if(sparam==button_sell_basket_23)
        {
               ObjectSetString(0,button_sell_basket_23,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[22],OP_SELL,lot,MarketInfo(TradePair[22],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_23,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_23,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_23);      
        }
    if(sparam==button_close_basket_23)
        {
               ObjectSetString(0,button_close_basket_23,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[22], OP_SELL);
               closeOpenOrders(TradePair[22], OP_BUY);
               ObjectSetInteger(0,button_close_basket_23,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_23,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_23);
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_24)
        {
               ObjectSetString(0,button_buy_basket_24,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[23],OP_BUY,lot,MarketInfo(TradePair[23],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_24,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_24,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_24);                 
        }
     if(sparam==button_sell_basket_24)
        {
               ObjectSetString(0,button_sell_basket_24,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[23],OP_SELL,lot,MarketInfo(TradePair[23],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_24,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_24,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_24);         
        }
    if(sparam==button_close_basket_24)
        {
               ObjectSetString(0,button_close_basket_24,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[23], OP_SELL);
               closeOpenOrders(TradePair[23], OP_BUY);
               ObjectSetInteger(0,button_close_basket_24,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_24,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_24);        
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_25)
        {
               ObjectSetString(0,button_buy_basket_25,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[24],OP_BUY,lot,MarketInfo(TradePair[24],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_25,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_25,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_25);        
        }
     if(sparam==button_sell_basket_25)
        {
               ObjectSetString(0,button_sell_basket_25,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[24],OP_SELL,lot,MarketInfo(TradePair[24],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_25,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_25,OBJPROP_TEXT,"Sell Basket"); 
               ObjectDelete(button_sell_basket_25);      
        }
    if(sparam==button_close_basket_25)
        {
               ObjectSetString(0,button_close_basket_25,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[24], OP_SELL);
               closeOpenOrders(TradePair[24], OP_BUY);
               ObjectSetInteger(0,button_close_basket_25,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_25,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_25);
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_26)
        {
               ObjectSetString(0,button_buy_basket_26,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[25],OP_BUY,lot,MarketInfo(TradePair[25],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_26,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_26,OBJPROP_TEXT,"Buy Basket"); 
               ObjectDelete(button_buy_basket_26);                 
        }
     if(sparam==button_sell_basket_26)
        {
               ObjectSetString(0,button_sell_basket_26,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[25],OP_SELL,lot,MarketInfo(TradePair[25],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_26,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_26,OBJPROP_TEXT,"Sell Basket");
                ObjectDelete(button_sell_basket_26);         
        }
    if(sparam==button_close_basket_26)
        {
               ObjectSetString(0,button_close_basket_26,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[25], OP_SELL);
               closeOpenOrders(TradePair[25], OP_BUY);
               ObjectSetInteger(0,button_close_basket_26,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_26,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_26);          
        }
//--------------------------------------------------------------------------------------------------------
    if(sparam==button_buy_basket_27)
        {
               ObjectSetString(0,button_buy_basket_27,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[26],OP_BUY,lot,MarketInfo(TradePair[26],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_27,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_27,OBJPROP_TEXT,"Buy Basket");
                ObjectDelete(button_buy_basket_27);
         }       
     if(sparam==button_sell_basket_27)
        {
               ObjectSetString(0,button_sell_basket_27,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[26],OP_SELL,lot,MarketInfo(TradePair[26],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_27,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_27,OBJPROP_TEXT,"Sell Basket");
               ObjectDelete(button_sell_basket_27);         
        }
    if(sparam==button_close_basket_27)
        {
               ObjectSetString(0,button_close_basket_27,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[26], OP_SELL);
               closeOpenOrders(TradePair[26], OP_BUY);
               ObjectSetInteger(0,button_close_basket_27,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_27,OBJPROP_TEXT,"Close Basket");
               ObjectDelete(button_close_basket_27);         
        }
//--------------------------------------------------------------------------------------------------------
     if(sparam==button_buy_basket_28)
        {
               ObjectSetString(0,button_buy_basket_28,OBJPROP_TEXT,"Buying...");
               ticket=OrderSend(TradePair[27],OP_BUY,lot,MarketInfo(TradePair[27],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               ObjectSetInteger(0,button_buy_basket_28,OBJPROP_STATE,0);
               ObjectSetString(0,button_buy_basket_28,OBJPROP_TEXT,"Buy Basket");
               ObjectDelete(button_buy_basket_27);         
        }
     if(sparam==button_sell_basket_28)
        {
               ObjectSetString(0,button_sell_basket_28,OBJPROP_TEXT,"Selling...");
               ticket=OrderSend(TradePair[27],OP_SELL,lot,MarketInfo(TradePair[27],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               ObjectSetInteger(0,button_sell_basket_28,OBJPROP_STATE,0);
               ObjectSetString(0,button_sell_basket_28,OBJPROP_TEXT,"Sell Basket"); 
                ObjectDelete(button_sell_basket_27);         
        }
    if(sparam==button_close_basket_28)
        {
               ObjectSetString(0,button_close_basket_28,OBJPROP_TEXT,"Closing...");               
                closeOpenOrders(TradePair[27], OP_SELL);
               closeOpenOrders(TradePair[27], OP_BUY);
               ObjectSetInteger(0,button_close_basket_28,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_28,OBJPROP_TEXT,"Close Basket"); 
               ObjectDelete(button_close_basket_27);        
        }
//--------------------------------------------------------------------------------------------------------
        
     }
    //--- re-draw property values
   ChartRedraw(); 
     }
//+------------------------------------------------------------------+
//| closeOpenOrders                                                  |
//+------------------------------------------------------------------+
void closeOpenOrders(string currency,int orderType )
{
   
   double close;
   orders = OrdersTotal();
   for(int i=0;i<orders;i++) {
      if(OrderSelect(i, SELECT_BY_POS)==true) {
         if(OrderType() == orderType && OrderSymbol() == currency && orderType == OP_SELL && OrderMagicNumber()==Magic_Number) {
            double ask = MarketInfo(currency,MODE_ASK);
           close= OrderClose(OrderTicket(),OrderLots(),ask,3,Red);
         }
         if(OrderType() == orderType && OrderSymbol() == currency && orderType == OP_BUY && OrderMagicNumber()==Magic_Number) {
            double bid = MarketInfo(currency,MODE_BID);
           close= OrderClose(OrderTicket(),OrderLots(),bid,3,Green);
         }
      }
   }
}
void close_basket(int magic_number)
{ 
  
if (OrdersTotal()==0) return;
for (int i=OrdersTotal()-1; i>=0; i--)
      {//pozicio kivalasztasa
       if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true)//ha kivalasztas ok
            {
            //Print ("order ticket: ", OrderTicket(), "order magic: ", OrderMagicNumber());
            if (OrderType()==0 && OrderMagicNumber()==Magic_Number)
               {//ha long
               ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 3,Red);
               if (ticket==-1) Print ("Error: ",  GetLastError());
               
               }
            if (OrderType()==1 && OrderMagicNumber()==Magic_Number)
               {//ha short
               ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 3,Red);
               if (ticket==-1) Print ("Error: ",  GetLastError());
               
               }  
            }
      }
  
//----
   return;
    
}
//+------------------------------------------------------------------+
void Trades ()
{
   int i, j;
   double totallots=0;
   for(i=0;i<ArraySize(TradePair);i++)
   {
      
      bpos[i]=0;
      spos[i]=0;       
      blots[i]=0;
      slots[i]=0;     
      bprofit[i]=0;
      sprofit[i]=0;
      tprofit[i]=0;
   }
	for(i=0;i<OrdersTotal();i++)
	{
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
         continue;
         
      for(j=0;j<ArraySize(TradePair);j++)
      {	  
         if((TradePair[j]==OrderSymbol() || TradePair[j]=="") && OrderMagicNumber() == Magic_Number)
         {
            TradePair[j]=OrderSymbol();                       
            tprofit[j]=tprofit[j]+OrderProfit()+OrderSwap()+OrderCommission();
           if(OrderType()==0){ bprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission(); } 
           if(OrderType()==1){ sprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission(); } 
           if(OrderType()==0){ blots[j]+=OrderLots(); } 
           if(OrderType()==1){ slots[j]+=OrderLots(); }
           if(OrderType()==0){ bpos[j]+=+1; } 
           if(OrderType()==1){ spos[j]+=+1; } 
                                
            totallots=totallots+OrderLots();
            break;
	     }
	  }
   }
   }
//+------------------------------------------------------------------+
double TotalProfit ()
{
   double totalprofit=0;
   for(int i=0;i<OrdersTotal();i++) 
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
         continue;
      if((OrderType()==OP_BUY || OrderType()==OP_SELL) && OrderMagicNumber() == Magic_Number)
          totalprofit=totalprofit+OrderProfit()+OrderCommission()+OrderSwap();
   }
   return (totalprofit);
}
//+------------------------------------------------------------------+
void getCCFPSignals(int i) {

   int forthis;
   int direction = 0;
   string text = "";

   Signalm1[i] = 0;
   
   for (int y = ObjectsTotal();y >= 0; y--) {
      if (StringFind(ObjectName(y),"suggest") >= 0 && StringFind(ObjectName(y),Defaultpairs[i]) >=0) {
         forthis = StringToInteger(ObjectName(y));         
         text = ObjectGetString(ChartID(),ObjectName(y),OBJPROP_TEXT);
         if (StringFind(text,"Sell") >= 0) {
            direction = -1;
         }
         if (StringFind(text,"Buy") >= 0) {
            direction = 1;
         }
         if (forthis == 1)
            Signalm1[i] = direction;
         if (forthis == 2)
            Signalm5[i] = direction;
         if (forthis == 3)
            Signalm15[i] = direction;
         if (forthis == 4)
            Signalm30[i] = direction;
      }
   }
}  