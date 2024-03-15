//+------------------------------------------------------------------+
//|                                                         Lion.mq5 |
//|                                      Copyright 2024, RB Investe. |
//|                                     https://www.rbinteste.com.br |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, RB Investe."
#property link      "https://www.rbinveste.com.br"
#define EA                             "Lion"
#define VERSION                        "1.0.11-a1"
#property version   VERSION
//+------------------------------------------------------------------+
//| Renko                                                            |
//+------------------------------------------------------------------+
#include <RenkoCharts.mqh>
RenkoCharts *RenkoOffline;
string original_symbol;
string custom_symbol;
ENUM_RENKO_TYPE   RenkoType      = RENKO_TYPE_TICKS;     // Type
bool              RenkoWicks     = true;                 // Show Wicks
bool              RenkoTime      = true;                 // Brick Open Time
bool              RenkoAsymetricReversal = false;        // Asymetric Reversals
ENUM_RENKO_WINDOW RenkoWindow    = RENKO_CURRENT_WINDOW;     // Chart Mode
int               RenkoTimer     = 500;                  // Timer in milliseconds (0 = Off)
bool              RenkoBook      = true;                 // Watch Market Book
bool _DebugMode = (MQL5InfoInteger(MQL5_TESTER) || MQL5InfoInteger(MQL5_DEBUG) || MQL5InfoInteger(MQL5_DEBUGGING) || MQL5InfoInteger(MQL5_OPTIMIZATION) || MQL5InfoInteger(MQL5_VISUAL_MODE) || MQL5InfoInteger(MQL5_PROFILER));
//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include          <../Experts/RB Investe/Lion/Business/Controller.mqh>
CController       objetoController;
//+------------------------------------------------------------------+
//| Globals Variables                                                |
//+------------------------------------------------------------------+
bool           gOnTrade;
//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
input             string               iLoginConfig               =  "= Email no RB Investe =";             // ====================
input             string               iLogin                     =  "";                                    // E-mail na RB Investe

input             string               iSymbolConfig              =  "= Símbolo =";                         // ====================
input             string               iSymbol                    =  "";                                    // Símbolo para Operação
input             typeCompraVenda      iSymbolCompraVenda         =  CompraVenda;                           // Compra/Venda
input             typePontosPips       iSymbolPontosPips          =  Pontos;                                // Pontos/Pips
input             typeCusto            iSymbolTypeCusto           =  PorContrato;                           // Custo por Contrato ou por Operação
input             double               iSymbolCusto               =  0;                                     // Custo
input             int                  iSymbolSpread              =  0;                                     // Spread Máximo (0 = desativado)

input             string               iRenkoConfig               =  "= Renko =";                           // ====================
input             bool                 iRenkoUse                  =  false;                                 // Usar Renko
input             int                  iRenkoSize                 =  20;                                    // Tamanho do Renko

input             string               iTimeTradeConfig           =  "= Horário =";                         // ====================
input             bool                 iTimeTradeUse              =  false;                                 // Usar horário nas operações
input             string               iTimeTradeStart            =  "09:00:00";                            // Horário Inicial
input             string               iTimeTradeEnd              =  "17:00:000";                           // Horário Final
input             bool                 iTimeTradeCloseUse         =  false;                                 // Usar horário de encerramento nas operações
input             string               iTimeTradeClose            =  "17:15:00";                            // Horário de Encerramento

input             string               iSleepConfig               =  "= Sleep =";                           // ====================
input             bool                 iSleepUse                  =  false;                                 // Usar Sleep
input             int                  iSleepLoss                 =  300;                                   // Sleep após uma perda (Segundos)
input             int                  iSleepGain                 =  300;                                   // Sleep após um ganho (Segundos)

