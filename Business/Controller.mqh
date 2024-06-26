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
#include                <../Experts/RB Investe/Lion/Model/Indicador.mqh>
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
enum typePreco
{
   PrecoPosicao,        // Por Posição
   PrecoMedio,          // Preço Médio
};
enum typeGainLoss
{
   Robo,                // Por Robô
   Conta,               // Por Conta
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
      CIndicador           listIndicador[3];
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
      
      bool                 mSleepUse;
      int                  mSleepLoss;
      int                  mSleepGain;
      
      typeAutomaticoManual mTradeAutomaticoManual;
      typeNormalReverso    mTradeNormalReverso;
      bool                 mTradeCloseNoOpen;
      long                 mTradeMagicNumber;
      long                 mTradeMagicNumberLimit;
      string               mTradeComentario;
      double               mTradeVolume;
      double               mTradeVolumeMaximo;
      double               mTradeDistancia;
      bool                 mTradeDistanciaTendencia;
      
      bool                 mTradeVolumeDiferenteUse;
      double               mTradeVolumeDiferente[];
      bool                 mTradeDistanciaDiferenteUse;
      double               mTradeDistanciaDiferente[];
      bool                 mTradeTakeDiferenteUse;
      double               mTradeTakeDiferente[];
      
      typePreco            mStopTypePreco;
      double               mStop;
      
      typePreco            mTakeProfitTypePreco;
      double               mTakeProfit;
      typeTP               mTakeProfitType;
      
      bool                 mBreakEvenUse;
      typePreco            mBreakEvenTypePreco;
      double               mBreakEvenTrigger;
      double               mBreakEvenStop;
      
      bool                 mTrailingStopUse;
      typePreco            mTrailingStopTypePreco;
      double               mTrailingStopTrigger;
      double               mTrailingStopStop;
      double               mTrailingStopAtualizacao;
      
      double               mLossPosition;
      typeGainLoss         mLossType;
      double               mLossDay;
      double               mLossWeek;
      double               mLossMonth;
      
      double               mGainPosition;
      typeGainLoss         mGainType;
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
      
      double               gResultOpenConta;
      double               gResultDayConta;
      double               gResultWeekConta;
      double               gResultMonthConta;
      double               gResultCicloConta;
      
      int                  gOperacaoAberta;
      
      double               gProximaEntradaAcima;
      double               gProximaEntradaAbaixo;
      
      int                  gKeyDownMode;
      datetime             gKeyDownTime;
      datetime             gKeyDownTimeLimit;
      double               gKeyDownPreco;
      
