//+------------------------------------------------------------------+
//| Class CTimeTrade                                                 |
//| Description: Class Info Time Trade                               |
//+------------------------------------------------------------------+
class CTimeTrade
{
   public:
      CTimeTrade()                        {};
     ~CTimeTrade()                        {};  
      // Propriedades
      bool                 mUse;
      string               mStart;
      string               mEnd;
      bool                 mUseClose;
      string               mClose;
     
      // Métodos
      bool                 ReturnTimeTrade();
      bool                 ReturnTimeTradeClose();
      
      string               ReturnDataTime();
      string               ReturnCandleTime();
};
//+------------------------------------------------------------------+
//| Return Time Trade                                                |
//+------------------------------------------------------------------+
bool CTimeTrade::ReturnTimeTrade(void)
{
   bool result = true;
   
   if (mUse)
   {
      datetime vCurrent =  TimeCurrent();
      datetime vStart   =  StringToTime(mStart);
      datetime vEnd     =  StringToTime(mEnd);
      
      if (vStart < vEnd)
      if (vCurrent < vStart)
         return false;
         
      if (vStart < vEnd)
      if (vCurrent >= vEnd)
         return false;
         
      if (vStart > vEnd)
         return false;
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Time Trade Close                                          |
//+------------------------------------------------------------------+
bool CTimeTrade::ReturnTimeTradeClose(void)
{
   bool result = false;
   
   if (mUse && mUseClose)
   {
      datetime vCurrent =  TimeCurrent();
      datetime vStart   =  StringToTime(mStart);
      datetime vEnd     =  StringToTime(mEnd);
      datetime vClose   =  StringToTime(mClose);
      
      if (vStart < vEnd)
      if (vStart < vClose)
      if (vCurrent >= vStart)
      if (vCurrent >= vClose)
         return true;
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Data Time                                                 |
//+------------------------------------------------------------------+
string CTimeTrade::ReturnDataTime(void)
{
   MqlDateTime date;
   TimeCurrent(date);
   // Get info of the Date
   string   day   =  (string)date.day;
   string   month =  (string)date.mon;
   string   year  =  (string)date.year;
   string   hour  =  (string)date.hour;
   string   min   =  (string)date.min;
   string   sec   =  (string)date.sec;
   
   if (date.day < 10)
      day   =  "0"+day;
   if (date.mon < 10)
      month =  "0"+month;
   if (date.hour < 10)
      hour  =  "0"+hour;
   if (date.min < 10)
      min   =  "0"+min;
   if (date.sec  < 10)
      sec   =  "0"+sec;
   
   // Write the date   
   string   data  =  day+"/"+month+"/"+year+" | "+hour+":"+min+":"+sec;
   
   return data;
}
//+------------------------------------------------------------------+
//| Return Candle Time                                               |
//+------------------------------------------------------------------+
string CTimeTrade::ReturnCandleTime(void)
{
   int bar_index=iBarShift(Symbol(),PERIOD_CURRENT,TimeCurrent());
	int m=int(iTime(Symbol(),PERIOD_CURRENT,bar_index)+PeriodSeconds()-TimeCurrent());
	int s=m%60;
	m=(m-s)/60;
	long spread=SymbolInfoInteger(Symbol(), SYMBOL_SPREAD);
	
	string _sp="",_m="",_s="";
	if (spread<10) _sp="..";
	else if (spread<100) _sp=".";
	if (m<10) _m="0";
	if (s<10) _s="0";
	
	return _m+IntegerToString(m)+":"+_s+IntegerToString(s);
}