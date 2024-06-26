//+------------------------------------------------------------------+
//| Renko                                                            |
//+------------------------------------------------------------------+
#include <RenkoCharts.mqh>
//+------------------------------------------------------------------+
//| ENUM                                                             |
//+------------------------------------------------------------------+
enum typeNormalReverso
{
   Normal,              // Normal
   Reverso,             // Reverso
};
//+------------------------------------------------------------------+
//| Class CTimeTrade                                                 |
//| Description: Class Info Time Trade                               |
//+------------------------------------------------------------------+
class CIndicador
{
   public:
      CIndicador()                        {};
     ~CIndicador()                        {};  
      // Objetos
      RenkoCharts                         *RenkoOffline;
      // Propriedades
      bool                                mUse;
      string                              mSymbol;
      typeNormalReverso                   mNormalReverso;
      ENUM_TIMEFRAMES                     mTimeFrame;
      bool                                mRenkoUsar;
      int                                 mRenkoSize;
      int                                 mMedia;
      int                                 mMacdSinal;
      int                                 mMacdCurta;
      int                                 mMacdLonga;
      
      int                                 mHandleMacd;
      int                                 mHandleMedia;
      double                              mValorMacd[];
      double                              mValorMedia[];
      
      string                              gOriginalSymbol;
      string                              gCustomSymbol;
      ENUM_RENKO_TYPE                     gRenkoType;
      bool                                gRenkoWicks;  
      bool                                gRenkoTime;   
      bool                                gRenkoAsymetricReversal; 
      ENUM_RENKO_WINDOW                   gRenkoWindow;    
      int                                 gRenkoTimer;    
      bool                                gRenkoBook;     
      bool                                gDebugMode;
      // Métodos
      void                                Inicializar();
      bool                                InicializarRenko();
      // Refresh
      void                                RefreshBuffer();
      // Return
      int                                 ReturnResultadoIndicador();
};
//+------------------------------------------------------------------+
//| Inicializar                                                      |
//+------------------------------------------------------------------+
void CIndicador::Inicializar(void)
{
   if (mUse)
   {
      if (mSymbol == "")
         mSymbol = Symbol();
       
      gRenkoType                 =  RENKO_TYPE_TICKS;
      gRenkoWicks                =  true;
      gRenkoTime                 =  true;
      gRenkoAsymetricReversal    =  false;
      gRenkoWindow               =  RENKO_NO_WINDOW;
      gRenkoTimer                =  500;
      gRenkoBook                 =  true;
      gDebugMode                 = (MQL5InfoInteger(MQL5_TESTER) || MQL5InfoInteger(MQL5_DEBUG) || MQL5InfoInteger(MQL5_DEBUGGING) || MQL5InfoInteger(MQL5_OPTIMIZATION) || MQL5InfoInteger(MQL5_VISUAL_MODE) || MQL5InfoInteger(MQL5_PROFILER));  
   
      if(mRenkoUsar)
         if (!InicializarRenko())
            mUse = false;
      
      if (mUse)
      {
         mHandleMacd                =  iMACD(mSymbol,mTimeFrame,mMacdCurta,mMacdLonga,mMacdSinal,PRICE_CLOSE);
         mHandleMedia               =  iMA(mSymbol,mTimeFrame,mMedia,0,MODE_EMA,mHandleMacd);
      }   
      
   }
}
//+------------------------------------------------------------------+
//| Inicializar Renko                                                |
//+------------------------------------------------------------------+
bool CIndicador::InicializarRenko(void)
{
   //Check Symbol
   gOriginalSymbol = StringAt(mSymbol, "_");

   //Check Period
   if(gRenkoWindow == RENKO_CURRENT_WINDOW && ChartPeriod(0) != PERIOD_M1)
     {
      Print("Renko must be M1 period!", __FILE__, MB_OK);
      ChartSetSymbolPeriod(0, gOriginalSymbol, PERIOD_M1);
      return true;
     }
   //Setup Renko
   if (RenkoOffline == NULL) 
      if ((RenkoOffline = new RenkoCharts()) == NULL)
        {
         MessageBox("Renko create class error. Check error log!", __FILE__, MB_OK);
         return false;
        }
   if (!RenkoOffline.Setup(gOriginalSymbol, gRenkoType, mRenkoSize, gRenkoWicks, gRenkoTime, gRenkoAsymetricReversal))
     {
      MessageBox("Renko setup error. Check error log!", __FILE__, MB_OK);
      return false;
     }
   //Create Custom Symbol
   RenkoOffline.CreateCustomSymbol();
   RenkoOffline.ClearCustomSymbol();
   gCustomSymbol = RenkoOffline.GetSymbolName();
   //Load History
   RenkoOffline.UpdateRates();
   RenkoOffline.ReplaceCustomSymbol();  
   //Start

   RenkoOffline.Start(gRenkoWindow, gRenkoTimer, gRenkoBook);
   //Refresh
   RenkoOffline.Refresh();
   
   mSymbol = gCustomSymbol;
   
   return true;
}
//+------------------------------------------------------------------+
//| Refresh Buffer                                                   |
//+------------------------------------------------------------------+
void CIndicador::RefreshBuffer(void)
{
   if (mUse)
   {
      CopyBuffer(mHandleMacd,1,0,5,mValorMacd);
      ArraySetAsSeries(mValorMacd,true);
      
      CopyBuffer(mHandleMedia,0,0,5,mValorMedia);
      ArraySetAsSeries(mValorMedia,true);
   }
}
//+------------------------------------------------------------------+
//| Return Resultado Indicador                                       |
//+------------------------------------------------------------------+
int CIndicador::ReturnResultadoIndicador(void)
{
   int result = -2;
   
   if (mUse)
   {
      result = -1;
      
      if (mValorMedia[1] > mValorMedia[2])
      if (mValorMedia[2] > mValorMedia[3])
      if (mValorMacd[1] > mValorMacd[2])
      if (mValorMacd[2] > mValorMacd[3])
      if (iClose(mSymbol,PERIOD_CURRENT,1) > iOpen(mSymbol,PERIOD_CURRENT,1))
      if (iClose(mSymbol,PERIOD_CURRENT,2) < iOpen(mSymbol,PERIOD_CURRENT,2))
         return 0;
         
      if (mValorMedia[1] < mValorMedia[2])
      if (mValorMedia[2] < mValorMedia[3])
      if (mValorMacd[1] < mValorMacd[2])
      if (mValorMacd[2] < mValorMacd[3])
      if (iClose(mSymbol,PERIOD_CURRENT,1) < iOpen(mSymbol,PERIOD_CURRENT,1))
      if (iClose(mSymbol,PERIOD_CURRENT,2) > iOpen(mSymbol,PERIOD_CURRENT,2))
         return 1;
      
   }   
   
   return result;
}
//+------------------------------------------------------------------+