      string               gInfo;
      
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
      bool                 CheckCloseTime();
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
      void                 RefreshIndicadores();
      // Returns
      double               ReturnStop();
      double               ReturnTakeProfit(int vIndex);
      double               ReturnVolume();
      double               ReturnDistancia();
      double               ReturnBreakEvenTrigger();
      double               ReturnBreakEvenStop();
      double               ReturnTrailingStopTrigger();
      double               ReturnTrailingStopStop();
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
      void                 SendMessage(string &vMsg[]);
      
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
         string msg[] = { "Click no Botão Comprar" };
         SendMessage(msg);
         CheckPosicaoInicial(0);
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnVender.Name())
      {
         string msg[] = { "Click no Botão Vender" };
         SendMessage(msg);
         CheckPosicaoInicial(1);
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnZerar.Name())
      {
         string msg[] = { "Click no Botão Zerar" };
         SendMessage(msg);
         if (SendClose(-1))
         {
            SendDelete(-1);
            gOperacaoAberta = -1;
         }
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnCancelar.Name())
      {
         string msg[] = { "Click no Botão Cancelar" };
         SendMessage(msg);
         SendDelete(-1);
         ChartRedraw(0);
      }
      else if (sparam == objetoGUI.oBtnInverter.Name())
      {
         string msg[] = { "Click no Botão Inverter" };
         SendMessage(msg);
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
   else if (id == CHARTEVENT_CHART_CHANGE)
   {
      RefreshGUIPosicoesOrdens();
   }
}
//+------------------------------------------------------------------+
//| Check New Position                                               |
//+------------------------------------------------------------------+
bool CController::CheckPosicaoInicial(int vType)
{
   if (mTradeAutomaticoManual == Automatico)
   {
      if (objetoTimeTrade.ReturnTimeTrade())
      if (gIsNewBar)
      if (!gIsOpen)
      if (CheckLossGainAbrirNovasPosicoes())
      if ( (mSymbolSpread == 0) || (ReturnSpread() <= mSymbolSpread) )
      {
         double volume        =  ReturnVolume();
         double stop          =  ReturnStop();
         double takeprofit    =  ReturnTakeProfit(0);
         int countBuy         =  0;
         int countSell        =  0;
         for (int i = 0; i < listIndicador.Size(); i++)
         {
            if (listIndicador[i].mUse)
            {
               if (listIndicador[i].ReturnResultadoIndicador() == 0)
                  countBuy++;
               if (listIndicador[i].ReturnResultadoIndicador() == 1)
                  countSell++;
            }
         }
         
         if (mSymbolCompraVenda == Compra || mSymbolCompraVenda == CompraVenda)
         if (countBuy >= 2)
         {
            if (SendBuy(volume, stop, takeprofit))
            {
               gOperacaoAberta = 0;
               gProximaEntradaAcima = -1;
               gProximaEntradaAbaixo = -1;
               return true;
            }
         }
         
         if (mSymbolCompraVenda == Venda || mSymbolCompraVenda == CompraVenda)
         {
            if (countSell >= 2)
            {
               if (SendSell(volume, stop, takeprofit))
               {
                  gOperacaoAberta = 1;
                  gProximaEntradaAcima = -1;
                  gProximaEntradaAbaixo = -1;
                  return true;
               }
            }
         }
      
      }
   
   }
   else if (mTradeAutomaticoManual == Manual)
   {
      if (objetoTimeTrade.ReturnTimeTrade())
      if (!gIsOpen)
      if (CheckLossGainAbrirNovasPosicoes())
      if ( (mSymbolSpread == 0) || (ReturnSpread() <= mSymbolSpread) )
      {
         double volume        =  ReturnVolume();
         double stop          =  ReturnStop();
         double takeprofit    =  ReturnTakeProfit(0);
         
         if (vType == 0)
         {
            
            if (mSymbolCompraVenda == Compra || mSymbolCompraVenda == CompraVenda)
            if (SendBuy(volume, stop, takeprofit))
            {
               gOperacaoAberta = 0;
               gProximaEntradaAcima = -1;
               gProximaEntradaAbaixo = -1;
               return true;
            }
         
         }
         else if (vType == 1)
         {
            if (mSymbolCompraVenda == Venda || mSymbolCompraVenda == CompraVenda)
            if (SendSell(volume, stop, takeprofit))
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
         if ( (gProximaEntradaAbaixo > 0 || gProximaEntradaAcima > 0) )
         {
            if ( (ReturnAsk() >= gProximaEntradaAcima && gProximaEntradaAcima > 0) || ( ReturnAsk() <= gProximaEntradaAbaixo && gProximaEntradaAbaixo > 0) )
            {
               double volume        =  ReturnVolume();
               double stop          =  ReturnStop();
               double takeprofit    =  ReturnTakeProfit(gOpenCount);
               if (SendBuy(volume,stop,takeprofit))
               {
                  gProximaEntradaAbaixo = -1;
                  gProximaEntradaAcima = -1;
                  return true;
               }
            
            }
         }
         if (gProximaEntradaAbaixo == 0 && gProximaEntradaAcima == 0)
         {
            if (!gIsOpen)
            {
               double volume        =  ReturnVolume();
               double stop          =  ReturnStop();
               double takeprofit    =  ReturnTakeProfit(gOpenCount);
               if (SendBuy(volume,stop,takeprofit))
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
         if ( (gProximaEntradaAbaixo > 0 || gProximaEntradaAcima > 0) )
         {
            if ( (ReturnBid() >= gProximaEntradaAcima && gProximaEntradaAcima > 0) || ( ReturnBid() <= gProximaEntradaAbaixo && gProximaEntradaAbaixo > 0) )
            {
               double volume        =  ReturnVolume();
               double stop          =  ReturnStop();
               double takeprofit    =  ReturnTakeProfit(gOpenCount);
               if (SendSell(volume,stop,takeprofit))
               {
                  gProximaEntradaAbaixo = -1;
                  gProximaEntradaAcima = -1;
                  return true;
               }
            
            }
         }
         
         if (gProximaEntradaAbaixo == 0 && gProximaEntradaAcima == 0)
         {
            if (!gIsOpen)
            {
               double volume        =  ReturnVolume();
               double stop          =  ReturnStop();
               double takeprofit    =  ReturnTakeProfit(gOpenCount);
               if (SendSell(volume,stop,takeprofit))
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
                  double stop          =  ReturnStop();
                  double takeprofit    =  ReturnTakeProfit(0);
                  
                  if (SendSell(volume,stop,takeprofit))
                  {
                     gOperacaoAberta = 1;
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
                  double stop          =  ReturnStop();
                  double takeprofit    =  ReturnTakeProfit(0);
                  if (SendBuy(volume,stop,takeprofit))
                  {
                     gOperacaoAberta = 0;
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
            if ( (mSymbolSpread == 0) || (ReturnSpread() <= mSymbolSpread) )
            {
               int countBuy         =  0;
               int countSell        =  0;
               for (int i = 0; i < listIndicador.Size(); i++)
               {
                  if (listIndicador[i].mUse)
                  {
                     if (listIndicador[i].ReturnResultadoIndicador() == 0)
                        countBuy++;
                     if (listIndicador[i].ReturnResultadoIndicador() == 1)
                        countSell++;
                  }
               }
               
               if (countBuy >= 2 && !gIsOpenBuy && gIsOpenSell)
               {
                  if (mSymbolCompraVenda == Compra || mSymbolCompraVenda == CompraVenda)
                  {
                     double volume = gVolumeOpenSell;
                     if (SendClose(-1))
                     {
                        SendDelete(-1);
                        double stop          =  ReturnStop();
                        double takeprofit    =  ReturnTakeProfit(0);
                        if (SendBuy(volume,stop,takeprofit))
                        {
                           gOperacaoAberta = 0;
                           gProximaEntradaAbaixo = -1;
                           gProximaEntradaAcima = -1;
                           return true;
                        }
                     }
                  }
                  else
                  {
                     if (SendClose(-1))
                     {
                        SendDelete(-1);
                        gOperacaoAberta = -1;
                        gProximaEntradaAbaixo = -1;
                        gProximaEntradaAcima = -1;
                        return true;
                     }
                  }
               }
               
               if (countSell >= 2 && gIsOpenBuy && !gIsOpenSell)
               {
                  if (mSymbolCompraVenda == Venda || mSymbolCompraVenda == CompraVenda)
                  {
                     double volume = gVolumeOpenBuy;
                     if (SendClose(-1))
                     {
                        SendDelete(-1);
                        double stop          =  ReturnStop();
                        double takeprofit    =  ReturnTakeProfit(0);
                        if (SendSell(volume,stop,takeprofit))
                        {
                           gOperacaoAberta = 1;
                           gProximaEntradaAbaixo = -1;
                           gProximaEntradaAcima = -1;
                           return true;
                        }
                     }
                  }
                  else
                  {
                     if (SendClose(-1))
                     {
                        SendDelete(-1);
                        gOperacaoAberta = -1;
                        gProximaEntradaAbaixo = -1;
                        gProximaEntradaAcima = -1;
                        return true;
                     }
                  }
               }
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
      if (mLossType == Robo)
      {
         if (mLossPosition < 0)
         if (gResultOpen <= mLossPosition)
         {
            
            string msg[] = { "Prejuízo máximo da posição atingido: "+DoubleToString(gResultOpen,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if (mLossDay < 0)
         if (gResultOpen + gResultDay <= mLossDay)
         {
            string msg[] = { "Prejuízo máximo diário atingido: "+DoubleToString(gResultOpen+gResultDay,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if (mLossWeek < 0)
         if (gResultOpen + gResultWeek <= mLossWeek)
         {
            string msg[] = { "Prejuízo máximo semanal atingido: "+DoubleToString(gResultOpen+gResultWeek,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if (mLossMonth < 0)
         if (gResultOpen + gResultMonth <= mLossMonth)
         {
            string msg[] = { "Prejuízo máximo mensal atingido: "+DoubleToString(gResultOpen+gResultMonth,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
      }
      else if (mLossType == Conta)
      {
      
      }
      
      if (mGainType == Robo)
      {
         if (mGainPosition > 0)
         if (gResultOpen >= mGainPosition*1.05)
         {
            string msg[] = { "Lucro máximo da posição atingido: "+DoubleToString(gResultOpen,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if (mGainDay > 0)
         if (gResultOpen + gResultDay >= mGainDay*1.05)
         {
            string msg[] = { "Lucro máximo do dia atingido: "+DoubleToString(gResultOpen+gResultDay,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if (mGainWeek > 0)
         if (gResultOpen + gResultWeek >= mGainWeek*1.05)
         {
            string msg[] = { "Lucro máximo da semana atingido: "+DoubleToString(gResultOpen+gResultWeek,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if (mGainMonth > 0)
         if (gResultOpen + gResultWeek >= mGainMonth*1.05)
         {
            string msg[] = { "Lucro máximo da semana atingido: "+DoubleToString(gResultOpen+gResultMonth,2), "Fechando todas as posições" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
      }
      else if (mGainType == Conta)
      {
      
      
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
      if (mLossType == Robo)
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
      }
      else if (mLossType == Conta)
      {
      
      }
      
      
      if (mGainType == Robo)
      {
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
      else if (mGainType == Conta)
      {
      
      }
         
      
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
            string msg[] = { "Encerramento de posição através da perda máxima do Ciclo" };
            SendMessage(msg);
            if (SendClose(-1))
            {
               SendDelete(-1);
               gOperacaoAberta = -1;
            }
         }
         
         if ( (gResultCiclo + gResultOpen >= mCicloGain*1.05) )
         {
            string msg[] = { "Encerramento de posição através do ganho máximo do Ciclo" };
            SendMessage(msg);
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
      if (mTakeProfitTypePreco == PrecoPosicao)
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
               string msg[] = { "Close Limit: "+IntegerToString(ticketLimit), "Close Position: "+IntegerToString(ticketPosition) };
               SendMessage(msg);
               
               if (objetoTrade.PositionCloseBy(ticketPosition,ticketLimit))
               {
                  string msg[] = { "Posições opostas encerradas com sucesso!" };
                  SendMessage(msg);
                  SleepTime(1);
                  return true;
               }
               else
               {
                  string msg[] = { "Erro ao encerrar posições opostas." };
                  SendMessage(msg);
                  SleepTime(1);
                  return false;
               }
               
            }
            i--;
         }
      }
      else if (mTakeProfitTypePreco == PrecoMedio)
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
               break;
            }
            i--;
         }
         
         int count = 0;
         bool fechou = false;
         
         while(!fechou)
         {
            fechou = true;
            
            i = PositionsTotal()-1;
         
            while (i >= 0)
            {
            
               PositionGetSymbol(i);
               GetPositionProperties();
               
               if (pos_symbol == mSymbol)
               if (pos_magic == mTradeMagicNumber)
               {
                  ticketPosition = pos_ticket;
                  if (objetoTrade.PositionCloseBy(ticketPosition,ticketLimit))
                  {
                     string msg[] = { "Posições opostas encerradas com sucesso!" };
                     SendMessage(msg);
                     SleepTime(0.3);
                  }
                  else
                  {
                     string msg[] = { "Erro ao encerrar posições opostas." };
                     SendMessage(msg);
                     SleepTime(0.3);
                     fechou = false;
                  }
               }
               i--;
            }
            
            count++;
            if(count>=100)
               fechou = true;
            
         }
         
         
      }
      
   
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Check Close Time                                                 |
//+------------------------------------------------------------------+
bool CController::CheckCloseTime(void)
{
   bool result = true;
   
   if (objetoTimeTrade.ReturnTimeTradeClose())
   if (gIsOpen)
   {
      if (SendClose(-1))
      {
         SendDelete(-1);
         gOperacaoAberta = -1;
         SleepTime(1);
      }
   }
   
   return true;
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
               double volume = ReturnVolume();
               
               if (objetoTrade.BuyStop(volume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  string msg[] = { "Ordem Compra Stop enviada através do mouse." };
                  SendMessage(msg);
                  ModoKeyCancel();
               }
            }
            else
            {
               double volume = ReturnVolume();
               if (objetoTrade.BuyLimit(volume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  string msg[] = { "Ordem Compra Limit enviada através do mouse." };
                  SendMessage(msg);
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
               double volume = ReturnVolume();
               if (objetoTrade.SellStop(volume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  string msg[] = { "Ordem de Venda Stop enviada através do mouse." };
                  SendMessage(msg);
                  ModoKeyCancel();
               }
            }
            else
            {
               double volume = ReturnVolume();
               if (objetoTrade.SellLimit(volume,gKeyDownPreco,mSymbol,0,0,ORDER_TIME_GTC,0,mTradeComentario))
               {
                  string msg[] = { "Ordem Venda Limit enviada através do mouse." };
                  SendMessage(msg);
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
   int count = gOpenCount;
   
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
            if (ReturnStop() > 0)
            {
               vStop = pos_price - ReturnStop();
               vStop = ReturnPreco(vStop);
            }
            
            double vTP = 0;
            
            if (ReturnTakeProfit(count) > 0)
            {
               vTP = pos_price+ ReturnTakeProfit(count);
               vTP = ReturnPreco(vTP);
            }
            SendOrdersTakeProfitLimits(pos_ticket,pos_price,pos_volume,0,vStop,vTP);
         }
         else if (pos_type == POSITION_TYPE_SELL)
         {
            double vStop = 0;
            if (ReturnStop() > 0)
            {
               vStop = pos_price + ReturnStop();
               vStop = ReturnPreco(vStop);
            }
            
            double vTP = 0;
            
            if (ReturnTakeProfit(count) > 0)
            {
               vTP = pos_price - ReturnTakeProfit(count);
               vTP = ReturnPreco(vTP);
            }
            SendOrdersTakeProfitLimits(pos_ticket,pos_price,pos_volume,1,vStop,vTP);
         }
         count--;
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
   objetoGUI.DeleteLinesInput();
   objetoGUI.DeleteLinesPrecoMedio();
   
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
   
   if (mStopTypePreco == PrecoMedio || mTakeProfitTypePreco == PrecoMedio)
   {
      if (gIsOpen)
         objetoGUI.CreateLine("precoMedio",gPrecoMedio,objetoGUI.mCorLinePrecoMedio,objetoGUI.mLinePrecoMedio);
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
   
   int countStopZero = 0;
   int countTPZero = 0;
   
   bool primeiraVez = true;
   double proximaEntradaAcima = 0;
   double proximaEntradaAbaixo = 0;
   
   bool isOpenLimit = false;
   double volumeOpenLimit = 0;
   
   
   int openCountLimit = 0;
   int orderCountLimit = 0;
   
   int countPositionNoTP = 0;
   
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
            
            if (mBreakEvenUse && mBreakEvenTypePreco == PrecoPosicao)
            {
               if (ReturnAsk() >= pos_price + ReturnBreakEvenTrigger())
               {
                  double novoStop = pos_price + ReturnBreakEvenStop();
                  novoStop = ReturnPreco(novoStop);
                  
                  if (novoStop > pos_sl)
                     if (!objetoTrade.PositionModify(pos_ticket,novoStop,pos_tp))
                     {
                        string msg[] = { " Erro ao atualizar o BreakEven Por Posição - "+IntegerToString(pos_ticket) };
                        SendMessage(msg);
                     }
               
               }
            }
            
            if (mTrailingStopUse && mTrailingStopTypePreco == PrecoPosicao)
            {
               if (ReturnAsk() >= pos_price + ReturnTrailingStopTrigger())
               {
                  double novoStop = pos_price + ReturnTrailingStopStop();
                  double diferenca = ReturnAsk() - (pos_price + ReturnTrailingStopTrigger());
                  diferenca = diferenca*mTrailingStopAtualizacao;
                  
                  novoStop = novoStop + diferenca;
                  novoStop = ReturnPreco(novoStop);
                  
                  if (novoStop > pos_sl)
                     if (!objetoTrade.PositionModify(pos_ticket,novoStop,pos_tp))
                     {
                        string msg[] = { " Erro ao atualizar o Trailing Stop Por Posição - "+IntegerToString(pos_ticket) };
                        SendMessage(msg);
                     }
               }
            
            }
            
         }
         else if (pos_type == POSITION_TYPE_SELL)
         {
            isOpenSell = true;
            openCountSell++;
            resultOpenSell = resultOpenSell + pos_profit + pos_swap;
            volumeOpenSell = volumeOpenSell + pos_volume;
            precoMedioSell = precoMedioSell + (pos_price * pos_volume);
            
            if (mBreakEvenUse && mBreakEvenTypePreco == PrecoPosicao)
            {
               if (ReturnBid() <= pos_price - ReturnBreakEvenTrigger())
               {
                  double novoStop = pos_price - ReturnBreakEvenStop();
                  novoStop = ReturnPreco(novoStop);
                  
                  if (novoStop < pos_sl || pos_sl == 0)
                     if (!objetoTrade.PositionModify(pos_ticket,novoStop,pos_tp))
                     {
                        string msg[] = { " Erro ao atualizar o BreakEven Por Posição - "+IntegerToString(pos_ticket) };
                        SendMessage(msg);
                     }
               }
            }
            
            if (mTrailingStopUse && mTrailingStopTypePreco == PrecoPosicao)
            {
               if (ReturnBid() <= pos_price - ReturnTrailingStopTrigger())
               {
                  double novoStop = pos_price - ReturnTrailingStopStop();
                  double diferenca = (pos_price - ReturnTrailingStopTrigger()) - ReturnBid();
                  diferenca = diferenca*mTrailingStopAtualizacao;
                  
                  novoStop = novoStop - diferenca;
                  novoStop = ReturnPreco(novoStop);
                  
                  if (novoStop < pos_sl || pos_sl == 0)
                     if (!objetoTrade.PositionModify(pos_ticket,novoStop,pos_tp))
                     {
                        string msg[] = { " Erro ao atualizar o Trailing Stop Por Posição - "+IntegerToString(pos_ticket) };
                        SendMessage(msg);
                     }
               }
            
            }
            
         }
         
         if (pos_sl == 0)
            countStopZero++;
         if (pos_tp == 0)
            countTPZero++;
         
         if (pos_tp == 0 && mTakeProfitType == Mercado && ReturnTakeProfit(gOpenCount) > 0)
         {
            string msg[] = { "Há posições sem TP" };
            SendMessage(msg);
            countPositionNoTP++;
            
            if (vConferencia && mTakeProfitTypePreco == PrecoPosicao)
            {
               if (pos_type == POSITION_TYPE_BUY)
               {
                  double vStop = 0;
                  if (ReturnStop() > 0)
                  {
                     vStop = pos_price - ReturnStop();
                     vStop = ReturnPreco(vStop);
                  }
                  
                  double vTP = 0;
                  
                  if (ReturnTakeProfit(gOpenCount) > 0)
                  {
                     vTP = pos_price + ReturnTakeProfit(gOpenCount);
                     vTP = ReturnPreco(vTP);
                  }
                  
                  if (objetoTrade.PositionModify(pos_ticket,vStop,vTP))
                  {
                     string msg[] = { "Posição corrigida com sucesso - "+IntegerToString(pos_ticket) };
                     SendMessage(msg);
                  }
                  else
                  {
                     string msg[] = { "Erro ao corrigir a posição - "+IntegerToString(pos_ticket) };
                     SendMessage(msg);
                  }
               }
               else if (pos_type == POSITION_TYPE_SELL)
               {
                  double vStop = 0;
                  if (ReturnStop() > 0)
                  {
                     vStop = pos_price + ReturnStop();
                     
                     vStop = ReturnPreco(vStop);
                  }
                  
                  double vTP = 0;
                  
                  if (ReturnTakeProfit(gOpenCount) > 0)
                  {
                     vTP = pos_price - ReturnTakeProfit(gOpenCount);
                     vTP = ReturnPreco(vTP);
                  }
                  if (objetoTrade.PositionModify(pos_ticket,vStop,vTP))
                  {
                     string msg[] = { "Posição corrigida com sucesso - "+IntegerToString(pos_ticket) };
                     SendMessage(msg);
                  }
                  else
                  {
                     string msg[] = { "Erro ao corrigir a posição - "+IntegerToString(pos_ticket) };
                     SendMessage(msg);
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
         volumeOpenLimit = volumeOpenLimit + pos_volume;
      }
   
      i--;
   }
   
   if(precoMedio > 0)
      precoMedio = precoMedio/volumeOpen;
   if (precoMedioBuy > 0)
      precoMedioBuy = precoMedioBuy/volumeOpenBuy;
   if (precoMedioSell > 0)
      precoMedioSell = precoMedioSell/volumeOpenSell;
      
   gPrecoMedio       =  precoMedio;
   gPrecoMedioBuy    =  precoMedioBuy;
   gPrecoMedioSell   =  precoMedioSell;
      
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

      gProximaEntradaAcima = proximaEntradaAcima + (ReturnDistancia());
      gProximaEntradaAbaixo = proximaEntradaAbaixo - (ReturnDistancia());
      
      if (mTradeDistanciaTendencia)
      {
         if (gIsOpenBuy)
         {
            gProximaEntradaAcima = 0;
         }
         else if (gIsOpenSell)
         {
            gProximaEntradaAbaixo = 0;
         }
      
      }
   }   
   else
   {
   
      if (mTradeCloseNoOpen)
      if (gOperacaoAberta != -1)
      {
         string msg[] = { "Encerramento do ciclo de operações." };
         SendMessage(msg);
         gOperacaoAberta = -1;
         gProximaEntradaAcima = -1;
         gProximaEntradaAbaixo = -1;
      }
         
            
      if (gOperacaoAberta != -1)
      {
         gProximaEntradaAcima = 0;
         gProximaEntradaAbaixo = 0;
      }
   }
   
   
   if (vConferencia)
   {
      if (mTakeProfitTypePreco == PrecoPosicao)
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
               string msg[] = { "Quantidade de Ordens Limits estão corretas!" };
               SendMessage(msg);
               PrintFormat("");
            }
            else
            {
               if (openCount == orderCountLimit+openCountLimit)
               {
                  string msg[] = { "Quantide de Ordens Limits está aguardando Fechamento por Hedge." };
                  SendMessage(msg);
                  CheckCloseLimit();
               }
               else
               {
                  string msg[] = { "Quantide de Ordens Limits está errada. Tentando corrigir." };
                  SendMessage(msg);
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
      }
      
      if (mStopTypePreco == PrecoMedio || mTakeProfitTypePreco == PrecoMedio)
      {
         double stop = 0;
         if (mStopTypePreco == PrecoMedio)
            stop = ReturnStop();
            
         double tp = 0;
         if (mTakeProfitTypePreco == PrecoMedio)
            tp = ReturnTakeProfit(gOpenCount);
            
         if (gOperacaoAberta == 0)
         {
            
            if (mStopTypePreco == PrecoMedio && stop > 0)
            {
               stop = precoMedioBuy - stop;
               stop = ReturnPreco(stop);
            }
            
            if (mTakeProfitTypePreco == PrecoMedio && tp > 0)
            {
               tp = precoMedioBuy + tp;
               tp = ReturnPreco(tp);
            }
               
            
            
         }
         else if (gOperacaoAberta == 1)
         {
            if (mStopTypePreco == PrecoMedio && stop > 0)
            {
               stop = precoMedioSell + stop;
               stop = ReturnPreco(stop);
            }
            
            if (mTakeProfitTypePreco == PrecoMedio && tp > 0)
            {
               tp = precoMedioSell - tp;
               tp = ReturnPreco(tp);
            }
         }
         
         if (mTakeProfitType == Mercado)
         {
            i = PositionsTotal()-1;
   
            while (i >= 0)
            {
               PositionGetSymbol(i);
               GetPositionProperties();
               
               if (pos_symbol == mSymbol)
               if (pos_magic == mTradeMagicNumber)
               {
                  if (pos_sl != stop || pos_tp != tp)
                  {
                     if (objetoTrade.PositionModify(pos_ticket,stop,tp))
                     {
                        string msg[] = { "Posição corrigida com sucesso - "+IntegerToString(pos_ticket) };
                        SendMessage(msg);
                     }
                     else
                     {
                        string msg[] = { "Erro ao corrigir a posição - "+IntegerToString(pos_ticket) };
                        SendMessage(msg);
                     }
                  }
               }
               
               i--;
            }
         
         }
         else if (mTakeProfitType == Limit)
         {
            double volumeOrdemLimit = 0;
            int qntOrdemLimit = 0;
            
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
                        volumeOrdemLimit = OrderGetDouble(ORDER_VOLUME_CURRENT);
                        qntOrdemLimit++;
                     }
                  
                  }
               }
            }
         
            if (volumeOrdemLimit != gVolumeOpen || qntOrdemLimit > 1)
            {
               SendDeleteByMagicNumber(-1,mTradeMagicNumberLimit);
               SendOrdersTakeProfitLimits(0, 0, gVolumeOpen, gOperacaoAberta, 0,tp);
         
               if (mStopTypePreco == PrecoMedio)
               {
                  i = PositionsTotal()-1;
      
                  while (i >= 0)
                  {
                     PositionGetSymbol(i);
                     GetPositionProperties();
                     
                     if (pos_symbol == mSymbol)
                     if (pos_magic == mTradeMagicNumber)
                     {
                        if (objetoTrade.PositionModify(pos_ticket,stop,0))
                        {
                           string msg[] = { "Posição corrigida com sucesso - "+IntegerToString(pos_ticket) };
                           SendMessage(msg);
                        }
                        else
                        {
                           string msg[] = { "Erro ao corrigir a posição - "+IntegerToString(pos_ticket)};
                           SendMessage(msg);
                        }
                     }
                     
                     i--;
                     
                  }
               }
            }
         }
         
         
      }
   
   }
   else
   {
      if (gIsOpen)
      {
         double novoStopBreakEven = 0;
         double novoStopTrailingStop = 0;
         
         if (gIsOpenBuy)
         {
            if (mBreakEvenUse && mBreakEvenTypePreco == PrecoMedio) 
            {
               if (ReturnAsk() >= precoMedioBuy + ReturnBreakEvenTrigger())
               {
                  novoStopBreakEven = precoMedioBuy + ReturnBreakEvenStop();
                  novoStopBreakEven = ReturnPreco(novoStopBreakEven);
               }
            }
            
            if (mTrailingStopUse && mTrailingStopTypePreco == PrecoMedio)
            {
               if (ReturnAsk() >= precoMedioBuy + ReturnTrailingStopTrigger())
               {
                  novoStopTrailingStop = precoMedioBuy + ReturnTrailingStopStop();
                  double diferenca = ReturnAsk() - (precoMedioBuy + ReturnTrailingStopTrigger());
                  diferenca = diferenca*mTrailingStopAtualizacao;
                  
                  novoStopTrailingStop = novoStopTrailingStop + diferenca;
                  novoStopTrailingStop = ReturnPreco(novoStopTrailingStop);
                  
               }
            
            }
            
            if (novoStopBreakEven > 0 || novoStopTrailingStop > 0)
            {
               i = PositionsTotal()-1;
   
               while (i >= 0)
               {
                  PositionGetSymbol(i);
                  GetPositionProperties();
                  
                  if (pos_symbol == mSymbol)
                  if (pos_magic == mTradeMagicNumber)
                  {
                     if (pos_type == POSITION_TYPE_BUY)
                     {
                        if (novoStopBreakEven > 0)
                        {
                           if (novoStopBreakEven > pos_sl)
                              if (!objetoTrade.PositionModify(pos_ticket,novoStopBreakEven,pos_tp))
                                 {
                                    string msg[] = { " Erro ao atualizar o BreakEven Por Preço Médio - "+IntegerToString(pos_ticket) };
                                    SendMessage(msg);
                                 }
                        
                        }
                        
                        if (novoStopTrailingStop > 0)
                        {
                           if (novoStopTrailingStop > pos_sl)
                              if (!objetoTrade.PositionModify(pos_ticket,novoStopTrailingStop,pos_tp))
                              {
                                 string msg[] = { " Erro ao atualizar o Trailing Stop Por Preço Médio - "+IntegerToString(pos_ticket) };
                                 SendMessage(msg);
                              }
                        
                        }
                     
                     }
                  }
                  i--;
               }
            
            }
         }
         else if (gIsOpenSell)
         {
            if (mBreakEvenUse && mBreakEvenTypePreco == PrecoMedio) 
            {
               if (ReturnBid() <= precoMedioSell - ReturnBreakEvenTrigger())
               {
                  novoStopBreakEven = precoMedioSell - ReturnBreakEvenStop();
                  novoStopBreakEven = ReturnPreco(novoStopBreakEven);
               }
            }
            
            if (mTrailingStopUse && mTrailingStopTypePreco == PrecoMedio)
            {
               if (ReturnBid() <= precoMedioSell - ReturnTrailingStopTrigger())
               {
                  novoStopTrailingStop = precoMedioSell - ReturnTrailingStopStop();
                  double diferenca = (precoMedioSell - ReturnTrailingStopTrigger()) - ReturnBid();
                  diferenca = diferenca*mTrailingStopAtualizacao;
                  
                  novoStopTrailingStop = novoStopTrailingStop - diferenca;
                  novoStopTrailingStop = ReturnPreco(novoStopTrailingStop);
               }
            
            }
            
            if (novoStopBreakEven > 0 || novoStopTrailingStop > 0)
            {
               i = PositionsTotal()-1;
   
               while (i >= 0)
               {
                  PositionGetSymbol(i);
                  GetPositionProperties();
                  
                  if (pos_symbol == mSymbol)
                  if (pos_magic == mTradeMagicNumber)
                  {
                     if (pos_type == POSITION_TYPE_SELL)
                     {
                        if (novoStopBreakEven > 0)
                        {
                           if (novoStopBreakEven > pos_sl || pos_sl == 0)
                              if (!objetoTrade.PositionModify(pos_ticket,novoStopBreakEven,pos_tp))
                                 {
                                    string msg[] = { " Erro ao atualizar o BreakEven Por Posição - "+IntegerToString(pos_ticket) };
                                    SendMessage(msg);
                                 }
                        
                        }
                        
                        if (novoStopTrailingStop > 0 || pos_sl == 0)
                        {
                           if (novoStopTrailingStop > pos_sl)
                              if (!objetoTrade.PositionModify(pos_ticket,novoStopTrailingStop,pos_tp))
                              {
                                 string msg[] = { " Erro ao atualizar o Trailing Stop Por Posição - "+IntegerToString(pos_ticket) };
                                 SendMessage(msg);
                              }
                        
                        }
                     
                     }
                  }
                  i--;
               }
            
            }
         
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
      
      if (HistoryDealGetInteger(deal_ticket,DEAL_MAGIC) == mTradeMagicNumber)
      if (HistoryDealGetInteger(deal_ticket,DEAL_TYPE) == 0 || HistoryDealGetInteger(deal_ticket,DEAL_TYPE) == 1) 
      if ( (HistoryDealGetInteger(deal_ticket,DEAL_ENTRY) != DEAL_ENTRY_OUT_BY) || ( HistoryDealGetInteger(deal_ticket,DEAL_ENTRY) == DEAL_ENTRY_OUT_BY && HistoryDealGetDouble(deal_ticket,DEAL_PROFIT) != 0) )
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
      if (HistoryDealGetInteger(deal_ticket,DEAL_TYPE) == 0 || HistoryDealGetInteger(deal_ticket,DEAL_TYPE) == 1) 
      if ( (HistoryDealGetInteger(deal_ticket,DEAL_ENTRY) != DEAL_ENTRY_OUT_BY) || ( HistoryDealGetInteger(deal_ticket,DEAL_ENTRY) == DEAL_ENTRY_OUT_BY && HistoryDealGetDouble(deal_ticket,DEAL_PROFIT) != 0) )
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
      
      if (HistoryDealGetInteger(deal_ticket,DEAL_MAGIC) == mTradeMagicNumber)
      if (HistoryDealGetInteger(deal_ticket,DEAL_TYPE) == 0 || HistoryDealGetInteger(deal_ticket,DEAL_TYPE) == 1) 
      if ( (HistoryDealGetInteger(deal_ticket,DEAL_ENTRY) != DEAL_ENTRY_OUT_BY) || ( HistoryDealGetInteger(deal_ticket,DEAL_ENTRY) == DEAL_ENTRY_OUT_BY && HistoryDealGetDouble(deal_ticket,DEAL_PROFIT) != 0) )
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
         if (HistoryDealGetInteger(dealTicket,DEAL_TYPE) == 0 || HistoryDealGetInteger(dealTicket,DEAL_TYPE) == 1) 
         if ( (HistoryDealGetInteger(dealTicket,DEAL_ENTRY) != DEAL_ENTRY_OUT_BY) || ( HistoryDealGetInteger(dealTicket,DEAL_ENTRY) == DEAL_ENTRY_OUT_BY && HistoryDealGetDouble(dealTicket,DEAL_PROFIT) != 0) )
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
   ulong positionTicket = 0;
   double positionPreco = objetoTrade.ResultPrice();
   double positionVolume = objetoTrade.ResultVolume();
   string msg[] = { "Atualizando Ordem" , "Ticket: "+positionTicket, "Preco: "+positionPreco,"Volume: "+positionVolume };
   SendMessage(msg);
   
   
   if (mTakeProfitTypePreco == PrecoPosicao)
   {
      if (positionTicket != 0 && positionPreco != 0 && positionVolume != 0)
      {
         if (vType == 0)
         {
            double stop = 0;
            if (vStop > 0)
            {
               stop = positionPreco - vStop;
               stop = ReturnPreco(stop);
            }
            
            double tp = 0;
            if (vTP > 0)
            {
               tp = positionPreco + vTP;
               tp = ReturnPreco(tp);
            }
            
            if (mTakeProfitType == Mercado)
            {
               if (objetoTrade.PositionModify(positionTicket,stop,tp))
               {
                  string msg[] = { "Posição atualizada com sucesso - "+IntegerToString(positionTicket) };
                  SendMessage(msg);
                  return true;
               }
               else
               {
                  string msg[] = { "Erro ao atualizar a posição - "+IntegerToString(positionTicket) };
                  SendMessage(msg);
                  return false;
               }
            }
            else if (mTakeProfitType == Limit)
            {
               objetoTrade.PositionModify(positionTicket,stop,0);
               if (vTP > 0)
               {
                  if (objetoTradeLimit.SellLimit(positionVolume,tp,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(positionTicket)))
                  {
                     string msg[] = { "Posição atualizada com sucesso - "+IntegerToString(positionTicket) };
                     SendMessage(msg);
                     SleepTime(1);
                     return true;
                  }
                  else
                  {
                     string msg[] = { "Erro ao atualizar a posição - "+IntegerToString(positionTicket) };
                     SendMessage(msg);
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
               stop = positionPreco + vStop;
               stop = ReturnPreco(stop);
            }
            
            double tp = 0;
            if (vTP > 0)
            {
               tp = positionPreco - vTP;
               tp = ReturnPreco(tp);
            }
            
            if (mTakeProfitType == Mercado)
            {
               if (objetoTrade.PositionModify(positionTicket,stop,tp))
               {
                  string msg[] = { "Posição atualizada com sucesso - "+IntegerToString(positionTicket) };
                  SendMessage(msg);
                  return true;
               }
               else
               {
                  string msg[] = { "Erro ao atualizar a posição - "+IntegerToString(positionTicket) };
                  SendMessage(msg);
                  return false;
               }
            }
            else if (mTakeProfitType == Limit)
            {
               objetoTrade.PositionModify(positionTicket,stop,0);
               if (vTP > 0)
               {
                  if (objetoTradeLimit.BuyLimit(positionVolume,tp,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(positionTicket)))
                  {
                     string msg[] = { "Posição atualizada com sucesso - "+IntegerToString(positionTicket) };
                     SendMessage(msg);
                     SleepTime(1);
                     return true;
                  }
                  else
                  {
                     string msg[] = { "Erro ao atualizar a posição - "+IntegerToString(positionTicket) };
                     SendMessage(msg);
                     return false;
                  }
               }
            }
         }
      
      }
   }
   
   
   
   return false;
}
//+------------------------------------------------------------------+
//| Refresh Indicadores                                              |
//+------------------------------------------------------------------+
void CController::RefreshIndicadores(void)
{
   if (gIsNewBar)
      gInfo = "";
   
   for (int i = 0; i<listIndicador.Size(); i++)
   {
      if (listIndicador[i].mUse)
      {
         if(gIsNewBar)
         {
            listIndicador[i].RefreshBuffer();
            gInfo = gInfo + "\nInd. "+IntegerToString(i+1)+" - Resultado: "+listIndicador[i].ReturnResultadoIndicador();
            
         }
      }
   }
}
//+------------------------------------------------------------------+
//| Return Stop                                                      |
//+------------------------------------------------------------------+
double CController::ReturnStop(void)
{
   double result = mStop;
   
   if (mStopTypePreco == PrecoPosicao)
   {
      result = mStop;
   }
   else if (mStopTypePreco == PrecoMedio)
   {
      result = mStop;
   }
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Take Profit                                               |
//+------------------------------------------------------------------+
double CController::ReturnTakeProfit(int vIndex)
{
   double result = mTakeProfit;
   
   if (mTradeTakeDiferenteUse && mTradeTakeDiferente.Size() > 0)
   {
      if (gIsOpen)
      {
         if (vIndex < mTradeTakeDiferente.Size())
         {
            if (vIndex > 0)
               result = mTradeTakeDiferente[vIndex-1];
            else
               result = mTradeTakeDiferente[0];
         }
         else
         {
            if (mTradeTakeDiferente.Size() > 0)
               result = mTradeTakeDiferente[mTradeTakeDiferente.Size()-1];
            else
               result = mTakeProfit;
         }
         
      }
      else
      {
         if (mTradeTakeDiferente.Size() > 0)
            result = mTradeTakeDiferente[0];
         else
            result = mTakeProfit;
      }
   }
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Volume                                                    |
//+------------------------------------------------------------------+
double CController::ReturnVolume(void)
{
   double result = mTradeVolume;
   
   if (mTradeVolumeDiferenteUse && mTradeVolumeDiferente.Size() > 0)
   {
      if (gIsOpen)
      {
         if (gOpenCount < mTradeVolumeDiferente.Size())
         {
            if (gOpenCount > 0)
               return mTradeVolumeDiferente[gOpenCount-1];
            else
               return mTradeVolumeDiferente[0];
         
         }
         else
         {
            if (mTradeVolumeDiferente.Size() > 0)
               return mTradeVolumeDiferente[mTradeVolumeDiferente.Size()-1];
            else
               return SymbolInfoDouble(mSymbol,SYMBOL_VOLUME_MIN);
         }
         
      }
      else
      {
         if (mTradeVolumeDiferente.Size() > 0)
            return mTradeVolumeDiferente[0];
         else
            return SymbolInfoDouble(mSymbol,SYMBOL_VOLUME_MIN);
      }
   }
   else
   {
      return mTradeVolume;
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Distância                                                 |
//+------------------------------------------------------------------+
double CController::ReturnDistancia(void)
{
   double result = mTradeDistancia;
   
   if (mTradeDistanciaDiferenteUse && mTradeDistanciaDiferente.Size() > 0)
   {
      if (gOpenCount < mTradeDistanciaDiferente.Size())
      {
         if (gOpenCount > 0)
            result = mTradeDistanciaDiferente[gOpenCount-1];
         else
            result = mTradeDistanciaDiferente[0];
      }
      else
      {
         if (mTradeDistanciaDiferente.Size() > 0)
            result = mTradeDistanciaDiferente[mTradeDistanciaDiferente.Size()-1];
         else
            result = result;
      }
   
   }
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Break Even Trigger                                        |
//+------------------------------------------------------------------+
double CController::ReturnBreakEvenTrigger(void)
{
   double result = mBreakEvenTrigger;
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Break Even Stop                                           |
//+------------------------------------------------------------------+
double CController::ReturnBreakEvenStop(void)
{
   double result = mBreakEvenStop;
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Trailing Stop Trigger                                        |
//+------------------------------------------------------------------+
double CController::ReturnTrailingStopTrigger(void)
{
   double result = mTrailingStopTrigger;
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   
   return result;
}
//+------------------------------------------------------------------+
//| Return Trailing Stop Stop                                           |
//+------------------------------------------------------------------+
double CController::ReturnTrailingStopStop(void)
{
   double result = mTrailingStopStop;
   
   if (mSymbolPontosPips == Pips)
      result = result * ReturnTradeTickSize();
   else
      result = result;
   
   
   return result;
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
   
   string msg[] = { "Fechar posições" };
   SendMessage(msg);
   
   while(!fechou)
   {
      fechou = true;
      int i = PositionsTotal()-1;
      
      while(i>=0)
      {
         PositionGetSymbol(i);
         GetPositionProperties();
         
         if(pos_symbol == mSymbol)
         if(pos_magic == mTradeMagicNumber || pos_magic == mTradeMagicNumberLimit)
         {
            if (  (pos_type == POSITION_TYPE_BUY && vType == 0) ||
                  (pos_type == POSITION_TYPE_SELL && vType == 1) ||
                  (vType == -1)
               )
            {
               if(objetoTrade.PositionClose(pos_ticket))
               {
                  string msg[] = { "Posição encerrada com sucesso: "+IntegerToString(pos_ticket) };
                  SendMessage(msg);
               }
               else
               {
                  string msg[] = { "Erro ao fechar posição: "+IntegerToString(pos_ticket) };
                  SendMessage(msg);
                  fechou = false;
               }
            }
         }
      
         i--;
      }
      
      count++;
      if(count>=100)
         return false;
   
   }
   
   objetoGUI.DeleteLines();
   objetoGUI.DeleteLinesInput();
   objetoGUI.DeleteLinesPrecoMedio();
   
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
   
   string msg[] = { "Deletar Ordens" };
   SendMessage(msg);
   
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
                        string msg[] = { "Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                        fechou = false;
                     }
                     else
                     {
                        string msg[] = { "Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                     }
                  }
                  
                  
                  if (vType == 1 && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT)) 
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        string msg[] = { "Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                        fechou = false; 
                     }
                     else
                     {
                        string msg[] = { "Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                     }
                  }
                  
                  
                  if (vType == -1)
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        string msg[] = { "Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                        fechou = false; 
                     }
                     else
                     {
                        string msg[] = { "Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
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
   
   string msg[] = { "Deletar Ordens" };
   SendMessage(msg);
   
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
                        string msg[] = { "Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                        fechou = false;
                     }
                     else
                     {
                        string msg[] = { "Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                     }
                  }
                  
                  
                  if (vType == 1 && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT)) 
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        string msg[] = { "Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET)) };
                        SendMessage(msg);
                        fechou = false; 
                     }
                     else
                     {
                        string msg[] = { "Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET))};
                        SendMessage(msg);
                     }
                  }
                  
                  
                  if (vType == -1)
                  {
                     if (!this.objetoTrade.OrderDelete(ticket))
                     {
                        string msg[] = { "Erro ao excluir a ordem: "+IntegerToString(OrderGetInteger(ORDER_TICKET))};
                        SendMessage(msg);
                        fechou = false; 
                     }
                     else
                     {
                        string msg[] = { "Ordem excluida com sucesso: "+IntegerToString(OrderGetInteger(ORDER_TICKET))};
                        SendMessage(msg);
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
      string msg[] = { "Ordem deletada com sucesso - "+vTicket};
      SendMessage(msg);
   }
   else
   {
      string msg[] = { "Erro deletada a ordem - "+vTicket };
      SendMessage(msg);
   }
   
   return result;
}
//+------------------------------------------------------------------+
//| Send Buy                                                         |
//+------------------------------------------------------------------+
bool CController::SendBuy(double vVolume,double vStop,double vTP)
{
   double stop = 0;
      
   double tp = 0;
   
   if (objetoTrade.Buy(vVolume,mSymbol,ReturnAsk(),0,0,mTradeComentario))
   {
      string msg[] = { "Compra Realizada com Sucesso" };
      SendMessage(msg);
      
      SleepTime(1);
      
      return true;
   }
   else
   {
      string msg[] = { "Primeira tentativa de Compra não realizada" };
      SendMessage(msg);
        
      SleepTime(1);  
         
      if (objetoTrade.Buy(vVolume,mSymbol,ReturnAsk(),stop,0,mTradeComentario))
      {
         string msg[] = { "Compra Realizada com Sucesso" };
         SendMessage(msg);
         SleepTime(1);
         return true;
         
      }
      else
      {
         string msg[] = { "Segunda tentativa de Compra não realizada" };
         SendMessage(msg);
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
      
   double tp = 0;
   
   
   if (objetoTrade.Sell(vVolume,mSymbol,ReturnBid(),0,0,mTradeComentario))
   {
      string msg[] = { "Venda Realizada com Sucesso" };
      SendMessage(msg);
      SleepTime(1.5);
      return true;
   }
   else
   {
      string msg[] = { "Primeira tentativa de Venda não realizada" };
      SendMessage(msg);
      if (stop > 0)
         stop = ReturnPreco(stop);
         
      if (tp > 0)
         tp = ReturnPreco(tp);
         
      
      SleepTime(1);  
         
      if (objetoTrade.Sell(vVolume,mSymbol,ReturnBid(),0,0,mTradeComentario))
      {
         string msg[] = { "Venda Realizada com Sucesso" };
         SendMessage(msg);
         SleepTime(1.5);
         return true;
      }
      else
      {  
         string msg[] = { "Segunda tentativa de Venda não realizada" };
         SendMessage(msg);
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
         if (vStop > 0)
            objetoTrade.PositionModify(vTicket,vStop,0);
         
         if (vTP > 0)
         {
            if (objetoTradeLimit.SellLimit(vVolume,vTP,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(vTicket)))
            {
               string msg[] = { "Posição atualizada com sucesso - "+IntegerToString(vTicket) };
               SendMessage(msg);
               SleepTime(0.2);
               return true;
            }
            else
            {
               string msg[] = { "Erro ao atualizar a posição - "+IntegerToString(vTicket) };
               SendMessage(msg);
               return false;
            }
         
         }
      }
      else if (vType == 1)
      {
         if (vStop > 0)
            objetoTrade.PositionModify(vTicket,vStop,0);
         
         if (vTP > 0)
         {
            if (objetoTradeLimit.BuyLimit(vVolume,vTP,mSymbol,0,0,ORDER_TIME_GTC,0,IntegerToString(vTicket)))
            {
               string msg[] = { "Posição atualizada com sucesso - "+IntegerToString(vTicket) };
               SendMessage(msg);
               SleepTime(0.2);
               return true;
            }
            else
            {
               string msg[] = { "Erro ao atualizar a posição - "+IntegerToString(vTicket) };
               SendMessage(msg);
               return false;
            }
         
         }
      }
   }
  
   return result;
}
//+------------------------------------------------------------------+
//| Send Message                                                     |
//+------------------------------------------------------------------+
void CController::SendMessage(string &vMsg[])
{
   PrintFormat("===== Lion =====");
   for (int i = 0; i < vMsg.Size(); i++)
   {
      PrintFormat(vMsg[i]);
   }
   PrintFormat("================");
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
