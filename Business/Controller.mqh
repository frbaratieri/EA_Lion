//+------------------------------------------------------------------+
//| Define                                                           |
//+------------------------------------------------------------------+
#define KEY_BUY         20
#define KEY_SELL        16
#define KEY_CANCEL      27
#define KEY_TIME        10
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include                <Generic\ArrayList.mqh>
#include                <Trade\Trade.mqh>
#include                <Trade\PositionInfo.mqh>

#include                <../Experts/RB Investe/Lion/GUI/GUI.mqh>
#include                <../Experts/RB Investe/Lion/Model/TimeTrade.mqh>
//+------------------------------------------------------------------+
//| Enumerates                                                       |
//+------------------------------------------------------------------+
enum typeCompraVenda
{
   CompraVenda,         // Compra e Venda
   Compra,              // Compra
   Venda,               // Venda
};
enum typePontosPips
{
   Pontos,              // Pontos
   Pips,                // Pips
};
enum typeNormalReverso
{
   Normal,              // Normal
   Reverso,             // Reverso
};
enum typeTP
{
   Mercado,             // Mercado
   Limit,               // Limit
};
enum typeAutomaticoManual
{
   Automatico,          // Automático
   Manual,              // Manual
};
enum typeCusto
{
   PorContrato,         // Por Contrato
   PorOperacao,         // Por Operação
};
//+------------------------------------------------------------------+
//| Class CController                                                |
//| Description: Controller Class                                    |
//+------------------------------------------------------------------+
class CController
{
   public:
      CController();
     ~CController();
      // Objetos
      CTrade               objetoTrade;
      CTrade               objetoTradeLimit;
      CPositionInfo        objetoPosition;
      CGUI                 objetoGUI;
      CTimeTrade           objetoTimeTrade;
      // Propriedades
      string               mLogin;
      
      string               mSymbol;
      string               mSymbolIndicador;
      typeCompraVenda      mSymbolCompraVenda;
      typePontosPips       mSymbolPontosPips;
      typeCusto            mSymbolTypeCusto;
      double               mSymbolCusto;
      int                  mSymbolSpread;
      
      bool                 mRenkoUse;
      int                  mRenkoSize;
      
      bool                 mTimeTradeUse;
      string               mTimeTradeStart;
      string               mTimeTradeEnd;
      bool                 mTimeTradeCloseUse;
      string               mTimeTradeClose;
      
      bool                 mSleepUse;
      int                  mSleepLoss;
      int                  mSleepGain;
      
      typeAutomaticoManual mTradeAutomaticoManual;
      typeNormalReverso    mTradeNormalReverso;
      int                  mTradeMagicNumber;
      int                  mTradeMagicNumberLimit;
      string               mTradeComentario;
      double               mTradeVolume;
      double               mTradeVolumeMaximo;
      double               mTradeDistancia;
      
      double               mStop;
      
      double               mTakeProfit;
      typeTP               mTakeProfitType;
      
      double               mLossPosition;
      double               mLossDay;
      double               mLossWeek;
      double               mLossMonth;
      
      double               mGainPosition;
      double               mGainDay;
      double               mGainWeek;
      double               mGainMonth;
      
      bool                 mCicloUse;
      datetime             mCicloDataInicial;
      double               mCicloLoss;
      double               mCicloGain;
      
      // Gerais
      bool                 gIsNewBar;
      
      bool                 gIsOpen;
      bool                 gIsOpenBuy;
      bool                 gIsOpenSell;
      bool                 gIsOpenLimit;
      
      int                  gOpenCount;
      int                  gOpenCountBuy;
      int                  gOpenCountSell;
      
      double               gResultOpen;
      double               gResultOpenBuy;
      double               gResultOpenSell;
      
      double               gVolumeOpen;
      double               gVolumeOpenBuy;
      double               gVolumeOpenSell;
      
      double               gPrecoMedio;
      double               gPrecoMedioBuy;
      double               gPrecoMedioSell;
      
      double               gResultDay;
      double               gResultWeek;
      double               gResultMonth;
      double               gResultCiclo;
      
      int                  gOperacaoAberta;
      
      double               gProximaEntradaAcima;
      double               gProximaEntradaAbaixo;
      
      int                  gKeyDownMode;
      datetime             gKeyDownTime;
      datetime             gKeyDownTimeLimit;
      double               gKeyDownPreco;
      
