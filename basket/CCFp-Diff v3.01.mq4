
extern string Label0 = "=== Multi Display on chart ===";
extern int Indicator_ID_Number = 1;
extern int X_offset_comments = 0;
extern int Y_offset_comments = 0;
extern int X_offset_histo = 0;
extern int Y_offset_histo = 0;
extern string Label1 = "=== CCFp settings ===";
extern int Timeframe = 240;
extern bool Use_Current = FALSE;
extern bool Use_Bar_instead_of_MA = FALSE;
extern int MA_Method = 3;
extern int Price = 6;
extern int Fast = 3;
extern int Slow = 5;
extern string Label2 = "=== Suggestions settings ===";
extern bool Display_suggestions = TRUE;
extern int Trade_Level = 2;
extern bool Use_Reverse_Suggestions = FALSE;
extern bool SignalAlert = FALSE;
extern bool SendAlertEmail = FALSE;
extern string Label3 = "=== Trade settings ===";
extern bool Trade_EURUSD = TRUE;
extern bool Trade_GBPUSD = TRUE;
extern bool Trade_USDCHF = TRUE;
extern bool Trade_USDJPY = TRUE;
extern bool Trade_AUDUSD = TRUE;
extern bool Trade_USDCAD = TRUE;
extern bool Trade_EURAUD = TRUE;
extern bool Trade_EURCHF = TRUE;
extern bool Trade_EURGBP = TRUE;
extern bool Trade_EURJPY = TRUE;
extern bool Trade_GBPCHF = TRUE;
extern bool Trade_GBPJPY = TRUE;
extern bool Trade_AUDCAD = TRUE;
extern bool Trade_AUDCHF = TRUE;
extern bool Trade_AUDJPY = TRUE;
extern bool Trade_AUDNZD = TRUE;
extern bool Trade_CADCHF = TRUE;
extern bool Trade_CADJPY = TRUE;
extern bool Trade_CHFJPY = TRUE;
extern bool Trade_EURCAD = TRUE;
extern bool Trade_EURNZD = TRUE;
extern bool Trade_NZDCAD = TRUE;
extern bool Trade_NZDCHF = TRUE;
extern bool Trade_NZDJPY = TRUE;
extern bool Trade_NZDUSD = TRUE;
extern bool Trade_GBPAUD = TRUE;
extern bool Trade_GBPCAD = TRUE;
extern bool Trade_GBPNZD = TRUE;
extern string Label4 = "=== Squares Colors settings ===";
extern bool Display_histogram = TRUE;
extern color Currency_color = Silver;
extern color Values_color = Gray;
extern color Buy_color1 = DarkGreen;
extern color Buy_color2 = C'0x00,0x73,0x00';
extern color Buy_color3 = C'0x00,0x82,0x00';
extern color Buy_color4 = C'0x00,0x91,0x00';
extern color Buy_color5 = C'0x00,0xA0,0x00';
extern color Buy_color6 = C'0x00,0xAF,0x00';
extern color Buy_color7 = C'0x00,0xBE,0x00';
extern color Buy_color8 = C'0x00,0xCD,0x00';
extern color Buy_color9 = C'0x00,0xDC,0x00';
extern color Buy_color10 = C'0x00,0xEB,0x00';
extern color Sell_color1 = C'0x82,0x00,0x00';
extern color Sell_color2 = C'0x91,0x00,0x00';
extern color Sell_color3 = C'0xA0,0x00,0x00';
extern color Sell_color4 = C'0xAF,0x00,0x00';
extern color Sell_color5 = C'0xBE,0x00,0x00';
extern color Sell_color6 = C'0xCD,0x00,0x00';
extern color Sell_color7 = C'0xDC,0x00,0x00';
extern color Sell_color8 = C'0xEB,0x00,0x00';
extern color Sell_color9 = C'0xFA,0x00,0x00';
extern color Sell_color10 = C'0xFA,0x00,0x00';
extern string Label5 = "=== Comments Colors settings ===";
extern color Pair_color = Gainsboro;
extern color BUY_color = Lime;
extern color SELL_color = Red;
extern color Timer_color = LightSalmon;
extern color Reverse_color = Gold;
int colorOfSymbol;
int g_datetime_420 = 0;
bool gi_424 = TRUE;
string objName;
string TFasTxt;
string gs_452;
int incYofText;
int noOfBars4Calc;
int countPairs;
bool IsRefreshingReady;
double histoValueUSD;
double histoValueEUR;
double histoValueGBP;
double histoValueAUD;
double histoValueNZD;
double histoValueCAD;
double histoValueCHF;
double histoValueJPY;
int xPosTextUSD;
int yPosTextUSD;
int xPosTextEUR;
int yPosTextEUR;
int xPosTextGBP;
int yPosTextGBP;
int xPosTextAUD;
int yPosTextAUD;
int xPosTextNZD;
int yPosTextNZD;
int xPosTextCAD;
int yPosTextCAD;
int xPosTextCHF;
int yPosTextCHF;
int xPosTextJPY;
int yPosTextJPY;
int startTimeActSymbol = 0;
int startTimeEURUSD = 0;
int startTimeGBPUSD = 0;
int startTimeAUDUSD = 0;
int startTimeNZDUSD = 0;
int startTimeUSDCHF = 0;
int startTimeUSDCAD = 0;
int startTimeUSDJPY = 0;

int init() {
   if (Timeframe == 0) Timeframe = Period();
   if (Timeframe == PERIOD_M1) TFasTxt = "M1";
   if (Timeframe == PERIOD_M5) TFasTxt = "M5";
   if (Timeframe == PERIOD_M15) TFasTxt = "M15";
   if (Timeframe == PERIOD_M30) TFasTxt = "M30";
   if (Timeframe == PERIOD_H1) TFasTxt = "H1";
   if (Timeframe == PERIOD_H4) TFasTxt = "H4";
   if (Timeframe == PERIOD_D1) TFasTxt = "D1";
   if (Timeframe == PERIOD_W1) TFasTxt = "W1";
   if (Timeframe == PERIOD_MN1) TFasTxt = "MN";
   return (0);
}

int deinit() {
   cleanup();
   return (0);
}