input             string               iTradeConfig               =  "= Trade =";                           // ====================
input             typeAutomaticoManual iTradeAutomaticoManual     =  Automatico;                            // Automatico ou Manual
input             typeNormalReverso    iTradeNormalReverso        =  Normal;                                // Noral ou Reverso
input             int                  iTradeMagicNumber          =  1;                                     // Magic Number
input             string               iTradeComentario           =  "RB Investe - Lion";                   // Comentário
input             double               iTradeVolume               =  1;                                     // Volume Inicial
input             double               iTradeVolumeMaximo         =  20;                                    // Volume Máximo
input             double               iTradeDistancia            =  30;                                    // Distância 

input             string               iStopConfig                =  "= Stop =";                            // ====================
input             double               iStop                      =  0;                                     // Stop

input             string               iTakeProfitConfig          =  "= Take Profit =";                     // ====================
input             double               iTakeProfit                =  50;                                    // Ganho
input             typeTP               iTakeProfitType            =  Mercado;                               // Tipo da Ordem para Ganho (Mercado/Limit)

input             string               iLossConfig                =  "= Perda =";                           // ====================
input             double               iLossPosition              =  0;                                     // Perda máxima por posição
input             double               iLossDay                   =  0;                                     // Perda máxima por dia
input             double               iLossWeek                  =  0;                                     // Perda máxima por semana
input             double               iLossMonth                 =  0;                                     // Perda máxima por mês

input             string               iGainConfig                =  "= Ganho =";                           // ====================
input             double               iGainPosition              =  0;                                     // Ganho máximo por posição   
input             double               iGainDay                   =  0;                                     // Ganho máximo por dia
input             double               iGainWeek                  =  0;                                     // Ganho máximo por semana
input             double               iGainMonth                 =  0;                                     // Ganho máximo por mês    

input             string               iCicloConfig               =  "= Ciclo =";                           // ====================
input             bool                 iCicloUse                  =  false;                                 // Usar Controle de Ciclo
input             datetime             iCicloDataInicial          =  "2024.01.01";                          // Data Inicial do Ciclo
input             double               iCicloLoss                 =  -1200;                                 // Perda Máxima do Ciclo
input             double               iCicloGain                 =  1000;                                  // Ganho Máximo do Ciclo

input             string               iGUIConfig                 =  "= Configurações GUI =";               // ====================
input             int                  iGUIFontSize               =  10;                                    // Tamanho da Fonte
input             ENUM_LINE_STYLE      iGUILinePosicao            =  STYLE_SOLID;                           // Estilo da Linha da Posição
input             color                iGUICorPosicaoCompra       =  clrBlue;                               // Cor da Posição Comprada
input             color                iGUICorPosicaoVenda        =  clrRed;                                // Cor da Posição Vendida
input             color                iGUICorStop                =  clrWhite;                              // Cor do Stop na Posição
input             color                iGUICorTP                  =  clrGreen;                              // Cor do TP na Posição
input             ENUM_LINE_STYLE      iGUILineOrdem              =  STYLE_DASH;                            // Estilo da Linha da Ordem
input             color                iGUICorOrdem               =  clrYellow;                             // Cor da Ordem
input             color                iGUICorBox                 =  clrAntiqueWhite;                       // Cor do Box de Info
input             color                iGUICorBoxText             =  clrBlack;                              // Cor do Text no Box



 
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
//---
   if (InicializarRenko() == (INIT_FAILED))
      return(INIT_FAILED);
   
   InicializarController();
   InicializarGUI();
   gOnTrade = true;
   RefreshOnTrade();
   objetoController.RefreshGUI();
   ChartRedraw(0);