      // Métodos
      // ChartEvent
      void                 ChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam);
      // Checks
      void                 CheckLossGain();
      bool                 CheckLossGainAbrirNovasPosicoes();
      bool                 CheckPosicaoInicial(int vType);
      bool                 CheckNovasPosicoes();
      bool                 CheckInverter(bool vClickMouse);
      bool                 CheckCiclo();
      bool                 CheckCloseLimit();
      bool                 CheckKeyDown();
      bool                 CheckMouseLines(const int id,const long &lparam,const double &dparam,const string &sparam);
      bool                 CheckSendOrderMouse();
      bool                 CheckOrdersTakeProfitLimits();
      
      // Modo
      void                 ModoKeyCancel();
      
      // Refresh
      void                 RefreshGUI();
      void                 RefreshGUIPosicoesOrdens();
      void                 RefreshDay();
      void                 RefreshResultOpen(bool vConferencia);
      void                 RefreshResultDay();
      void                 RefreshResultWeek();
      void                 RefreshResultMonth();
      void                 RefreshCiclo();
      bool                 RefreshStopTPType(int vType, double vStop, double vTP);
      // Returns
      bool                 ReturnIsNewBar();
      bool                 ReturnIsNewBarDay();
      double               ReturnAsk()                                     { return SymbolInfoDouble(mSymbol,SYMBOL_ASK); }
      double               ReturnBid()                                     { return SymbolInfoDouble(mSymbol,SYMBOL_BID); }
      int                  ReturnSpread()                                  { return SymbolInfoInteger(mSymbol,SYMBOL_SPREAD); }
      double               ReturnTradeTickSize()                           { return SymbolInfoDouble(mSymbol,SYMBOL_TRADE_TICK_SIZE); }
      double               ReturnPreco(double vPreco);
      double               ReturnCusto(double vVolume);
      
      // Sends
      bool                 SendClose(int vType);
      bool                 SendDelete(int vType);
      bool                 SendDeleteByMagicNumber(int vType, int vMagicNumber);
      bool                 SendDeleteByTicket(ulong vTicket);
      bool                 SendBuy(double vVolume, double vStop, double vTP);
      bool                 SendSell(double vVolume, double vStop, double vTP);
      bool                 SendOrdersTakeProfitLimits(ulong vTicket, double vPreco, double vVolume, int vType,double vStop,double vTP);
      
      // Sleep
      void                 SleepTime(double vSegundos);
      
      
};
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CController::CController(void)
{
   
}  
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CController::~CController(void)
{
   
}
//+------------------------------------------------------------------+
//| Chart Event                                                      |
//+------------------------------------------------------------------+
void CController::ChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
{
   if (id == CHARTEVENT_OBJECT_CLICK)
   {
      if (sparam == objetoGUI.oBtnComprar.Name())
      {
         PrintFormat("Click Botão Comprar");
         CheckPosicaoInicial(0);
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnVender.Name())
      {
         PrintFormat("Click Botão Vender");
         CheckPosicaoInicial(1);
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnZerar.Name())
      {
         PrintFormat("Click Botão Zerar");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnCancelar.Name())
      {
         PrintFormat("Click Botão Cancelar");
         SendDelete(-1);
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnInverter.Name())
      {
         PrintFormat("Click Botão Inverter");
         CheckInverter(true);
         ChartRedraw(0);
      }
      else if (StringFind(sparam,"orderBOX",0) != -1)
      {
         string ticketS = StringSubstr(sparam,8,-1);
         ulong ticket = StringToInteger(ticketS);
         
         int result = MessageBox("Você deseja eletar a Ordem: "+ticketS+" ?","Deletar Ordem",MB_YESNO);
         
         if (result == IDYES)
            SendDeleteByTicket(ticket);
         
         
      }
   }
   else if (id == CHARTEVENT_KEYDOWN)
   {
      if (mTradeAutomaticoManual == Manual)
      {
         int result = ((int)lparam);
         
         switch(result)
         {
            case KEY_CANCEL:
               gKeyDownTime = 0;
               gKeyDownMode = KEY_CANCEL;
               objetoGUI.DeleteLinesInput();
               ChartRedraw(0);
            break;
            case KEY_BUY:
               gKeyDownTime = TimeCurrent() + KEY_TIME;
               gKeyDownMode = KEY_BUY;
            break;
            case KEY_SELL:
               gKeyDownTime = TimeCurrent() + KEY_TIME;
               gKeyDownMode = KEY_SELL;
            break;
         }
      }
   }
   else if (id == CHARTEVENT_MOUSE_MOVE)
   {
      if (mTradeAutomaticoManual == Manual)
      {
         if (gKeyDownMode != KEY_CANCEL)
         {
            if (CheckKeyDown())
            {
               CheckMouseLines(id,lparam,dparam,sparam);
            
            }
         }
      }
   }
   else if (id == CHARTEVENT_CLICK)
   {
      if (mTradeAutomaticoManual == Manual)
      {
         if (gKeyDownMode != KEY_CANCEL)
         {
            CheckSendOrderMouse();
         }
      }
   
   }
}
//+------------------------------------------------------------------+
//| Check New Position                                               |
//+------------------------------------------------------------------+
bool CController::CheckPosicaoInicial(int vType)
{
   if (mTradeAutomaticoManual == Automatico)
   {
      if (gIsNewBar)
      if (!gIsOpen)
      if (CheckLossGainAbrirNovasPosicoes())
      if ( (mSymbolSpread == 0) || (ReturnSpread() <= mSymbolSpread) )
      {
      
      
      }
   
   }
   else if (mTradeAutomaticoManual == Manual)
   {
      if (!gIsOpen)
      if (CheckLossGainAbrirNovasPosicoes())
      if ( (mSymbolSpread == 0) || (ReturnSpread() <= mSymbolSpread) )
      {
         if (vType == 0)
         {
            if (SendBuy(mTradeVolume, mStop, mTakeProfit))
            {
               gOperacaoAberta = 0;
               gProximaEntradaAcima = -1;
               gProximaEntradaAbaixo = -1;
               return true;
            }
         
         }
         else if (vType == 1)
         {
            if (SendSell(mTradeVolume, mStop, mTakeProfit))
            {
               gOperacaoAberta = 1;
               gProximaEntradaAcima = -1;
               gProximaEntradaAbaixo = -1;
               return true;
            }
         
         }
      }
      
   
   }
   
   return false;
 
}
//+------------------------------------------------------------------+
//| Check Novas Posicoes                                             |
//+------------------------------------------------------------------+
bool CController::CheckNovasPosicoes(void)
{
   if (gOperacaoAberta != -1)
   if (gVolumeOpen + mTradeVolume <= mTradeVolumeMaximo)
   if ( (mSymbolSpread == 0) || (ReturnSpread() <= mSymbolSpread) )
   {
      if (gOperacaoAberta == 0)
      {
         if (gProximaEntradaAbaixo > 0 && gProximaEntradaAcima > 0)
         {
            if (ReturnAsk() >= gProximaEntradaAcima || ReturnAsk() <= gProximaEntradaAbaixo)
            {
               if (SendBuy(mTradeVolume,mStop,mTakeProfit))
               {
                  gProximaEntradaAbaixo = -1;
                  gProximaEntradaAcima = -1;
                  return true;
               }
            
            }
         }
         else if (gProximaEntradaAbaixo == 0 && gProximaEntradaAcima == 0)
         {
            if (!gIsOpen)
            {
               if (SendBuy(mTradeVolume,mStop,mTakeProfit))
               {
                  gProximaEntradaAbaixo = -1;
                  gProximaEntradaAcima = -1;
                  return true;
               }
            
            }
         }
      }
      else if (gOperacaoAberta == 1)
      {
         if (gProximaEntradaAbaixo > 0 && gProximaEntradaAcima > 0)
         {
            if (ReturnBid() >= gProximaEntradaAcima || ReturnBid() <= gProximaEntradaAbaixo)
            {
               if (SendSell(mTradeVolume,mStop,mTakeProfit))
               {
                  gProximaEntradaAbaixo = -1;
                  gProximaEntradaAcima = -1;
                  return true;
               }
            
            }
         }
         else if (gProximaEntradaAbaixo == 0 && gProximaEntradaAcima == 0)
         {
            if (!gIsOpen)
            {
               if (SendSell(mTradeVolume,mStop,mTakeProfit))
               {
                  gProximaEntradaAbaixo = -1;
                  gProximaEntradaAcima = -1;
                  return true;
               }
            
            }
         }
      
      }
   }
   
   return false;
}
//+------------------------------------------------------------------+
//| Check Inverter                                                   |
//+------------------------------------------------------------------+
bool CController::CheckInverter(bool vClickMouse)
{
   if (gIsOpen)
   {
      if (vClickMouse)
      {
         if (mTradeAutomaticoManual == Manual)
         {
            if (gIsOpenBuy && gOperacaoAberta == 0)
            {
               double volume = gVolumeOpenBuy;
               if (SendClose(-1))
               {
                  SendDelete(-1);
                  if (SendSell(volume,mStop,mTakeProfit))
                  {
                     gProximaEntradaAbaixo = -1;
                     gProximaEntradaAcima = -1;
                     return true;
                  }
               }
            }
            else if (gIsOpenSell && gOperacaoAberta == 1)
            {
               double volume = gVolumeOpenSell;
               if (SendClose(-1))
               {
                  SendDelete(-1);
                  if (SendBuy(volume,mStop,mTakeProfit))
                  {
                     gProximaEntradaAbaixo = -1;
                     gProximaEntradaAcima = -1;
                     return true;
                  }
               }
            }
         }
      }
      else
      {
         if (mTradeAutomaticoManual == Automatico)
         {
            if (gIsNewBar)
            {
            
            
            }
         }
      }
   }
   
   return false;
}
//+------------------------------------------------------------------+
//| Check Loss Gain                                                  |
//+------------------------------------------------------------------+
void CController::CheckLossGain(void)
{
   if (gIsOpen)
   {
      if (mLossPosition < 0)
      if (gResultOpen <= mLossPosition)
      {
         PrintFormat("Prejuízo máximo da posição atingido: "+DoubleToString(gResultOpen,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mLossDay < 0)
      if (gResultOpen + gResultDay <= mLossDay)
      {
         PrintFormat("Prejuízo máximo diário atingido: "+DoubleToString(gResultOpen+gResultDay,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mLossWeek < 0)
      if (gResultOpen + gResultWeek <= mLossWeek)
      {
         PrintFormat("Prejuízo máximo semanal atingido: "+DoubleToString(gResultOpen+gResultWeek,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mLossMonth < 0)
      if (gResultOpen + gResultMonth <= mLossMonth)
      {
         PrintFormat("Prejuízo máximo mensal atingido: "+DoubleToString(gResultOpen+gResultMonth,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mGainPosition > 0)
      if (gResultOpen >= mGainPosition*1.05)
      {
         PrintFormat("Lucro máximo da posição atingido: "+DoubleToString(gResultOpen,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mGainDay > 0)
      if (gResultOpen + gResultDay >= mGainDay*1.05)
      {
         PrintFormat("Lucro máximo do dia atingido: "+DoubleToString(gResultOpen+gResultDay,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mGainWeek > 0)
      if (gResultOpen + gResultWeek >= mGainWeek*1.05)
      {
         PrintFormat("Lucro máximo da semana atingido: "+DoubleToString(gResultOpen+gResultWeek,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
      
      if (mGainMonth > 0)
      if (gResultOpen + gResultWeek >= mGainMonth*1.05)
      {
         PrintFormat("Lucro máximo do mês atingido: "+DoubleToString(gResultOpen+gResultMonth,2));
         PrintFormat("Fechando todas as posições");
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
      }
   }
}
//+------------------------------------------------------------------+
//| Check New Position                                               |
//+------------------------------------------------------------------+
bool CController::CheckLossGainAbrirNovasPosicoes(void)
{
   bool result = true;
   
   if (!gIsOpen)
   {
      if (mLossDay < 0)
      if (gResultDay <= mLossDay)
         return false;
         
      if (mLossWeek < 0)
      if (gResultWeek <= mLossWeek)
         return false;
      
      if (mLossMonth < 0)
      if (gResultMonth <= mLossMonth)
         return false;
         
      if (mGainDay > 0)
      if (gResultDay >= mGainDay)
         return false;
      
      if (mGainWeek > 0)
      if (gResultWeek >= mGainWeek)
         return false;
      
      if (mGainMonth > 0)
      if (gResultMonth >= mGainMonth)
         return false;
   }
   return result;
}
//+------------------------------------------------------------------+
//| Check Ciclo                                                      |
//+------------------------------------------------------------------+
bool CController::CheckCiclo(void)
{
   if (mCicloUse)
   {
      if (gIsOpen)
      {
         if ( (gResultCiclo + gResultOpen <= mCicloLoss) )
         {
            PrintFormat("Encerramento de posição através da perda máxima do Ciclo");
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if ( (gResultCiclo + gResultOpen >= mCicloGain*1.05) )
         {
            PrintFormat("Encerramento de posição através do ganho máximo do Ciclo");
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
      
      }
   
   }

   return false;
}
//+------------------------------------------------------------------+
//| Check Ciclo                                                      |
//+------------------------------------------------------------------+
bool CController::CheckCloseLimit(void)
{
   bool result = false;
   
   if (gIsOpenLimit)
   {
      ulong ticketPosition = 0;
      ulong ticketLimit = 0;
      
      int i = PositionsTotal()-1;
      
      while (i >= 0)
      {
      
         PositionGetSymbol(i);
         GetPositionProperties();
         
         if (pos_symbol == mSymbol)
         if (pos_magic == mTradeMagicNumberLimit)
         {
            ticketLimit = pos_ticket;
            ticketPosition = StringToInteger(pos_comment);
            PrintFormat("Close Limit: "+IntegerToString(ticketLimit));
            PrintFormat("Close Position: "+IntegerToString(ticketPosition));
            
            if (objetoTrade.PositionCloseBy(ticketPosition,ticketLimit))
            {
               PrintFormat("Posições opostas encerradas com sucesso!");
               SleepTime(1);
               return true;
            }
            else
            {
               PrintFormat("Erro ao encerrar posições opostas.");
               SleepTime(1);
               return false;
            }
            
         }
         i--;
      }
   
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Check KeyDown                                                    |
//+------------------------------------------------------------------+
bool CController::CheckKeyDown(void)
{
   bool result = true;
   
   if (mTradeAutomaticoManual == Manual)
   {
      if (gKeyDownMode != KEY_CANCEL)
      {
         if (TimeCurrent() > gKeyDownTime)
         {
            gKeyDownMode = KEY_CANCEL;
            objetoGUI.DeleteLinesInput();
            ChartRedraw(0);
            return false;
         }
      }
   }
   
   
   return result;
}
//+------------------------------------------------------------------+
//| Check Mouse Lines                                                |
//+------------------------------------------------------------------+
bool CController::CheckMouseLines(const int id,const long &lparam,const double &dparam,const string &sparam)
{
   bool result = true;
   
   if (mTradeAutomaticoManual == Manual)
   {
      int x = (int)lparam;
      int y = (int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      string   msg = "";
      
      if (ChartXYToTimePrice(0,x,y,window,dt,price))
      {
         if (gKeyDownMode == KEY_BUY)
         {
            price = ReturnPreco(price);
            if (price > ReturnAsk())
               msg = "C. Stop - " + DoubleToString(price,_Digits);
            else 
               msg = "C. Limit - " + DoubleToString(price,_Digits);
               
            gKeyDownPreco = price;
         }
         else 
         {
            price = ReturnPreco(price);
            if (price > ReturnBid())
               msg = "V. Limit - " + DoubleToString(price,_Digits);
            else 
               msg = "V. Stop - " + DoubleToString(price,_Digits);
               
            gKeyDownPreco = price;
         }
         
         objetoGUI.CreateLine("input_Line",gKeyDownPreco,objetoGUI.mCorOrdem,objetoGUI.mLineOrdem);
         objetoGUI.CreateBoxInput("input_Box",gKeyDownPreco,objetoGUI.mCorBox,objetoGUI.mCorBoxText,msg);
         
      }
   
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Check Send Mouse Order                                           |
//+------------------------------------------------------------------+
bool CController::CheckSendOrderMouse(void)
{
   bool result = true;
   
   if (CheckLossGainAbrirNovasPosicoes())
   {
      if (gKeyDownPreco > 0)
   {
      if (gKeyDownMode == KEY_BUY)
      {
         if (!gIsOpen || gIsOpenBuy)
         {
            if (gKeyDownPreco > ReturnAsk())
            {
               if (objetoTrade.BuyStop(mTradeVolume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  PrintFormat("Ordem Compra Stop enviada através do mouse.");
                  ModoKeyCancel();
               }
            }
            else
            {
               if (objetoTrade.BuyLimit(mTradeVolume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  PrintFormat("Ordem Compra Limit enviada através do mouse.");
                  ModoKeyCancel();
               }
            }
         }
      }
      else if (gKeyDownMode == KEY_SELL)
      {
         if (!gIsOpen || gIsOpenSell)
         {
            if (gKeyDownPreco < ReturnBid())
            {
               if (objetoTrade.SellStop(mTradeVolume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  PrintFormat("Ordem de Venda Stop enviada através do mouse.");
                  ModoKeyCancel();
               }
            }
            else
            {
               if (objetoTrade.SellLimit(mTradeVolume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  PrintFormat("Ordem Venda Limit enviada através do mouse.");
                  ModoKeyCancel();
               }
            }
         }
      
      }
   }
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Check Orders Take Profit Limits                                  |
//+------------------------------------------------------------------+
bool CController::CheckOrdersTakeProfitLimits(void)
{
   bool result = true;
   
   int i = PositionsTotal()-1;
   
   while (i >= 0)
   {
      PositionGetSymbol(i);
      GetPositionProperties();
      
      if (pos_symbol == mSymbol)
      if (pos_magic == mTradeMagicNumber)
      {
         if (pos_type == POSITION_TYPE_BUY)
         {
            double vStop = 0;
            if (mStop > 0)
            {
               if (mSymbolPontosPips == Pips)
                  vStop = pos_price - (mStop*ReturnTradeTickSize());
               else
                  vStop = pos_price - mStop;
               
               vStop = ReturnPreco(vStop);
            }
            
            double vTP = 0;
            
            if (mTakeProfit > 0)
            {
               if (mSymbolPontosPips == Pips)
                  vTP = pos_price + (mTakeProfit*ReturnTradeTickSize());
               else
                  vTP = pos_price+ mTakeProfit;
               vTP = ReturnPreco(vTP);
            }
            SendOrdersTakeProfitLimits(pos_ticket,pos_price,pos_volume,0,vStop,vTP);
         }
         else if (pos_type == POSITION_TYPE_SELL)if (pos_type == POSITION_TYPE_BUY)
         {
            double vStop = 0;
            if (mStop > 0)
            {
               if (mSymbolPontosPips == Pips)
                  vStop = pos_price + (mStop*ReturnTradeTickSize());
               else
                  vStop = pos_price + mStop;
               
               vStop = ReturnPreco(vStop);
            }
            
            double vTP = 0;
            
            if (mTakeProfit > 0)
            {
               if (mSymbolPontosPips == Pips)
                  vTP = pos_price - (mTakeProfit*ReturnTradeTickSize());
               else
                  vTP = pos_price - mTakeProfit;
               vTP = ReturnPreco(vTP);
            }
            SendOrdersTakeProfitLimits(pos_ticket,pos_price,pos_volume,1,vStop,vTP);
         }
      
      }
      
      i--;
      
   }
   
   return true;
}
//+------------------------------------------------------------------+
//| Modo Key Cancel                                                  |
//+------------------------------------------------------------------+
void CController::ModoKeyCancel(void)
{
   gKeyDownMode = KEY_CANCEL;
   gKeyDownTime = 0;
   gKeyDownPreco = 0;
   objetoGUI.DeleteLinesInput();
   ChartRedraw(0);
}
//+------------------------------------------------------------------+
//| Refresh GUI                                                      |
//+------------------------------------------------------------------+
void CController::RefreshGUI(void)
{
   objetoGUI.oLabelSymbol2.Text(mSymbol);
   objetoGUI.oLabelMagic2.Text(IntegerToString(mTradeMagicNumber));
   objetoGUI.oLabelSpread2.Text(IntegerToString(ReturnSpread()));
   objetoGUI.oLabelVolumeAberto2.Text(DoubleToString(gVolumeOpen,2));
   objetoGUI.oLabelResultadoAberto2.Text(DoubleToString(gResultOpen,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
   objetoGUI.oLabelResultadoDiario2.Text(DoubleToString(gResultOpen+gResultDay,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
   objetoGUI.oLabelResultadoSemanal2.Text(DoubleToString(gResultOpen+gResultWeek,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
   objetoGUI.oLabelResultadoMensal2.Text(DoubleToString(gResultOpen+gResultMonth,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
   if (mCicloUse)
      objetoGUI.oLabelResultadoCiclo2.Text(DoubleToString(gResultOpen+gResultCiclo,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
   else
      objetoGUI.oLabelResultadoCiclo2.Text("-");
   objetoGUI.oBtnVender.Text(DoubleToString(ReturnBid(),_Digits));
   objetoGUI.oBtnComprar.Text(DoubleToString(ReturnAsk(),_Digits));
   objetoGUI.oLabelData.Text(objetoTimeTrade.ReturnDataTime()+" | "+objetoTimeTrade.ReturnCandleTime());
   
}
//+------------------------------------------------------------------+
//| Refresh GUIPosicoesOrdens                                        |
//+------------------------------------------------------------------+
void CController::RefreshGUIPosicoesOrdens(void)
{

   objetoGUI.DeleteLines();
   
   int i = PositionsTotal()-1;
   
   while (i >= 0)
   {
      PositionGetSymbol(i);
      GetPositionProperties();
      
      if (pos_symbol == mSymbol)
      if (pos_magic == mTradeMagicNumber)
      {
         if (pos_type == POSITION_TYPE_BUY)
            objetoGUI.CreateLine("positionBuy"+IntegerToString(pos_ticket),pos_price,objetoGUI.mCorPosicaoCompra,objetoGUI.mLinePosicao);
         else if (pos_type == POSITION_TYPE_SELL)
            objetoGUI.CreateLine("positionSell"+IntegerToString(pos_ticket),pos_price,objetoGUI.mCorPosicaoVenda,objetoGUI.mLinePosicao);
         if (pos_sl != 0)
            objetoGUI.CreateLine("positionStop"+IntegerToString(pos_ticket),pos_sl,objetoGUI.mCorStop,objetoGUI.mLinePosicao);
         if (pos_tp != 0)
            objetoGUI.CreateLine("positionTP"+IntegerToString(pos_ticket),pos_tp,objetoGUI.mCorTP,objetoGUI.mLinePosicao);
      }
      
      if (pos_symbol == mSymbol)
      if (pos_magic == mTradeMagicNumberLimit)
      {
         if (pos_tp != 0)
            objetoGUI.CreateLine("positionLimit"+IntegerToString(pos_ticket),pos_tp,objetoGUI.mCorTP,objetoGUI.mLinePosicao);
      }
      
      
      i--;   
   }
   
   int ord_total = OrdersTotal();
      
   if (ord_total > 0)
   {
      for (int i = ord_total-1; i>=0; i--)
      {
         ulong ticket = OrderGetTicket(i);
         
         if(OrderSelect(ticket))
         {
            if(OrderGetString(ORDER_SYMBOL) == mSymbol)
            {
               if(OrderGetInteger(ORDER_MAGIC) == mTradeMagicNumber)
               {
                  string msg = "C. - ";
                  if ( (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT) )
                     msg = "V. - ";
                    
                  msg = msg + DoubleToString(OrderGetDouble(ORDER_PRICE_OPEN),_Digits); 
                  
                  PrintFormat(OrderGetInteger(ORDER_TICKET));
                  
                  objetoGUI.CreateLine("order"+IntegerToString(OrderGetInteger(ORDER_TICKET)),OrderGetDouble(ORDER_PRICE_OPEN),objetoGUI.mCorOrdem,objetoGUI.mLineOrdem);
                  objetoGUI.CreateBoxInput("orderBOX"+IntegerToString(OrderGetInteger(ORDER_TICKET)),OrderGetDouble(ORDER_PRICE_OPEN),objetoGUI.mCorBox,objetoGUI.mCorBoxText,msg);
               }
               else if(OrderGetInteger(ORDER_MAGIC) == mTradeMagicNumberLimit)
               {
                  objetoGUI.CreateLine("order"+IntegerToString(OrderGetInteger(ORDER_TICKET)),OrderGetDouble(ORDER_PRICE_OPEN),objetoGUI.mCorTP,objetoGUI.mLinePosicao);
                  
               }
            }
            
          }
      }
    
   }
}
//+------------------------------------------------------------------+
//| Refresh Day                                                      |
//+------------------------------------------------------------------+
void CController::RefreshDay(void)
{
   if (ReturnIsNewBarDay())
   {
      RefreshResultDay();
      RefreshResultWeek();
      RefreshResultMonth();
   }
}
//+------------------------------------------------------------------+
//| Refresh Result Open                                              |
//+------------------------------------------------------------------+
void CController::RefreshResultOpen(bool vConferencia)
{
   
   bool isOpen = false;
   bool isOpenBuy = false;
   bool isOpenSell = false;
   
   int openCount = 0;
   int openCountBuy = 0;
   int openCountSell = 0;
   
   double resultOpen = 0;
   double resultOpenBuy = 0;
   double resultOpenSell = 0;
   
   double volumeOpen = 0;
   double volumeOpenBuy = 0;
   double volumeOpenSell = 0;
   
   double precoMedio = 0;
   double precoMedioBuy = 0;
   double precoMedioSell = 0;
   
   bool primeiraVez = true;
   double proximaEntradaAcima = 0;
   double proximaEntradaAbaixo = 0;
   
   bool isOpenLimit = false;
   int openCountLimit = 0;
   int orderCountLimit = 0;
   
   int countPositionNoTP = 0;
   
   CArrayList<ulong> listPositionsNoTP = new CArrayList<ulong>();
   
   int i = PositionsTotal()-1;
   
   while (i >= 0)
   {
      PositionGetSymbol(i);
      GetPositionProperties();
      
      if (pos_symbol == mSymbol)
      if (pos_magic == mTradeMagicNumber)
      {
         if (primeiraVez)
         {
            primeiraVez = false;
            proximaEntradaAcima = pos_price;
            proximaEntradaAbaixo = pos_price;
         }
         
         if (pos_price > proximaEntradaAcima)
            proximaEntradaAcima = pos_price;
         
         if (pos_price < proximaEntradaAbaixo)
            proximaEntradaAbaixo = pos_price;
         
         isOpen = true;
         openCount++;
         resultOpen = resultOpen + pos_profit + pos_swap;
         volumeOpen = volumeOpen + pos_volume;
         precoMedio = precoMedio + (pos_price * pos_volume);
         
         if (pos_type == POSITION_TYPE_BUY)
         {
            isOpenBuy = true;
            openCountBuy++;
            resultOpenBuy = resultOpenBuy + pos_profit + pos_swap;
            volumeOpenBuy = volumeOpenBuy + pos_volume;
            precoMedioBuy = precoMedioBuy + (pos_price * pos_volume);
         }
         else if (pos_type == POSITION_TYPE_SELL)
         {
            isOpenSell = true;
            openCountSell++;
            resultOpenSell = resultOpenSell + pos_profit + pos_swap;
            volumeOpenSell = volumeOpenSell + pos_volume;
            precoMedioSell = precoMedioSell + (pos_price * pos_volume);
         }
         
         if (pos_tp == 0 && mTakeProfitType == Mercado && mTakeProfit > 0)
         {
            PrintFormat("Há posições sem TP");
            countPositionNoTP++;
            if (vConferencia)
            {
               if (pos_type == POSITION_TYPE_BUY)
               {
                  double vStop = 0;
                  if (mStop > 0)
                  {
                     if (mSymbolPontosPips == Pips)
                        vStop = pos_price - (mStop*ReturnTradeTickSize());
                     else
                        vStop = pos_price - mStop;
                     
                     vStop = ReturnPreco(vStop);
                  }
                  
                  double vTP = 0;
                  
                  if (mTakeProfit > 0)
                  {
                     if (mSymbolPontosPips == Pips)
                        vTP = pos_price + (mTakeProfit*ReturnTradeTickSize());
                     else
                        vTP = pos_price + mTakeProfit;
                     vTP = ReturnPreco(vTP);
                  }
                  
                  if (objetoTrade.PositionModify(pos_ticket,vStop,vTP))
                  {
                     PrintFormat("Posição corrigida com sucesso - "+IntegerToString(pos_ticket));
                  }
                  else
                  {
                     PrintFormat("Erro ao corrigir a posição - "+IntegerToString(pos_ticket));
                  }
               }
               else if (pos_type == POSITION_TYPE_SELL)
               {
                  double vStop = 0;
                  if (mStop > 0)
                  {
                     if (mSymbolPontosPips == Pips)
                        vStop = pos_price + (mStop*ReturnTradeTickSize());
                     else
                        vStop = pos_price + mStop;
                     
                     vStop = ReturnPreco(vStop);
                  }
                  
                  double vTP = 0;
                  
                  if (mTakeProfit > 0)
                  {
                     if (mSymbolPontosPips == Pips)
                        vTP = pos_price - (mTakeProfit*ReturnTradeTickSize());
                     else
                        vTP = pos_price - mTakeProfit;
                     vTP = ReturnPreco(vTP);
                  }
                  if (objetoTrade.PositionModify(pos_ticket,vStop,vTP))
                  {
                     PrintFormat("Posição corrigida com sucesso - "+IntegerToString(pos_ticket));
                  }
                  else
                  {
                     PrintFormat("Erro ao corrigir a posição - "+IntegerToString(pos_ticket));
                  }
               }
               
            
            }
         }
      
      }
      
      if (pos_symbol == mSymbol)
      if (pos_magic == mTradeMagicNumberLimit)
      {
         isOpenLimit = true;
         openCountLimit++;
      }
   
      i--;
   }
   
   if(precoMedio > 0)
      precoMedio = precoMedio/volumeOpen;
   if (precoMedioBuy > 0)
      precoMedioBuy = precoMedioBuy/volumeOpenBuy;
   if (precoMedioSell > 0)
      precoMedioSell = precoMedioSell/volumeOpenSell;
      
   gIsOpen = isOpen;
   gIsOpenBuy = isOpenBuy;
   gIsOpenSell = isOpenSell;
   gIsOpenLimit = isOpenLimit;
   
   gOpenCount = openCount;
   gOpenCountBuy = openCountBuy;
   gOpenCountSell = openCountSell;
   
   gResultOpen = resultOpen;
   gResultOpenBuy = resultOpenBuy;
   gResultOpenSell = resultOpenSell;
   
   gVolumeOpen = volumeOpen;
   gVolumeOpenBuy = volumeOpenBuy;
   gVolumeOpenSell = volumeOpenSell;
   
   if (gIsOpen)
   {
      if (gIsOpenBuy)
         gOperacaoAberta = 0;
      else if (gIsOpenSell)
         gOperacaoAberta = 1;
      if (mSymbolPontosPips == Pips)
      {
         gProximaEntradaAcima = proximaEntradaAcima + (mTradeDistancia*ReturnTradeTickSize());
         gProximaEntradaAbaixo = proximaEntradaAbaixo - (mTradeDistancia*ReturnTradeTickSize());
      }
      else
      {
         gProximaEntradaAcima = proximaEntradaAcima + (mTradeDistancia);
         gProximaEntradaAbaixo = proximaEntradaAbaixo - (mTradeDistancia);
      }
   }   
   else
   {
      if (gOperacaoAberta != -1)
      {
         gProximaEntradaAcima = 0;
         gProximaEntradaAbaixo = 0;
      }
   }
   
   
   if (vConferencia)
   {
      if (mTakeProfitType == Limit)
      {
         int ordTotal = OrdersTotal();
         
         if (ordTotal > 0)
         {
            for (int i = ordTotal-1; i>=0; i--)
            {
               ulong ticket = OrderGetTicket(i);
               
               if (OrderSelect(ticket))
               {
                  if (OrderGetString(ORDER_SYMBOL) == mSymbol)
                  if (OrderGetInteger(ORDER_MAGIC) == mTradeMagicNumberLimit)
                  {
                     orderCountLimit++;
                  }
               
               }
            }
         }
         if (openCount == orderCountLimit)
         {
            PrintFormat("Quantidade de Ordens Limits estão corretas!");
         }
         else
         {
            if (openCount == orderCountLimit+openCountLimit)
            {
               PrintFormat("Quantide de Ordens Limits está aguardando Fechamento por Hedge.");
               CheckCloseLimit();
            }
            else
            {
               PrintFormat("Quantide de Ordens Limits está errada. Tentando corrigir.");
               if (SendDeleteByMagicNumber(-1,mTradeMagicNumberLimit))
               {
                  SleepTime(0.5);
                  if (CheckOrdersTakeProfitLimits())
                  {
                  
                  }
               }
               
            }
         }
      }
      else
      {
         if (countPositionNoTP > 0)
         {
            
         
         }
      }
   
   }
   
   
   
   
}
//+------------------------------------------------------------------+
//| Refresh Result Day                                               |
//+------------------------------------------------------------------+
void CController::RefreshResultDay(void)
{
   double result = 0;
   
   datetime start = iTime(NULL,PERIOD_D1,0);
   datetime end = TimeCurrent()+30;
   
   HistorySelect(start,end);
   
   int deals = HistoryDealsTotal()-1;
   
   while(deals>=0)
   {
      ulong deal_ticket = HistoryDealGetTicket(deals);
      
      if(HistoryDealGetInteger(deal_ticket,DEAL_MAGIC) == mTradeMagicNumber)
      {
         result = result + HistoryDealGetDouble(deal_ticket,DEAL_PROFIT) + HistoryDealGetDouble(deal_ticket,DEAL_SWAP);
         double custo = ReturnCusto(HistoryDealGetDouble(deal_ticket,DEAL_VOLUME));
         result = result - custo;
      }
      
      deals--;
   }
   
   gResultDay = result;
}
//+------------------------------------------------------------------+
//| Refresh Result Weel                                              |
//+------------------------------------------------------------------+
void CController::RefreshResultWeek(void)
{
   double result = 0;
   
   datetime start = iTime(NULL,PERIOD_W1,0);
   datetime end = TimeCurrent()+30;
   
   HistorySelect(start,end);
   
   int deals = HistoryDealsTotal()-1;
   
   while(deals>=0)
   {
      ulong deal_ticket = HistoryDealGetTicket(deals);
      
      if(HistoryDealGetInteger(deal_ticket,DEAL_MAGIC) == mTradeMagicNumber)
      {
         result = result + HistoryDealGetDouble(deal_ticket,DEAL_PROFIT) + HistoryDealGetDouble(deal_ticket,DEAL_SWAP);
         double custo = ReturnCusto(HistoryDealGetDouble(deal_ticket,DEAL_VOLUME));
         result = result - custo;
      }
      
      deals--;
   }
   
   gResultWeek = result;
}
//+------------------------------------------------------------------+
//| Refresh Result Month                                             |
//+------------------------------------------------------------------+
void CController::RefreshResultMonth(void)
{
   double result = 0;
   
   datetime start = iTime(NULL,PERIOD_MN1,0);
   datetime end = TimeCurrent()+30;
   
   HistorySelect(start,end);
   
   int deals = HistoryDealsTotal()-1;
   
   while(deals>=0)
   {
      ulong deal_ticket = HistoryDealGetTicket(deals);
      
      if(HistoryDealGetInteger(deal_ticket,DEAL_MAGIC) == mTradeMagicNumber)
      {
         result = result + HistoryDealGetDouble(deal_ticket,DEAL_PROFIT) + HistoryDealGetDouble(deal_ticket,DEAL_SWAP);
         double custo = ReturnCusto(HistoryDealGetDouble(deal_ticket,DEAL_VOLUME));
         result = result - custo;
      }
      
      deals--;
   }
   
   gResultMonth = result;
}
//+------------------------------------------------------------------+
//| Refresh Result Ciclo                                             |
//+------------------------------------------------------------------+
void CController::RefreshCiclo(void)
{
   if (mCicloUse)
   {
      double resultCiclo = 0;
      
      datetime dataInicial = mCicloDataInicial;
      datetime dataFinal = TimeCurrent()+30;
      
      HistorySelect(dataInicial,dataFinal);
      int deals = HistoryDealsTotal()-1;
      
      for (int i = 0; i <= deals; i++)
      {
         ulong dealTicket = HistoryDealGetTicket(i);
         
         if (HistoryDealGetInteger(dealTicket, DEAL_MAGIC) == mTradeMagicNumber)
         if (HistoryDealGetInteger(dealTicket, DEAL_TYPE) != 2)
         {
            if (resultCiclo <= mCicloLoss)
            {
               resultCiclo = 0;
            }
            else if (resultCiclo >= mCicloGain)
            {
               resultCiclo = 0;
            }
            
            resultCiclo = resultCiclo + HistoryDealGetDouble(dealTicket,DEAL_PROFIT) + HistoryDealGetDouble(dealTicket, DEAL_SWAP);
            double custo = ReturnCusto(HistoryDealGetDouble(dealTicket,DEAL_VOLUME));
            resultCiclo = resultCiclo - custo;
            
            if (resultCiclo <= mCicloLoss)
            {
               resultCiclo = 0;
            }
            else if (resultCiclo >= mCicloGain)
            {
               resultCiclo = 0;
            }
         }
      
      }
      
      gResultCiclo = resultCiclo;
   }
}
//+------------------------------------------------------------------+
//| Refresh Stop TP Type                                             |
//+------------------------------------------------------------------+
bool CController::RefreshStopTPType(int vType, double vStop, double vTP)
{
   ulong positionTicket = objetoTrade.ResultOrder(); 
   double positionPreco = objetoTrade.ResultPrice();
   double positionVolume = objetoTrade.ResultVolume();
   
   if (vType == 0)
   {
      double stop = 0;
      if (vStop > 0)
      {
         if (mSymbolPontosPips == Pips)
            stop = positionPreco - (vStop*ReturnTradeTickSize());
         else
            stop = positionPreco - vStop;
            
         
         stop = ReturnPreco(stop);
      }
      
      double tp = 0;
      if (vTP > 0)
      {
         if (mSymbolPontosPips == Pips)
            tp = positionPreco + (vTP*ReturnTradeTickSize());
         else
            tp = positionPreco + vTP;
            
         
         tp = ReturnPreco(tp);
      }
      if (mTakeProfitType == Mercado)
      {
         if (objetoTrade.PositionModify(positionTicket,stop,tp))
         {
            PrintFormat("Posição atualizada com sucesso - "+IntegerToString(positionTicket));
            return true;
         }
         else
         {
            PrintFormat("Erro ao atualizar a posição - "+IntegerToString(positionTicket));
            return false;
         }
      }
      else if (mTakeProfitType == Manual)
      {
         objetoTrade.PositionModify(positionTicket,stop,0);
        
         if (vTP > 0)
         {
            if (objetoTradeLimit.SellLimit(positionVolume,tp,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(positionTicket)))
            {
               PrintFormat("Posição atualizada com sucesso - "+IntegerToString(positionTicket));
               SleepTime(1);
               return true;
            }
            else
            {
               PrintFormat("Erro ao atualizar a posição - "+IntegerToString(positionTicket));
               return false;
            }
         }
      }
   }
   else if (vType == 1)
   {
      double stop = 0;
      if (vStop > 0)
      {
         if (mSymbolPontosPips == Pips)
            stop = positionPreco + (vStop*ReturnTradeTickSize());
         else
            stop = positionPreco + vStop;
            
         
         stop = ReturnPreco(stop);
      }
      
      double tp = 0;
      if (vTP > 0)
      {
         if (mSymbolPontosPips == Pips)
            tp = positionPreco - (vTP*ReturnTradeTickSize());
         else
            tp = positionPreco - vTP;
            
         
         tp = ReturnPreco(tp);
      }
      
      if (mTakeProfitType == Mercado)
      {
         if (objetoTrade.PositionModify(positionTicket,stop,tp))
         {
            PrintFormat("Posição atualizada com sucesso - "+IntegerToString(positionTicket));
            return true;
         }
         else
         {
            PrintFormat("Erro ao atualizar a posição - "+IntegerToString(positionTicket));
            return false;
         }
      }
      else if (mTakeProfitType == Manual)
      {
         objetoTrade.PositionModify(positionTicket,stop,0);
         if (vTP > 0)
         {
            if (objetoTradeLimit.BuyLimit(positionVolume,tp,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(positionTicket)))
            {
               PrintFormat("Posição atualizada com sucesso - "+IntegerToString(positionTicket));
               SleepTime(1);
               return true;
            }
            else
            {
               PrintFormat("Erro ao atualizar a posição - "+IntegerToString(positionTicket));
               return false;
            }
         }
      }
   }
   
   return false;
}
//+------------------------------------------------------------------+
//| Return Is New Bar                                                |
//+------------------------------------------------------------------+
bool CController::ReturnIsNewBar(void)
{
   //--- memorize the time of opening of the last bar in the static variable
   static datetime last_time=0;
   //--- current time
   datetime lastbar_time=(datetime)SeriesInfoInteger(mSymbolIndicador,PERIOD_CURRENT,SERIES_LASTBAR_DATE);
   
   
   if(last_time==0)
   {
      last_time=lastbar_time;
      return(false);
   }
   
   if(last_time!=lastbar_time)
   {
      last_time=lastbar_time;
      return(true);
   }
   
   return(false);
}
//+------------------------------------------------------------------+
//| Return Is New Bar Day                                            |
//+------------------------------------------------------------------+
bool CController::ReturnIsNewBarDay(void)
{
   //--- memorize the time of opening of the last bar in the static variable
   static datetime last_time=0;
   //--- current time
   datetime lastbar_time=(datetime)SeriesInfoInteger(mSymbol,PERIOD_D1,SERIES_LASTBAR_DATE);
   
   if(last_time==0)
   {
      last_time=lastbar_time;
      return(true);
   }
   
   if(last_time!=lastbar_time)
   {
      last_time=lastbar_time;
      return(true);
   }
   
   return(false);
}
//+------------------------------------------------------------------+
//| Return Preço                                                     |
//+------------------------------------------------------------------+
double CController::ReturnPreco(double vPreco)
{
   double result = 0;
   
   double t          =  SymbolInfoDouble(mSymbol,SYMBOL_TRADE_TICK_SIZE);
   int divisivel     =  NormalizeDouble(vPreco,(int)SymbolInfoInteger(mSymbol,SYMBOL_DIGITS))/(double)SymbolInfoDouble(mSymbol,SYMBOL_TRADE_TICK_SIZE);
   result            =  divisivel*SymbolInfoDouble(mSymbol,SYMBOL_TRADE_TICK_SIZE);
   
   return NormalizeDouble(result,_Digits);

}
//+------------------------------------------------------------------+
//| Return Custo                                                     |
//+------------------------------------------------------------------+
double CController::ReturnCusto(double vVolume)
{
   double result = 0;
   
   if (mSymbolTypeCusto == PorContrato)
   {
      return (vVolume*mSymbolCusto);
   }
   else if (mSymbolTypeCusto == PorOperacao)
   {
      return mSymbolCusto;
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Send Close                                                       |
//+------------------------------------------------------------------+
bool CController::SendClose(int vType)
{
   bool result = true;
   
   
   int count = 0; 
   bool fechou = false;
   
   PrintFormat("Fechar posições");
   
   while(!fechou)
   {
      fechou = true;
      int i = PositionsTotal()-1;
      
      while(i>=0)
      {
         PositionGetSymbol(i);
         GetPositionProperties();
         
         if(pos_symbol == mSymbol)
         if(pos_magic == mTradeMagicNumber)
         {
            if (  (pos_type == POSITION_TYPE_BUY && vType == 0) ||
                  (pos_type == POSITION_TYPE_SELL && vType == 1) ||
                  (vType == -1)
               )
            {
               if(objetoTrade.PositionClose(pos_ticket))
               {
                  PrintFormat("Erro ao fechar posição: "+IntegerToString(pos_ticket));
                  fechou = false;
               }
               else
               {
                  PrintFormat("Posição encerrada com sucesso: "+IntegerToString(pos_ticket));
               }
            }
         }
      
         i--;
      }
      
      count++;
      if(count>=100)
         return false;
   
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Send Delete                                                      |
//+------------------------------------------------------------------+
bool CController::SendDelete(int vType)
{
   bool result = true;
   
   bool fechou = false;
   int count = 0;
   
   PrintFormat("Deletar Ordens");
   
   while(!fechou)
   {
      int ord_total = OrdersTotal();
      fechou = true;
      
      if (ord_total > 0)
      {
         for (int i = ord_total-1; i>=0; i--)
         {
            ulong ticket = OrderGetTicket(i);
            
            if(OrderSelect(ticket))
            {
               if(OrderGetString(ORDER_SYMBOL) == mSymbol)
               if(OrderGetInteger(ORDER_MAGIC) == mTradeMagicNumber || OrderGetInteger(ORDER_MAGIC) == mTradeMagicNumberLimit)
               {
                  if (vType == 0 && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_LIMIT)) 
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        PrintFormat("Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                        fechou = false;
                     }
                     else
                     {
                        PrintFormat("Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                     }
                  }
                  
                  
                  if (vType == 1 && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT)) 
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        PrintFormat("Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                        fechou = false; 
                     }
                     else
                     {
                        PrintFormat("Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                     }
                  }
                  
                  
                  if (vType == -1)
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        PrintFormat("Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                        fechou = false; 
                     }
                     else
                     {
                        PrintFormat("Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                     }
                  }
                  
                  
               }
            }
         
         }
      }
      
      count++;
      if(count>=100)
         fechou = true;
      
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Send Delete By Magic Number                                      |
//+------------------------------------------------------------------+
bool CController::SendDeleteByMagicNumber(int vType, int vMagicNumber)
{
   bool result = true;
   
   bool fechou = false;
   int count = 0;
   
   PrintFormat("Deletar Ordens");
   
   while(!fechou)
   {
      int ord_total = OrdersTotal();
      fechou = true;
      
      if (ord_total > 0)
      {
         for (int i = ord_total-1; i>=0; i--)
         {
            ulong ticket = OrderGetTicket(i);
            
            if(OrderSelect(ticket))
            {
               if(OrderGetString(ORDER_SYMBOL) == mSymbol)
               if(OrderGetInteger(ORDER_MAGIC) == vMagicNumber)
               {
                  if (vType == 0 && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_LIMIT)) 
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        PrintFormat("Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                        fechou = false;
                     }
                     else
                     {
                        PrintFormat("Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                     }
                  }
                  
                  
                  if (vType == 1 && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT)) 
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        PrintFormat("Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                        fechou = false; 
                     }
                     else
                     {
                        PrintFormat("Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                     }
                  }
                  
                  
                  if (vType == -1)
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        PrintFormat("Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                        fechou = false; 
                     }
                     else
                     {
                        PrintFormat("Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)));
                     }
                  }
                  
                  
               }
            }
         
         }
      }
      
      count++;
      if(count>=100)
         fechou = true;
      
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Send Delete                                                      |
//+------------------------------------------------------------------+
bool CController::SendDeleteByTicket(ulong vTicket)
{
   bool result = true;
   
   if (objetoTrade.OrderDelete(vTicket))
   {
      PrintFormat("Ordem deletada com sucesso - "+vTicket);
   }
   else
   {
      PrintFormat("Erro deletada a ordem - "+vTicket);
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Send Buy                                                         |
//+------------------------------------------------------------------+
bool CController::SendBuy(double vVolume,double vStop,double vTP)
{
   double stop = 0;
   if (vStop > 0)
   {
      if (mSymbolPontosPips == Pips)
         stop = ReturnAsk() - (vStop*ReturnTradeTickSize());
      else
         stop = ReturnAsk() - vStop;
   }
      
   double tp = 0;
   
   if (objetoTrade.Buy(vVolume,mSymbol,ReturnAsk(),stop,0,mTradeComentario))
   {
      PrintFormat("Compra Realizada com Sucesso");
      
      SleepTime(2);
      if(!RefreshStopTPType(0,vStop,vTP))
      {
         SleepTime(1);
         RefreshStopTPType(0,vStop,vTP);
      }
      
      return true;
   }
   else
   {
      PrintFormat("Primeira tentativa de Compra não realizada");
      if (stop > 0)
         stop = ReturnPreco(stop);
         
      SleepTime(1);  
         
      if (objetoTrade.Buy(vVolume,mSymbol,ReturnAsk(),stop,0,mTradeComentario))
      {
         PrintFormat("Compra Realizada com Sucesso");
         SleepTime(2);
         if(!RefreshStopTPType(0,vStop,vTP))
         {
            SleepTime(1);
            RefreshStopTPType(0,vStop,vTP);
         }
         return true;
         
      }
      else
      {
         PrintFormat("Segunda tentativa de Compra não realizada");
         SleepTime(1);  
         return false;
      }
   }
   
}
//+------------------------------------------------------------------+
//| Send Sell                                                        |
//+------------------------------------------------------------------+
bool CController::SendSell(double vVolume,double vStop,double vTP)
{
   double stop = 0;
   if (vStop > 0)
   {
      if (mSymbolPontosPips == Pips)
         stop = ReturnBid() + (vStop*ReturnTradeTickSize());
      else
         stop = ReturnBid() + vStop;
   }
      
   double tp = 0;
   if (vTP > 0)
   {
      if (mSymbolPontosPips == Pips)
         tp = ReturnBid() - (vTP*ReturnTradeTickSize());
      else
         tp = ReturnBid() - vTP;
   }
   
   
   if (objetoTrade.Sell(vVolume,mSymbol,ReturnBid(),stop,0,mTradeComentario))
   {
      PrintFormat("Venda Realizada com Sucesso");
      SleepTime(2);
      if(!RefreshStopTPType(1,vStop,vTP))
      {
         SleepTime(1);
         RefreshStopTPType(1,vStop,vTP);
      }
      return true;
   }
   else
   {
      PrintFormat("Primeira tentativa de Venda não realizada");
      if (stop > 0)
         stop = ReturnPreco(stop);
         
      if (tp > 0)
         tp = ReturnPreco(tp);
         
      
      SleepTime(1);  
         
      if (objetoTrade.Sell(vVolume,mSymbol,ReturnBid(),stop,0,mTradeComentario))
      {
         PrintFormat("Venda Realizada com Sucesso");
         SleepTime(2);
         if(!RefreshStopTPType(1,vStop,vTP))
         {
            SleepTime(1);
            RefreshStopTPType(1,vStop,vTP);
         }  
         return true;
      }
      else
      {
         PrintFormat("Segunda tentativa de Venda não realizada");
         SleepTime(1);  
         return false;
      }
   }
   
}
//+------------------------------------------------------------------+
//| Send Orders Take Profit Limits                                   |
//+------------------------------------------------------------------+
bool CController::SendOrdersTakeProfitLimits(ulong vTicket, double vPreco, double vVolume, int vType,double vStop,double vTP)
{
   bool result = true;
  
   if (mTakeProfitType == Limit)
   {
      if (vType == 0)
      {
         objetoTrade.PositionModify(vTicket,vStop,0);
         
         if (vTP > 0)
         {
            if (objetoTradeLimit.SellLimit(vVolume,vTP,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(vTicket)))
            {
               PrintFormat("Posição atualizada com sucesso - "+IntegerToString(vTicket));
               SleepTime(0.2);
               return true;
            }
            else
            {
               PrintFormat("Erro ao atualizar a posição - "+IntegerToString(vTicket));
               return false;
            }
         
         }
      }
      else if (vType == 1)
      {
         objetoTrade.PositionModify(vTicket,vStop,0);
         
         if (vTP > 0)
         {
            if (objetoTradeLimit.BuyLimit(vVolume,vTP,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(vTicket)))
            {
               PrintFormat("Posição atualizada com sucesso - "+IntegerToString(vTicket));
               SleepTime(0.2);
               return true;
            }
            else
            {
               PrintFormat("Erro ao atualizar a posição - "+IntegerToString(vTicket));
               return false;
            }
         
         }
      }
   }
  
   return result;
}
//+------------------------------------------------------------------+
//| Sleep Time                                                       |
//+------------------------------------------------------------------+
void CController::SleepTime(double vSegundos)
{
   if (!MQLInfoInteger(MQL_TESTER))
   {
      datetime _time_waiting = TimeLocal () + vSegundos;
      PrintFormat("Aguardando Time");
      while ( TimeLocal () < _time_waiting )
      { 
         
      }
      PrintFormat("Time Finalizado");
   }
   
}
//+------------------------------------------------------------------+
//| Position Properties                                              |
//+------------------------------------------------------------------+
long                 pos_magic=0;         // Magic number
string               pos_symbol="";       // Symbol
string               pos_comment="";      // Comment
double               pos_swap=0.0;        // Swap
double               pos_commission=0.0;  // Commission
double               pos_price=0.0;       // Current price of the position
double               pos_cprice=0.0;      // Current price of the position
double               pos_profit=0.0;      // Profit/Loss of the position
double               pos_volume=0.0;      // Position volume
double               pos_sl=0.0;          // Stop Loss of the position
double               pos_tp=0.0;          // Take Profit of the position
datetime             pos_time=NULL;       // Position opening time
ulong                pos_id=0;            // Position identifier
ulong                pos_ticket=0;  
ENUM_POSITION_TYPE   pos_type=NULL;       // Position type
//+------------------------------------------------------------------+
//| Get Position Properties                                          |
//+------------------------------------------------------------------+
void GetPositionProperties()
{
   pos_symbol     =PositionGetString(POSITION_SYMBOL);
   pos_comment    =PositionGetString(POSITION_COMMENT);
   pos_magic      =PositionGetInteger(POSITION_MAGIC);
   pos_price      =PositionGetDouble(POSITION_PRICE_OPEN);
   pos_cprice     =PositionGetDouble(POSITION_PRICE_CURRENT);
   pos_sl         =PositionGetDouble(POSITION_SL);
   pos_tp         =PositionGetDouble(POSITION_TP);
   pos_type       =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
   pos_volume     =PositionGetDouble(POSITION_VOLUME);
   pos_commission =PositionGetDouble(POSITION_COMMISSION);
   pos_swap       =PositionGetDouble(POSITION_SWAP);
   pos_profit     =PositionGetDouble(POSITION_PROFIT);
   pos_time       =(datetime)PositionGetInteger(POSITION_TIME);
   pos_id         =PositionGetInteger(POSITION_IDENTIFIER);
   pos_ticket     =PositionGetInteger(POSITION_TICKET);
}
//+------------------------------------------------------------------+