int start() {
   int startY;
   int deltaY;
   cleanup();
   // ********************************************************
   // Sum FerroFX init junk
   // ********************************************************
   if (startTimeActSymbol != iTime(Symbol(), Timeframe, 0)) {
      startTimeActSymbol = iTime(Symbol(), Timeframe, 0);
      countPairs = 0;
   }
   if (gi_424) {
      startTimeEURUSD = iTime("EURUSD", Timeframe, 1);
      startTimeGBPUSD = iTime("GBPUSD", Timeframe, 1);
      startTimeAUDUSD = iTime("AUDUSD", Timeframe, 1);
      startTimeNZDUSD = iTime("NZDUSD", Timeframe, 1);
      startTimeUSDCHF = iTime("USDCHF", Timeframe, 1);
      startTimeUSDCAD = iTime("USDCAD", Timeframe, 1);
      startTimeUSDJPY = iTime("USDJPY", Timeframe, 1);
      gi_424 = FALSE;
   }
   if (startTimeEURUSD != iTime("EURUSD", Timeframe, 0)) {
      startTimeEURUSD = iTime("EURUSD", Timeframe, 0);
      countPairs++;
   }
   if (startTimeGBPUSD != iTime("GBPUSD", Timeframe, 0)) {
      startTimeGBPUSD = iTime("GBPUSD", Timeframe, 0);
      countPairs++;
   }
   if (startTimeAUDUSD != iTime("AUDUSD", Timeframe, 0)) {
      startTimeAUDUSD = iTime("AUDUSD", Timeframe, 0);
      countPairs++;
   }
   if (startTimeNZDUSD != iTime("NZDUSD", Timeframe, 0)) {
      startTimeNZDUSD = iTime("NZDUSD", Timeframe, 0);
      countPairs++;
   }
   if (startTimeUSDCHF != iTime("USDCHF", Timeframe, 0)) {
      startTimeUSDCHF = iTime("USDCHF", Timeframe, 0);
      countPairs++;
   }
   if (startTimeUSDCAD != iTime("USDCAD", Timeframe, 0)) {
      startTimeUSDCAD = iTime("USDCAD", Timeframe, 0);
      countPairs++;
   }
   if (startTimeUSDJPY != iTime("USDJPY", Timeframe, 0)) {
      startTimeUSDJPY = iTime("USDJPY", Timeframe, 0);
      countPairs++;
   }
   if (countPairs == 7) IsRefreshingReady = TRUE;
   else IsRefreshingReady = FALSE;
   if (Use_Bar_instead_of_MA) 
      noOfBars4Calc = 1000;
   else 
      noOfBars4Calc = 10000;
      
   // ********************************************************
   // Draws Text and Nums left bottom in histogram
   // ********************************************************
   histoValueUSD = Lookup(NormalizeDouble((usdCalc(1) - usdCalc(2)) * noOfBars4Calc, 0));
   xPosTextUSD = 8;
   yPosTextUSD = 18;
   if (Display_histogram) {
      DrawText("USD", xPosTextUSD + 1);
      DrawNum("USD", histoValueUSD, xPosTextUSD);
   }
   histoValueEUR = Lookup(NormalizeDouble((eurCalc(1) - eurCalc(2)) * noOfBars4Calc, 0));
   xPosTextEUR = 32;
   yPosTextEUR = 18;
   if (Display_histogram) {
      DrawText("EUR", xPosTextEUR + 1);
      DrawNum("EUR", histoValueEUR, xPosTextEUR);
   }
   histoValueGBP = Lookup(NormalizeDouble((gbpCalc(1) - gbpCalc(2)) * noOfBars4Calc, 0));
   xPosTextGBP = 56;
   yPosTextGBP = 18;
   if (Display_histogram) {
      DrawText("GBP", xPosTextGBP + 1);
      DrawNum("GBP", histoValueGBP, xPosTextGBP);
   }
   histoValueAUD = Lookup(NormalizeDouble((audCalc(1) - audCalc(2)) * noOfBars4Calc, 0));
   xPosTextAUD = 80;
   yPosTextAUD = 18;
   if (Display_histogram) {
      DrawText("AUD", xPosTextAUD);
      DrawNum("AUD", histoValueAUD, xPosTextAUD);
   }
   histoValueNZD = Lookup(NormalizeDouble((nzdCalc(1) - nzdCalc(2)) * noOfBars4Calc, 0));
   xPosTextNZD = 104;
   yPosTextNZD = 18;
   if (Display_histogram) {
      DrawText("NZD", xPosTextNZD);
      DrawNum("NZD", histoValueNZD, xPosTextNZD);
   }
   histoValueCAD = Lookup(NormalizeDouble((cadCalc(1) - cadCalc(2)) * noOfBars4Calc, 0));
   xPosTextCAD = 128;
   yPosTextCAD = 18;
   if (Display_histogram) {
      DrawText("CAD", xPosTextCAD);
      DrawNum("CAD", histoValueCAD, xPosTextCAD);
   }
   histoValueCHF = Lookup(NormalizeDouble((chfCalc(1) - chfCalc(2)) * noOfBars4Calc, 0));
   xPosTextCHF = 152;
   yPosTextCHF = 18;
   if (Display_histogram) {
      DrawText("CHF", xPosTextCHF + 1);
      DrawNum("CHF", histoValueCHF, xPosTextCHF);
   }
   histoValueJPY = Lookup(NormalizeDouble((jpyCalc(1) - jpyCalc(2)) * noOfBars4Calc, 0));
   xPosTextJPY = 176;
   yPosTextJPY = 18;
   if (Display_histogram) {
      DrawText("JPY", xPosTextJPY + 1);
      DrawNum("JPY", histoValueJPY, xPosTextJPY);
   }
   
   // ********************************************************
   // Draws Lines left bottom in histogram
   // ********************************************************
   if (Display_histogram) {
      incYofText = 4;
      for (int i = 1; i < 11; i++) {
         if (histoValueUSD < 0) {
            if (histoValueUSD <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueUSD >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("usd" + i, xPosTextUSD, yPosTextUSD, colorOfSymbol);
         yPosTextUSD += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueEUR < 0) {
            if (histoValueEUR <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueEUR >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("eur" + i, xPosTextEUR, yPosTextEUR, colorOfSymbol);
         yPosTextEUR += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueGBP < 0) {
            if (histoValueGBP <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueGBP >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("gbp" + i, xPosTextGBP, yPosTextGBP, colorOfSymbol);
         yPosTextGBP += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueAUD < 0) {
            if (histoValueAUD <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueAUD >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("aud" + i, xPosTextAUD, yPosTextAUD, colorOfSymbol);
         yPosTextAUD += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueNZD < 0) {
            if (histoValueNZD <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueNZD >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("nzd" + i, xPosTextNZD, yPosTextNZD, colorOfSymbol);
         yPosTextNZD += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueCAD < 0) {
            if (histoValueCAD <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueCAD >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("cad" + i, xPosTextCAD, yPosTextCAD, colorOfSymbol);
         yPosTextCAD += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueCHF < 0) {
            if (histoValueCHF <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueCHF >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("chf" + i, xPosTextCHF, yPosTextCHF, colorOfSymbol);
         yPosTextCHF += incYofText;
      }
      for (i = 1; i < 11; i++) {
         if (histoValueJPY < 0) {
            if (histoValueJPY <= -i) colorOfSymbol = colorCalc(-i);
            else colorOfSymbol = colorCalc2(i);
         } else {
            if (histoValueJPY >= i) colorOfSymbol = colorCalc(i);
            else colorOfSymbol = colorCalc2(i);
         }
         DrawObject("jpy" + i, xPosTextJPY, yPosTextJPY, colorOfSymbol);
         yPosTextJPY += incYofText;
      }
   }
   // ********************************************************
   // Display Suggestions top left
   // Good 4 Ferru the hard steal that we haven t 1000 pairs...lololol...:-)
   // ********************************************************
   if (Display_suggestions) {
      startY = 90;
      deltaY = 15;
      if (Use_Reverse_Suggestions) startY += 15;
      if (Trade_EURUSD) {
         if (histoValueEUR >= 0 && histoValueUSD < 0) {
            if (histoValueEUR >= Trade_Level && histoValueUSD <= (-Trade_Level)) {
               DrawSuggest("EURUSD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURUSD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueUSD >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueUSD >= Trade_Level) {
               DrawSuggest("EURUSD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURUSD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_GBPUSD) {
         if (histoValueGBP >= 0 && histoValueUSD < 0) {
            if (histoValueGBP >= Trade_Level && histoValueUSD <= (-Trade_Level)) {
               DrawSuggest("GBPUSD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPUSD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueGBP < 0 && histoValueUSD >= 0) {
            if (histoValueGBP <= (-Trade_Level) && histoValueUSD >= Trade_Level) {
               DrawSuggest("GBPUSD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPUSD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_USDCHF) {
         if (histoValueUSD >= 0 && histoValueCHF < 0) {
            if (histoValueUSD >= Trade_Level && histoValueCHF <= (-Trade_Level)) {
               DrawSuggest("USDCHF", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("USDCHF", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueUSD < 0 && histoValueCHF >= 0) {
            if (histoValueUSD <= (-Trade_Level) && histoValueCHF >= Trade_Level) {
               DrawSuggest("USDCHF", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("USDCHF", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_USDJPY) {
         if (histoValueUSD >= 0 && histoValueJPY < 0) {
            if (histoValueUSD >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("USDJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("USDJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueUSD < 0 && histoValueJPY >= 0) {
            if (histoValueUSD <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("USDJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("USDJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_AUDUSD) {
         if (histoValueAUD >= 0 && histoValueUSD < 0) {
            if (histoValueAUD >= Trade_Level && histoValueUSD <= (-Trade_Level)) {
               DrawSuggest("AUDUSD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDUSD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueAUD < 0 && histoValueUSD >= 0) {
            if (histoValueAUD <= (-Trade_Level) && histoValueUSD >= Trade_Level) {
               DrawSuggest("AUDUSD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDUSD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_USDCAD) {
         if (histoValueUSD >= 0 && histoValueCAD < 0) {
            if (histoValueUSD >= Trade_Level && histoValueCAD <= (-Trade_Level)) {
               DrawSuggest("USDCAD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("USDCAD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueUSD < 0 && histoValueCAD >= 0) {
            if (histoValueUSD <= (-Trade_Level) && histoValueCAD >= Trade_Level) {
               DrawSuggest("USDCAD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("USDCAD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_EURAUD) {
         if (histoValueEUR >= 0 && histoValueAUD < 0) {
            if (histoValueEUR >= Trade_Level && histoValueAUD <= (-Trade_Level)) {
               DrawSuggest("EURAUD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURAUD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueAUD >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueAUD >= Trade_Level) {
               DrawSuggest("EURAUD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURAUD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_EURCHF) {
         if (histoValueEUR >= 0 && histoValueCHF < 0) {
            if (histoValueEUR >= Trade_Level && histoValueCHF <= (-Trade_Level)) {
               DrawSuggest("EURCHF", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURCHF", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueCHF >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueCHF >= Trade_Level) {
               DrawSuggest("EURCHF", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURCHF", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_EURGBP) {
         if (histoValueEUR >= 0 && histoValueGBP < 0) {
            if (histoValueEUR >= Trade_Level && histoValueGBP <= (-Trade_Level)) {
               DrawSuggest("EURGBP", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURGBP", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueGBP >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueGBP >= Trade_Level) {
               DrawSuggest("EURGBP", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURGBP", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_EURJPY) {
         if (histoValueEUR >= 0 && histoValueJPY < 0) {
            if (histoValueEUR >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("EURJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueJPY >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("EURJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_GBPCHF) {
         if (histoValueGBP >= 0 && histoValueCHF < 0) {
            if (histoValueGBP >= Trade_Level && histoValueCHF <= (-Trade_Level)) {
               DrawSuggest("GBPCHF", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPCHF", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueGBP < 0 && histoValueCHF >= 0) {
            if (histoValueGBP <= (-Trade_Level) && histoValueCHF >= Trade_Level) {
               DrawSuggest("GBPCHF", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPCHF", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_GBPJPY) {
         if (histoValueGBP >= 0 && histoValueJPY < 0) {
            if (histoValueGBP >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("GBPJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueGBP < 0 && histoValueJPY >= 0) {
            if (histoValueGBP <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("GBPJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_AUDCAD) {
         if (histoValueAUD >= 0 && histoValueCAD < 0) {
            if (histoValueAUD >= Trade_Level && histoValueCAD <= (-Trade_Level)) {
               DrawSuggest("AUDCAD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDCAD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueAUD < 0 && histoValueCAD >= 0) {
            if (histoValueAUD <= (-Trade_Level) && histoValueCAD >= Trade_Level) {
               DrawSuggest("AUDCAD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDCAD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_AUDCHF) {
         if (histoValueAUD >= 0 && histoValueCHF < 0) {
            if (histoValueAUD >= Trade_Level && histoValueCHF <= (-Trade_Level)) {
               DrawSuggest("AUDCHF", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDCHF", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueAUD < 0 && histoValueCHF >= 0) {
            if (histoValueAUD <= (-Trade_Level) && histoValueCHF >= Trade_Level) {
               DrawSuggest("AUDCHF", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDCHF", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_AUDJPY) {
         if (histoValueAUD >= 0 && histoValueJPY < 0) {
            if (histoValueAUD >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("AUDJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueAUD < 0 && histoValueJPY >= 0) {
            if (histoValueAUD <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("AUDJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_AUDNZD) {
         if (histoValueAUD >= 0 && histoValueNZD < 0) {
            if (histoValueAUD >= Trade_Level && histoValueNZD <= (-Trade_Level)) {
               DrawSuggest("AUDNZD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDNZD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueAUD < 0 && histoValueNZD >= 0) {
            if (histoValueAUD <= (-Trade_Level) && histoValueNZD >= Trade_Level) {
               DrawSuggest("AUDNZD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("AUDNZD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_CADCHF) {
         if (histoValueCAD >= 0 && histoValueCHF < 0) {
            if (histoValueCAD >= Trade_Level && histoValueCHF <= (-Trade_Level)) {
               DrawSuggest("CADCHF", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("CADCHF", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueCAD < 0 && histoValueCHF >= 0) {
            if (histoValueCAD <= (-Trade_Level) && histoValueCHF >= Trade_Level) {
               DrawSuggest("CADCHF", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("CADCHF", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_CADJPY) {
         if (histoValueCAD >= 0 && histoValueJPY < 0) {
            if (histoValueCAD >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("CADJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("CADJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueCAD < 0 && histoValueJPY >= 0) {
            if (histoValueCAD <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("CADJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("CADJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_CHFJPY) {
         if (histoValueCHF >= 0 && histoValueJPY < 0) {
            if (histoValueCHF >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("CHFJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("CHFJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueCHF < 0 && histoValueJPY >= 0) {
            if (histoValueCHF <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("CHFJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("CHFJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_EURCAD) {
         if (histoValueEUR >= 0 && histoValueCAD < 0) {
            if (histoValueEUR >= Trade_Level && histoValueCAD <= (-Trade_Level)) {
               DrawSuggest("EURCAD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURCAD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueCAD >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueCAD >= Trade_Level) {
               DrawSuggest("EURCAD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURCAD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_EURNZD) {
         if (histoValueEUR >= 0 && histoValueNZD < 0) {
            if (histoValueEUR >= Trade_Level && histoValueNZD <= (-Trade_Level)) {
               DrawSuggest("EURNZD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURNZD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueEUR < 0 && histoValueNZD >= 0) {
            if (histoValueEUR <= (-Trade_Level) && histoValueNZD >= Trade_Level) {
               DrawSuggest("EURNZD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("EURNZD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_NZDCAD) {
         if (histoValueNZD >= 0 && histoValueCAD < 0) {
            if (histoValueNZD >= Trade_Level && histoValueCAD <= (-Trade_Level)) {
               DrawSuggest("NZDCAD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDCAD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueNZD < 0 && histoValueCAD >= 0) {
            if (histoValueNZD <= (-Trade_Level) && histoValueCAD >= Trade_Level) {
               DrawSuggest("NZDCAD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDCAD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_NZDCHF) {
         if (histoValueNZD >= 0 && histoValueCHF < 0) {
            if (histoValueNZD >= Trade_Level && histoValueCHF <= (-Trade_Level)) {
               DrawSuggest("NZDCHF", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDCHF", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueNZD < 0 && histoValueCHF >= 0) {
            if (histoValueNZD <= (-Trade_Level) && histoValueCHF >= Trade_Level) {
               DrawSuggest("NZDCHF", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDCHF", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_NZDJPY) {
         if (histoValueNZD >= 0 && histoValueJPY < 0) {
            if (histoValueNZD >= Trade_Level && histoValueJPY <= (-Trade_Level)) {
               DrawSuggest("NZDJPY", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDJPY", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueNZD < 0 && histoValueJPY >= 0) {
            if (histoValueNZD <= (-Trade_Level) && histoValueJPY >= Trade_Level) {
               DrawSuggest("NZDJPY", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDJPY", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_NZDUSD) {
         if (histoValueNZD >= 0 && histoValueUSD < 0) {
            if (histoValueNZD >= Trade_Level && histoValueUSD <= (-Trade_Level)) {
               DrawSuggest("NZDUSD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDUSD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueNZD < 0 && histoValueUSD >= 0) {
            if (histoValueNZD <= (-Trade_Level) && histoValueUSD >= Trade_Level) {
               DrawSuggest("NZDUSD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("NZDUSD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_GBPAUD) {
         if (histoValueGBP >= 0 && histoValueAUD < 0) {
            if (histoValueGBP >= Trade_Level && histoValueAUD <= (-Trade_Level)) {
               DrawSuggest("GBPAUD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPAUD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueGBP < 0 && histoValueAUD >= 0) {
            if (histoValueGBP <= (-Trade_Level) && histoValueAUD >= Trade_Level) {
               DrawSuggest("GBPAUD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPAUD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_GBPCAD) {
         if (histoValueGBP >= 0 && histoValueCAD < 0) {
            if (histoValueGBP >= Trade_Level && histoValueCAD <= (-Trade_Level)) {
               DrawSuggest("GBPCAD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPCAD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueGBP < 0 && histoValueCAD >= 0) {
            if (histoValueGBP <= (-Trade_Level) && histoValueCAD >= Trade_Level) {
               DrawSuggest("GBPCAD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPCAD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (Trade_GBPNZD) {
         if (histoValueGBP >= 0 && histoValueNZD < 0) {
            if (histoValueGBP >= Trade_Level && histoValueNZD <= (-Trade_Level)) {
               DrawSuggest("GBPNZD", "Buy", startY, BUY_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPNZD", "Buy", startY, BUY_color, -1);
                  startY += deltaY;
               }
            }
         }
         if (histoValueGBP < 0 && histoValueNZD >= 0) {
            if (histoValueGBP <= (-Trade_Level) && histoValueNZD >= Trade_Level) {
               DrawSuggest("GBPNZD", "Sell", startY, SELL_color, 1);
               startY += deltaY;
            } else {
               if (Use_Reverse_Suggestions) {
                  DrawSuggest("GBPNZD", "Sell", startY, SELL_color, -1);
                  startY += deltaY;
               }
            }
         }
      }
      if (startY == 90) {
         DrawSuggest("NO", "No Pair To trade", startY, Pair_color, 0);
         startY += deltaY;
      }
      DrawLast(startY);
      DrawTimer();
   }
   return (0);
}

double usdCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("EURUSD", Slow, MA_Method, Price, shift) / ma("EURUSD", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("GBPUSD", Slow, MA_Method, Price, shift) / ma("GBPUSD", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("AUDUSD", Slow, MA_Method, Price, shift) / ma("AUDUSD", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("NZDUSD", Slow, MA_Method, Price, shift) / ma("NZDUSD", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("USDCHF", Fast, MA_Method, Price, shift) / ma("USDCHF", Slow, MA_Method, Price, shift) - 1;
   tmpResult += ma("USDCAD", Fast, MA_Method, Price, shift) / ma("USDCAD", Slow, MA_Method, Price, shift) - 1;
   tmpResult += ma("USDJPY", Fast, MA_Method, Price, shift) / ma("USDJPY", Slow, MA_Method, Price, shift) - 1;
   return (tmpResult);
}

double eurCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("EURUSD", Fast, MA_Method, Price, shift) / ma("EURUSD", Slow, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Fast, MA_Method, Price, shift) / ma("GBPUSD", Fast, MA_Method, Price, shift) / (ma("EURUSD", Slow, MA_Method, Price,
      shift) / ma("GBPUSD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("EURUSD", Fast, MA_Method, Price, shift) / ma("AUDUSD", Fast, MA_Method, Price, shift) / (ma("EURUSD", Slow, MA_Method, Price,
      shift) / ma("AUDUSD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("EURUSD", Fast, MA_Method, Price, shift) / ma("NZDUSD", Fast, MA_Method, Price, shift) / (ma("EURUSD", Slow, MA_Method, Price,
      shift) / ma("NZDUSD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("EURUSD", Fast, MA_Method, Price, shift) * ma("USDCHF", Fast, MA_Method, Price, shift) / (ma("EURUSD", Slow, MA_Method, Price,
      shift) * ma("USDCHF", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("EURUSD", Fast, MA_Method, Price, shift) * ma("USDCAD", Fast, MA_Method, Price, shift) / (ma("EURUSD", Slow, MA_Method, Price,
      shift) * ma("USDCAD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("EURUSD", Fast, MA_Method, Price, shift) * ma("USDJPY", Fast, MA_Method, Price, shift) / (ma("EURUSD", Slow, MA_Method, Price,
      shift) * ma("USDJPY", Slow, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double gbpCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("GBPUSD", Fast, MA_Method, Price, shift) / ma("GBPUSD", Slow, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Slow, MA_Method, Price, shift) / ma("GBPUSD", Slow, MA_Method, Price, shift) / (ma("EURUSD", Fast, MA_Method, Price,
      shift) / ma("GBPUSD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Fast, MA_Method, Price, shift) / ma("AUDUSD", Fast, MA_Method, Price, shift) / (ma("GBPUSD", Slow, MA_Method, Price,
      shift) / ma("AUDUSD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Fast, MA_Method, Price, shift) / ma("NZDUSD", Fast, MA_Method, Price, shift) / (ma("GBPUSD", Slow, MA_Method, Price,
      shift) / ma("NZDUSD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Fast, MA_Method, Price, shift) * ma("USDCHF", Fast, MA_Method, Price, shift) / (ma("GBPUSD", Slow, MA_Method, Price,
      shift) * ma("USDCHF", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Fast, MA_Method, Price, shift) * ma("USDCAD", Fast, MA_Method, Price, shift) / (ma("GBPUSD", Slow, MA_Method, Price,
      shift) * ma("USDCAD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Fast, MA_Method, Price, shift) * ma("USDJPY", Fast, MA_Method, Price, shift) / (ma("GBPUSD", Slow, MA_Method, Price,
      shift) * ma("USDJPY", Slow, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double audCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("AUDUSD", Fast, MA_Method, Price, shift) / ma("AUDUSD", Slow, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Slow, MA_Method, Price, shift) / ma("AUDUSD", Slow, MA_Method, Price, shift) / (ma("EURUSD", Fast, MA_Method, Price,
      shift) / ma("AUDUSD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Slow, MA_Method, Price, shift) / ma("AUDUSD", Slow, MA_Method, Price, shift) / (ma("GBPUSD", Fast, MA_Method, Price,
      shift) / ma("AUDUSD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Fast, MA_Method, Price, shift) / ma("NZDUSD", Fast, MA_Method, Price, shift) / (ma("AUDUSD", Slow, MA_Method, Price,
      shift) / ma("NZDUSD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Fast, MA_Method, Price, shift) * ma("USDCHF", Fast, MA_Method, Price, shift) / (ma("AUDUSD", Slow, MA_Method, Price,
      shift) * ma("USDCHF", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Fast, MA_Method, Price, shift) * ma("USDCAD", Fast, MA_Method, Price, shift) / (ma("AUDUSD", Slow, MA_Method, Price,
      shift) * ma("USDCAD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Fast, MA_Method, Price, shift) * ma("USDJPY", Fast, MA_Method, Price, shift) / (ma("AUDUSD", Slow, MA_Method, Price,
      shift) * ma("USDJPY", Slow, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double nzdCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("NZDUSD", Fast, MA_Method, Price, shift) / ma("NZDUSD", Slow, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Slow, MA_Method, Price, shift) / ma("NZDUSD", Slow, MA_Method, Price, shift) / (ma("EURUSD", Fast, MA_Method, Price,
      shift) / ma("NZDUSD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Slow, MA_Method, Price, shift) / ma("NZDUSD", Slow, MA_Method, Price, shift) / (ma("GBPUSD", Fast, MA_Method, Price,
      shift) / ma("NZDUSD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Slow, MA_Method, Price, shift) / ma("NZDUSD", Slow, MA_Method, Price, shift) / (ma("AUDUSD", Fast, MA_Method, Price,
      shift) / ma("NZDUSD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("NZDUSD", Fast, MA_Method, Price, shift) * ma("USDCHF", Fast, MA_Method, Price, shift) / (ma("NZDUSD", Slow, MA_Method, Price,
      shift) * ma("USDCHF", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("NZDUSD", Fast, MA_Method, Price, shift) * ma("USDCAD", Fast, MA_Method, Price, shift) / (ma("NZDUSD", Slow, MA_Method, Price,
      shift) * ma("USDCAD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("NZDUSD", Fast, MA_Method, Price, shift) * ma("USDJPY", Fast, MA_Method, Price, shift) / (ma("NZDUSD", Slow, MA_Method, Price,
      shift) * ma("USDJPY", Slow, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double cadCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("USDCAD", Slow, MA_Method, Price, shift) / ma("USDCAD", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Slow, MA_Method, Price, shift) * ma("USDCAD", Slow, MA_Method, Price, shift) / (ma("EURUSD", Fast, MA_Method, Price,
      shift) * ma("USDCAD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Slow, MA_Method, Price, shift) * ma("USDCAD", Slow, MA_Method, Price, shift) / (ma("GBPUSD", Fast, MA_Method, Price,
      shift) * ma("USDCAD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Slow, MA_Method, Price, shift) * ma("USDCAD", Slow, MA_Method, Price, shift) / (ma("AUDUSD", Fast, MA_Method, Price,
      shift) * ma("USDCAD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("NZDUSD", Slow, MA_Method, Price, shift) * ma("USDCAD", Slow, MA_Method, Price, shift) / (ma("NZDUSD", Fast, MA_Method, Price,
      shift) * ma("USDCAD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("USDCHF", Fast, MA_Method, Price, shift) / ma("USDCAD", Fast, MA_Method, Price, shift) / (ma("USDCHF", Slow, MA_Method, Price,
      shift) / ma("USDCAD", Slow, MA_Method, Price, shift)) - 1;
   tmpResult += ma("USDJPY", Fast, MA_Method, Price, shift) / ma("USDCAD", Fast, MA_Method, Price, shift) / (ma("USDJPY", Slow, MA_Method, Price,
      shift) / ma("USDCAD", Slow, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double chfCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("USDCHF", Slow, MA_Method, Price, shift) / ma("USDCHF", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Slow, MA_Method, Price, shift) * ma("USDCHF", Slow, MA_Method, Price, shift) / (ma("EURUSD", Fast, MA_Method, Price,
      shift) * ma("USDCHF", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Slow, MA_Method, Price, shift) * ma("USDCHF", Slow, MA_Method, Price, shift) / (ma("GBPUSD", Fast, MA_Method, Price,
      shift) * ma("USDCHF", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Slow, MA_Method, Price, shift) * ma("USDCHF", Slow, MA_Method, Price, shift) / (ma("AUDUSD", Fast, MA_Method, Price,
      shift) * ma("USDCHF", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("NZDUSD", Slow, MA_Method, Price, shift) * ma("USDCHF", Slow, MA_Method, Price, shift) / (ma("NZDUSD", Fast, MA_Method, Price,
      shift) * ma("USDCHF", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("USDCHF", Slow, MA_Method, Price, shift) / ma("USDCAD", Slow, MA_Method, Price, shift) / (ma("USDCHF", Fast, MA_Method, Price,
      shift) / ma("USDCAD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("USDJPY", Fast, MA_Method, Price, shift) / ma("USDCHF", Fast, MA_Method, Price, shift) / (ma("USDJPY", Slow, MA_Method, Price,
      shift) / ma("USDCHF", Slow, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double jpyCalc(int shift) {
   if (Use_Current) shift--;
   double tmpResult = ma("USDJPY", Slow, MA_Method, Price, shift) / ma("USDJPY", Fast, MA_Method, Price, shift) - 1;
   tmpResult += ma("EURUSD", Slow, MA_Method, Price, shift) * ma("USDJPY", Slow, MA_Method, Price, shift) / (ma("EURUSD", Fast, MA_Method, Price,
      shift) * ma("USDJPY", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("GBPUSD", Slow, MA_Method, Price, shift) * ma("USDJPY", Slow, MA_Method, Price, shift) / (ma("GBPUSD", Fast, MA_Method, Price,
      shift) * ma("USDJPY", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("AUDUSD", Slow, MA_Method, Price, shift) * ma("USDJPY", Slow, MA_Method, Price, shift) / (ma("AUDUSD", Fast, MA_Method, Price,
      shift) * ma("USDJPY", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("NZDUSD", Slow, MA_Method, Price, shift) * ma("USDJPY", Slow, MA_Method, Price, shift) / (ma("NZDUSD", Fast, MA_Method, Price,
      shift) * ma("USDJPY", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("USDJPY", Slow, MA_Method, Price, shift) / ma("USDCAD", Slow, MA_Method, Price, shift) / (ma("USDJPY", Fast, MA_Method, Price,
      shift) / ma("USDCAD", Fast, MA_Method, Price, shift)) - 1;
   tmpResult += ma("USDJPY", Slow, MA_Method, Price, shift) / ma("USDCHF", Slow, MA_Method, Price, shift) / (ma("USDJPY", Fast, MA_Method, Price,
      shift) / ma("USDCHF", Fast, MA_Method, Price, shift)) - 1;
   return (tmpResult);
}

double ma(string actSymbol, int ma_period, int ma_method, int applied_price, int shift) {
   double res = 0;
   int factor = 1;
   if (Timeframe == 0) Timeframe = Period();
   int actTF = Timeframe;
   if (!Use_Bar_instead_of_MA) {
      switch (Timeframe) {
      case PERIOD_M1:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 5;
      case PERIOD_M5:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 3;
      case PERIOD_M15:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 2;
      case PERIOD_M30:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 2;
      case PERIOD_H1:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 4;
      case PERIOD_H4:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 6;
      case PERIOD_D1:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 4;
      case PERIOD_W1:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
         factor += 4;
      case PERIOD_MN1:
         res += iMA(actSymbol, actTF, ma_period * factor, 0, ma_method, applied_price, shift);
      }
   } else {
      if (ma_period == Fast) {
         switch (Timeframe) {
         case PERIOD_M1:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_M5:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_M15:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_M30:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_H1:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_H4:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_D1:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_W1:
            res += iClose(actSymbol, actTF, shift);
         case PERIOD_MN1:
            res += iClose(actSymbol, actTF, shift);
         }
      } else {
         switch (Timeframe) {
         case PERIOD_M1:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_M5:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_M15:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_M30:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_H1:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_H4:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_D1:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_W1:
            res += iOpen(actSymbol, actTF, shift);
         case PERIOD_MN1:
            res += iOpen(actSymbol, actTF, shift);
         }
      }
   }
   return res;
}

int Lookup(double ad_0) {
   int li_ret_12;
   int lia_8[19] = {-90, -80, -70, -60, -50, -40, -30, -20, -10, 0, 10, 20, 30, 40, 50, 60, 70, 80, 90};
   if (ad_0 <= lia_8[0]) li_ret_12 = -10;
   else {
      if (ad_0 < lia_8[1]) li_ret_12 = -9;
      else {
         if (ad_0 < lia_8[2]) li_ret_12 = -8;
         else {
            if (ad_0 < lia_8[3]) li_ret_12 = -7;
            else {
               if (ad_0 < lia_8[4]) li_ret_12 = -6;
               else {
                  if (ad_0 < lia_8[5]) li_ret_12 = -5;
                  else {
                     if (ad_0 < lia_8[6]) li_ret_12 = -4;
                     else {
                        if (ad_0 < lia_8[7]) li_ret_12 = -3;
                        else {
                           if (ad_0 < lia_8[8]) li_ret_12 = -2;
                           else {
                              if (ad_0 < lia_8[9]) li_ret_12 = -1;
                              else {
                                 if (ad_0 < lia_8[10]) li_ret_12 = 1;
                                 else {
                                    if (ad_0 < lia_8[11]) li_ret_12 = 2;
                                    else {
                                       if (ad_0 < lia_8[12]) li_ret_12 = 3;
                                       else {
                                          if (ad_0 < lia_8[13]) li_ret_12 = 4;
                                          else {
                                             if (ad_0 < lia_8[14]) li_ret_12 = 5;
                                             else {
                                                if (ad_0 < lia_8[15]) li_ret_12 = 6;
                                                else {
                                                   if (ad_0 < lia_8[16]) li_ret_12 = 7;
                                                   else {
                                                      if (ad_0 < lia_8[17]) li_ret_12 = 8;
                                                      else {
                                                         if (ad_0 < lia_8[18]) li_ret_12 = 9;
                                                         else li_ret_12 = 10;
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
   return (li_ret_12);
}

int colorCalc(double ad_0) {
   int color_12;
   int lia_8[19] = {-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
   if (ad_0 <= lia_8[0]) color_12 = Sell_color9;
   else {
      if (ad_0 == lia_8[1]) color_12 = Sell_color8;
      else {
         if (ad_0 == lia_8[2]) color_12 = Sell_color7;
         else {
            if (ad_0 == lia_8[3]) color_12 = Sell_color6;
            else {
               if (ad_0 == lia_8[4]) color_12 = Sell_color5;
               else {
                  if (ad_0 == lia_8[5]) color_12 = Sell_color4;
                  else {
                     if (ad_0 == lia_8[6]) color_12 = Sell_color3;
                     else {
                        if (ad_0 == lia_8[7]) color_12 = Sell_color2;
                        else {
                           if (ad_0 == lia_8[8]) color_12 = Sell_color1;
                           else {
                              if (ad_0 == lia_8[9]) color_12 = Buy_color1;
                              else {
                                 if (ad_0 == lia_8[10]) color_12 = Buy_color1;
                                 else {
                                    if (ad_0 == lia_8[11]) color_12 = Buy_color2;
                                    else {
                                       if (ad_0 == lia_8[12]) color_12 = Buy_color3;
                                       else {
                                          if (ad_0 == lia_8[13]) color_12 = Buy_color4;
                                          else {
                                             if (ad_0 == lia_8[14]) color_12 = Buy_color5;
                                             else {
                                                if (ad_0 == lia_8[15]) color_12 = Buy_color6;
                                                else {
                                                   if (ad_0 == lia_8[16]) color_12 = Buy_color7;
                                                   else {
                                                      if (ad_0 == lia_8[17]) color_12 = Buy_color8;
                                                      else {
                                                         if (ad_0 == lia_8[18]) color_12 = Buy_color9;
                                                         else color_12 = Buy_color10;
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
   return (color_12);
}

int colorCalc2(double ad_0) {
   int li_ret_12;
   int lia_8[19] = {-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
   if (ad_0 <= lia_8[0]) li_ret_12 = -1;
   else {
      if (ad_0 == lia_8[1]) li_ret_12 = -1;
      else {
         if (ad_0 == lia_8[2]) li_ret_12 = -1;
         else {
            if (ad_0 == lia_8[3]) li_ret_12 = -1;
            else {
               if (ad_0 == lia_8[4]) li_ret_12 = -1;
               else {
                  if (ad_0 == lia_8[5]) li_ret_12 = -1;
                  else {
                     if (ad_0 == lia_8[6]) li_ret_12 = -1;
                     else {
                        if (ad_0 == lia_8[7]) li_ret_12 = -1;
                        else {
                           if (ad_0 == lia_8[8]) li_ret_12 = -1;
                           else {
                              if (ad_0 == lia_8[9]) li_ret_12 = -1;
                              else {
                                 if (ad_0 == lia_8[10]) li_ret_12 = 11184810;
                                 else {
                                    if (ad_0 == lia_8[11]) li_ret_12 = 10526880;
                                    else {
                                       if (ad_0 == lia_8[12]) li_ret_12 = 9868950;
                                       else {
                                          if (ad_0 == lia_8[13]) li_ret_12 = 9211020;
                                          else {
                                             if (ad_0 == lia_8[14]) li_ret_12 = 8553090;
                                             else {
                                                if (ad_0 == lia_8[15]) li_ret_12 = 7895160;
                                                else {
                                                   if (ad_0 == lia_8[16]) li_ret_12 = 7237230;
                                                   else {
                                                      if (ad_0 == lia_8[17]) li_ret_12 = 6579300;
                                                      else {
                                                         if (ad_0 == lia_8[18]) li_ret_12 = 5921370;
                                                         else li_ret_12 = 5263440;
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
   return (li_ret_12);
}

void DrawObject(string a_name_0, int x, int startY, color a_color_16) {
   a_name_0 = Indicator_ID_Number + "CCFdiff" + a_name_0;
   if (ObjectFind(a_name_0) == -1) ObjectCreate(a_name_0, OBJ_LABEL, 0, 0, 0);
   ObjectSet(a_name_0, OBJPROP_CORNER, 2);
   ObjectSet(a_name_0, OBJPROP_XDISTANCE, x + X_offset_histo);
   ObjectSet(a_name_0, OBJPROP_YDISTANCE, startY + Y_offset_histo);
   ObjectSet(a_name_0, OBJPROP_BACK, TRUE);
   ObjectSet(a_name_0, OBJPROP_COLOR, a_color_16);
   ObjectSetText(a_name_0, "_", 30, "Arial", a_color_16);
}

void DrawText(string a_text_0, int x) {
   string name_12 = Indicator_ID_Number + "CCFdiff" + a_text_0;
   if (ObjectFind(name_12) == -1) ObjectCreate(name_12, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name_12, OBJPROP_CORNER, 2);
   ObjectSet(name_12, OBJPROP_XDISTANCE, x + X_offset_histo);
   ObjectSet(name_12, OBJPROP_YDISTANCE, Y_offset_histo + 59);
   ObjectSet(name_12, OBJPROP_COLOR, Currency_color);
   ObjectSetText(name_12, a_text_0, 7, "Arial", Currency_color);
   name_12 = Indicator_ID_Number + "CCFdiffcopy";
   if (ObjectFind(name_12) == -1) ObjectCreate(name_12, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name_12, OBJPROP_CORNER, 2);
   ObjectSet(name_12, OBJPROP_XDISTANCE, X_offset_histo + 10);
   ObjectSet(name_12, OBJPROP_YDISTANCE, Y_offset_histo + 5);
   ObjectSet(name_12, OBJPROP_COLOR, C'0x50,0x50,0x50');
   ObjectSetText(name_12, "CCFp-Diff - FerruFx - http://www_ervent_net", 7, "Arial", C'0x50,0x50,0x50');
   name_12 = Indicator_ID_Number + "CCFdiffline5";
   if (ObjectFind(name_12) == -1) ObjectCreate(name_12, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name_12, OBJPROP_CORNER, 2);
   ObjectSet(name_12, OBJPROP_XDISTANCE, X_offset_histo + 7);
   ObjectSet(name_12, OBJPROP_YDISTANCE, Y_offset_histo + 53);
   ObjectSet(name_12, OBJPROP_COLOR, C'0x50,0x50,0x50');
   ObjectSetText(name_12, "------------------------------------------------", 9, "Arial", C'0x50,0x50,0x50');
   name_12 = Indicator_ID_Number + "CCFdiffline6";
   if (ObjectFind(name_12) == -1) ObjectCreate(name_12, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name_12, OBJPROP_CORNER, 2);
   ObjectSet(name_12, OBJPROP_XDISTANCE, X_offset_histo + 7);
   ObjectSet(name_12, OBJPROP_YDISTANCE, Y_offset_histo + 65);
   ObjectSet(name_12, OBJPROP_COLOR, C'0x50,0x50,0x50');
   ObjectSetText(name_12, "------------------------------------------------", 9, "Arial", C'0x50,0x50,0x50');
   name_12 = Indicator_ID_Number + "CCFdiffline7";
   if (ObjectFind(name_12) == -1) ObjectCreate(name_12, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name_12, OBJPROP_CORNER, 2);
   ObjectSet(name_12, OBJPROP_XDISTANCE, X_offset_histo + 7);
   ObjectSet(name_12, OBJPROP_YDISTANCE, Y_offset_histo + 11);
   ObjectSet(name_12, OBJPROP_COLOR, C'0x50,0x50,0x50');
   ObjectSetText(name_12, "------------------------------------------------", 9, "Arial", C'0x50,0x50,0x50');
   name_12 = Indicator_ID_Number + "CCFdifftf";
   if (ObjectFind(name_12) == -1) ObjectCreate(name_12, OBJ_LABEL, 0, 0, 0);
   string ls_20 = "";
   if (Use_Current) ls_20 = " current";
   ObjectSet(name_12, OBJPROP_CORNER, 2);
   ObjectSet(name_12, OBJPROP_XDISTANCE, X_offset_histo + 7);
   ObjectSet(name_12, OBJPROP_YDISTANCE, Y_offset_histo + 70);
   ObjectSet(name_12, OBJPROP_COLOR, C'0x50,0x50,0x50');
   ObjectSetText(name_12, TFasTxt + ls_20, 9, "Arial Black", C'0x50,0x50,0x50');
}

void DrawNum(string as_0, double ad_8, int startX) {
   int li_20;
   ad_8 = NormalizeDouble(MathAbs(ad_8), 0);
   if (ad_8 == 0 || ad_8 == 2 || ad_8 == 3 || ad_8 == 4 || ad_8 == 5 || ad_8 == 6 || ad_8 == 7 || ad_8 == 8 || ad_8 == 9) li_20 = 6;
   else {
      if (ad_8 == 10) li_20 = -1;
      else
         if (ad_8 == 1) li_20 = 5;
   }
   string name_24 = Indicator_ID_Number + "CCFdiff_" + as_0;
   if (ObjectFind(name_24) == -1) ObjectCreate(name_24, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name_24, OBJPROP_CORNER, 2);
   ObjectSet(name_24, OBJPROP_XDISTANCE, startX + li_20 + X_offset_histo);
   ObjectSet(name_24, OBJPROP_YDISTANCE, Y_offset_histo + 38);
   ObjectSet(name_24, OBJPROP_COLOR, Currency_color);
   ObjectSetText(name_24, DoubleToStr(ad_8, 0), 12, "Arial Black", Values_color);
}

void DrawSuggest(string a_text_0, string as_8, int startY, color buySellColor, int ai_24) {
   if (!Use_Reverse_Suggestions) 
      gs_452 = " ";
   else 
      gs_452 = "";
   objName = Indicator_ID_Number + "CCF_diffline1";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 20);
   ObjectSetText(objName, "--------------------------------------", 9, "Arial", DarkGray);
   objName = Indicator_ID_Number + "CCF_diffsug";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   if (Timeframe == 0) Timeframe = Period();
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 30);
   ObjectSetText(objName, "Suggestion for " + Timeframe + "mins TF", 8, "Verdana", DarkGray);
   objName = Indicator_ID_Number + "CCF_difflev";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 45);
   ObjectSetText(objName, "Trade Level set to " + Trade_Level, 8, "Verdana", DarkGray);
   objName = Indicator_ID_Number + "CCF_diffline2";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 52);
   ObjectSetText(objName, "--------------------------------------", 9, "Arial", DarkGray);
   objName = Indicator_ID_Number + "CCF_diffline3";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 74);
   ObjectSetText(objName, "--------------------------------------", 9, "Arial", DarkGray);
   if (Use_Reverse_Suggestions) {
      objName = Indicator_ID_Number + "CCF_diff" + a_text_0 + "revlog";
      if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, 0);
      ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 6);
      ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 85);
      ObjectSetText(objName, "a", 8, "Wingdings", Reverse_color);
      objName = Indicator_ID_Number + "CCF_diff" + a_text_0 + "revinf";
      if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, 0);
      ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 20);
      ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 84);
      ObjectSetText(objName, "--> pairs to be reversed", 8, "Verdana", Reverse_color);
      objName = Indicator_ID_Number + "CCF_diffline8";
      if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, 0);
      ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
      ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 90);
      ObjectSetText(objName, "--------------------------------------", 9, "Arial", DarkGray);
   }
   if (a_text_0 != "NO") {
      objName = Indicator_ID_Number + "CCF_diff" + a_text_0;
      if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, 0);
      ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 25);
      ObjectSet(objName, OBJPROP_YDISTANCE, startY + Y_offset_comments);
      ObjectSetText(objName, a_text_0, 8, "Verdana", Pair_color);
      objName = Indicator_ID_Number + "CCF_diff" + a_text_0 + "suggest";
      if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, 0);
      ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
      ObjectSet(objName, OBJPROP_YDISTANCE, startY + Y_offset_comments);
      ObjectSetText(objName, " ¤                 " + gs_452 + "--->" + gs_452 + "   " + as_8, 8, "Verdana", buySellColor);
      if (Use_Reverse_Suggestions && ai_24 == -1) {
         objName = Indicator_ID_Number + "CCF_diff" + a_text_0 + "rev";
         if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
         ObjectSet(objName, OBJPROP_CORNER, 0);
         ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 145);
         ObjectSet(objName, OBJPROP_YDISTANCE, startY + 1 + Y_offset_comments);
         ObjectSetText(objName, "a", 7, "Wingdings", Reverse_color);
      }
   } else {
      objName = Indicator_ID_Number + "CCF_diff" + a_text_0;
      if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, 0);
      ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
      ObjectSet(objName, OBJPROP_YDISTANCE, startY - 3 + Y_offset_comments);
      ObjectSetText(objName, "   ¤ " + as_8 + " ¤", 9, "Verdana", buySellColor);
   }
}

void DrawLast(int ai_0) {
   objName = Indicator_ID_Number + "CCF_diffline4";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, ai_0 - 8 + Y_offset_comments);
   ObjectSetText(objName, "--------------------------------------", 9, "Arial", DarkGray);
   string text_4 = "Refreshing process done !";
   if (IsRefreshingReady) text_4 = "Pairs refresh, Waiting ______";
   objName = Indicator_ID_Number + "CCF_diffrefresh";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 7);
   ObjectSet(objName, OBJPROP_YDISTANCE, ai_0 + 2 + Y_offset_comments);
   ObjectSetText(objName, text_4, 8, "Verdana", CadetBlue);
   objName = Indicator_ID_Number + "CCF_diffline9";
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, ai_0 + 8 + Y_offset_comments);
   ObjectSetText(objName, "--------------------------------------", 9, "Arial", DarkGray);
}

void DrawTimer() {
   objName = Indicator_ID_Number + "CCF_difftimer";
   if (Timeframe == 0) Timeframe = Period();
   int li_0 = iTime(Symbol(), Timeframe, 0) + 60 * Timeframe - TimeCurrent();
   if (ObjectFind(objName) == -1) ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_XDISTANCE, X_offset_comments + 5);
   ObjectSet(objName, OBJPROP_YDISTANCE, Y_offset_comments + 62);
   ObjectSetText(objName, " Bar end: " + TimeToStr(li_0, TIME_SECONDS), 12, "Eras Bold ITC", Timer_color);
   if (SignalAlert || SendAlertEmail && g_datetime_420 != iTime(Symbol(), Timeframe, 0)) {
      if (SignalAlert) Alert("CCFp-Diff - New ", Timeframe, "mins bar started - ", TimeToStr(TimeCurrent(), TIME_SECONDS));
      if (SendAlertEmail) SendMail("CCFp-Diff Alert", "CCFp-Diff - New " + Timeframe + "mins bar started - " + TimeToStr(TimeCurrent(), TIME_SECONDS) + " (server time)");
      g_datetime_420 = iTime(Symbol(), Timeframe, 0);
   }
}

void cleanup() {
   string name_0;
   int objs_total_8 = ObjectsTotal();
   for (int li_12 = objs_total_8 - 1; li_12 >= 0; li_12--) {
      name_0 = ObjectName(li_12);
      if (StringFind(name_0, Indicator_ID_Number + "CCFdiff") == 0) ObjectDelete(name_0);
      if (StringFind(name_0, Indicator_ID_Number + "CCF_diff") == 0) ObjectDelete(name_0);
   }
}