//---
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//---
   objetoController.objetoGUI.oguiLion.Destroy(reason);
}
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
{
//---
   gOnTrade  =  true;
}
//+------------------------------------------------------------------+
//| Timer Event                                                      |
//+------------------------------------------------------------------+
void OnTimer()
{
   if(RenkoTimer>0)
         OnTick();
}
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   objetoController.ChartEvent(id,lparam,dparam,sparam);
   objetoController.objetoGUI.oguiLion.ChartEvent(id,lparam,dparam,sparam);
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   if (iRenkoUse)
   {
      RenkoOffline.Refresh();
      ChartRedraw(0);
   }
   
   objetoController.gProximaEntradaAcima = -1;
   objetoController.gProximaEntradaAbaixo = -1;
   objetoController.gIsNewBar = objetoController.ReturnIsNewBar();
   objetoController.RefreshResultOpen(false);
   objetoController.RefreshDay();
   objetoController.RefreshGUI();
   objetoController.CheckPosicaoInicial(-1);
   objetoController.CheckNovasPosicoes();
   objetoController.CheckInverter(false);
   objetoController.CheckLossGain();
   objetoController.CheckCiclo();
   objetoController.CheckCloseLimit();
   RefreshOnTrade();
}
//+------------------------------------------------------------------+
//| Inicializando Renko                                              |
//+------------------------------------------------------------------+
int InicializarRenko()
{
   if (iRenkoUse)
   {
      //Check Symbol
      original_symbol = StringAt(_Symbol, "_");

      //Check Period
      if(RenkoWindow == RENKO_CURRENT_WINDOW && ChartPeriod(0) != PERIOD_M1)
        {
         Print("Renko must be M1 period!", __FILE__, MB_OK);
         ChartSetSymbolPeriod(0, original_symbol, PERIOD_M1);
         return(INIT_SUCCEEDED);
        }
      //Setup Renko
      if (RenkoOffline == NULL) 
         if ((RenkoOffline = new RenkoCharts()) == NULL)
           {
            MessageBox("Renko create class error. Check error log!", __FILE__, MB_OK);
            return(INIT_FAILED);
           }
      if (!RenkoOffline.Setup(original_symbol, RenkoType, iRenkoSize, RenkoWicks, RenkoTime, RenkoAsymetricReversal))
        {
         MessageBox("Renko setup error. Check error log!", __FILE__, MB_OK);
         return(INIT_FAILED);
        }
      //Create Custom Symbol
      RenkoOffline.CreateCustomSymbol();
      RenkoOffline.ClearCustomSymbol();
      custom_symbol = RenkoOffline.GetSymbolName();
      //Load History
      RenkoOffline.UpdateRates();
      RenkoOffline.ReplaceCustomSymbol();  
      //Start

         RenkoOffline.Start(RenkoWindow, RenkoTimer, RenkoBook);
      //Refresh
      RenkoOffline.Refresh();
   }
   
   return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Inicializando Controller                                         |
//+------------------------------------------------------------------+
void InicializarController()
{
   objetoController.mLogin = iLogin;
   
   int total = SymbolsTotal(true);
   bool exists = false;
   
   for (int i = 0; i <total;i++)
   {
      string symbol = SymbolName(i,true);
      if (symbol == iSymbol)
      {
         exists = true;
         break;
      }
   }
   
   if (exists)
      objetoController.mSymbol               =  (iSymbol);
   else
      objetoController.mSymbol               =  Symbol();
   
   if (iRenkoUse)
      objetoController.mSymbolIndicador      =  RenkoOffline.GetSymbolName();
   else
      objetoController.mSymbolIndicador      =  Symbol();
   
   objetoController.mSymbolCompraVenda       =  iSymbolCompraVenda;
   objetoController.mSymbolPontosPips        =  iSymbolPontosPips;
   objetoController.mSymbolTypeCusto         =  iSymbolTypeCusto;
   objetoController.mSymbolCusto             =  iSymbolCusto;
   objetoController.mSymbolSpread            =  iSymbolSpread;
   
   objetoController.mRenkoUse                =  iRenkoUse;
   objetoController.mRenkoSize               =  iRenkoSize;
   
   objetoController.mTimeTradeUse            =  iTimeTradeUse;
   objetoController.mTimeTradeStart          =  iTimeTradeStart;
   objetoController.mTimeTradeEnd            =  iTimeTradeEnd;
   objetoController.mTimeTradeCloseUse       =  iTimeTradeCloseUse;
   objetoController.mTimeTradeClose          =  iTimeTradeClose;
   
   objetoController.mSleepUse                =  iSleepUse;
   objetoController.mSleepLoss               =  iSleepLoss;
   objetoController.mSleepGain               =  iSleepGain;
   
   objetoController.mTradeAutomaticoManual   =  iTradeAutomaticoManual;
   objetoController.mTradeNormalReverso      =  iTradeNormalReverso;
   objetoController.mTradeMagicNumber        =  iTradeMagicNumber;
   objetoController.mTradeMagicNumberLimit   =  iTradeMagicNumber*-1;
   objetoController.mTradeComentario         =  iTradeComentario;
   objetoController.mTradeVolume             =  iTradeVolume;
   objetoController.mTradeVolumeMaximo       =  iTradeVolumeMaximo;
   objetoController.mTradeDistancia          =  iTradeDistancia;
   
   objetoController.mStop                    =  iStop;
   
   objetoController.mTakeProfit              =  iTakeProfit;
   objetoController.mTakeProfitType          =  iTakeProfitType;
   
   objetoController.mLossPosition            =  iLossPosition;
   objetoController.mLossDay                 =  iLossDay;
   objetoController.mLossWeek                =  iLossWeek;
   objetoController.mLossMonth               =  iLossMonth;
   
   objetoController.mGainPosition            =  iGainPosition;
   objetoController.mGainDay                 =  iGainDay;
   objetoController.mGainWeek                =  iGainWeek;
   objetoController.mGainMonth               =  iGainMonth;
   
   objetoController.mCicloUse                =  iCicloUse;
   objetoController.mCicloDataInicial        =  iCicloDataInicial;
   objetoController.mCicloLoss               =  iCicloLoss;
   objetoController.mCicloGain               =  iCicloGain;
   
   objetoController.gOperacaoAberta          =  -1;
   objetoController.objetoTrade.SetExpertMagicNumber(iTradeMagicNumber);
   objetoController.objetoTradeLimit.SetExpertMagicNumber(objetoController.mTradeMagicNumberLimit);
   
}
//+------------------------------------------------------------------+
//| Inicializando GUI                                                |
//+------------------------------------------------------------------+
void InicializarGUI()
{
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,true);
   int x1 = 0;
   int y1 = 0;
   int x2 = 300;;
   int y2 = 500;
   
   objetoController.objetoGUI.mName = EA + " - " + VERSION;
   objetoController.objetoGUI.mX1 = x1;
   objetoController.objetoGUI.mY1 = y1;
   objetoController.objetoGUI.mX2 = x2;
   objetoController.objetoGUI.mY2 = y2;
   
   objetoController.objetoGUI.mFontSize            =  iGUIFontSize;
   objetoController.objetoGUI.mLinePosicao         =  iGUILinePosicao;
   objetoController.objetoGUI.mCorPosicaoCompra    =  iGUICorPosicaoCompra;
   objetoController.objetoGUI.mCorPosicaoVenda     =  iGUICorPosicaoVenda;
   objetoController.objetoGUI.mCorStop             =  iGUICorStop;
   objetoController.objetoGUI.mCorTP               =  iGUICorTP;
   objetoController.objetoGUI.mLineOrdem           =  iGUILineOrdem;
   objetoController.objetoGUI.mCorOrdem            =  iGUICorOrdem;
   objetoController.objetoGUI.mCorBox              =  iGUICorBox;
   objetoController.objetoGUI.mCorBoxText          =  iGUICorBoxText;
   
   
   objetoController.objetoGUI.InicializarGUI();
   
   ChartRedraw(0);
}
//+------------------------------------------------------------------+
//| Refresh On Trade                                                 |
//+------------------------------------------------------------------+
void RefreshOnTrade()
{
   if (gOnTrade)
   {
      objetoController.RefreshResultOpen(true);
      objetoController.RefreshResultDay();
      objetoController.RefreshResultWeek();
      objetoController.RefreshResultMonth();
      objetoController.RefreshCiclo();
      
      objetoController.RefreshGUIPosicoesOrdens();
      
      gOnTrade = false;
   }
}
//+------------------------------------------------------------------+
