//+------------------------------------------------------------------+
//|                                                         Lion.mq5 |
//|                                      Copyright 2024, RB Investe. |
//|                                     https://www.rbinteste.com.br |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, RB Investe."
#property link      "https://www.rbinveste.com.br"
#define EA                             "Lion"
#define VERSION                        "1.1.1-a1"
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
input             bool                 iTradeCloseNoOpen          =  false;                                 // Encerrar as operações caso o robô tenha fechado todas as posições
input             int                  iTradeMagicNumber          =  1;                                     // Magic Number
input             string               iTradeComentario           =  "RB Investe - Lion";                   // Comentário
input             double               iTradeVolume               =  1;                                     // Volume Inicial
input             double               iTradeVolumeMaximo         =  20;                                    // Volume Máximo
input             double               iTradeDistancia            =  30;                                    // Distância 
input             bool                 iTradeDistanciaTendencia   =  false;                                 // Abrir novas posições apenas contra a tedência principal   

input             string               iStopConfig                =  "= Stop =";                            // ====================
input             typePreco            iStopTypePreco             =  PrecoPosicao;                          // Stop Por Posição ou Preço Médio
input             double               iStop                      =  0;                                     // Stop

input             string               iTakeProfitConfig          =  "= Take Profit =";                     // ====================
input             typePreco            iTakeProfitTypePreco       =  PrecoPosicao;                          // Take Profit Por Posição ou Preço Médio
input             double               iTakeProfit                =  50;                                    // Ganho
input             typeTP               iTakeProfitType            =  Mercado;                               // Tipo da Ordem para Ganho (Mercado/Limit)
input             int                  iTakeProfitLimitMagic      =  2;                                     // Magic Number das Ordens Limits                           

input             string               iTradeConfig2              =  "= Trade Plus =";                      // ====================
input             bool                 iTradeVolumeDiferenteUse   =  false;                                 // Usar volumes diferentes
input             string               iTradeVolumeDiferente      =  "1/1/2/2/3/3/4/4/5/5";                 // Coloque os valores dos Volumes separados por /
input             bool                 iTradeDistanciaDiferenteUse=  false;                                 // Usar distância diferentes
input             string               iTradeDistanciaDiferente   =  "30/40/50/60/70/80/90";                // Coloque as Distâncias separadas por /
input             bool                 iTradeTakeDiferenteUse     =  false;                                 // Usar Take Profits Diferentes
input             string               iTradeTakeDiferente        =  "500/30/30/30/30/30/30/30/30";         // Coloque os Take Profits separados por /  

input             string               iBreakEvenConfig           =  "= BreakEven =";                       // ====================
input             bool                 iBreakEvenUse              =  false;                                 // Usar Break Even
input             typePreco            iBreakEvenTypePreco        =  PrecoPosicao;                          // Break Even Por Posição ou Preço Médio  
input             double               iBreakEvenTrigger          =  200;                                   // Trigger
input             double               iBreakEvenStop             =  100;                                   // Stop

input             string               iTrailingStopConfig        =  "= Trailing Stop =";                   // ====================
input             bool                 iTrailingStopUse           =  false;                                 // Usar Trailing Stop
input             typePreco            iTrailingStopTypePreco     =  PrecoPosicao;                          // Trailing Stop Por Posição ou Preço Médio
input             double               iTrailingStopTrigger       =  200;                                   // Trigger
input             double               iTrailingStopStop          =  100;                                   // Stop
input             double               iTrainlingStopAtualizacao  =  1;                                     // Atualização

input             string               iLossConfig                =  "= Perda =";                           // ====================
input             typeGainLoss         iLossType                  =  Robo;                                  // Perda por Robô ou Conta Total
input             double               iLossPosition              =  0;                                     // Perda máxima por posição
input             double               iLossDay                   =  0;                                     // Perda máxima por dia
input             double               iLossWeek                  =  0;                                     // Perda máxima por semana
input             double               iLossMonth                 =  0;                                     // Perda máxima por mês

input             string               iGainConfig                =  "= Ganho =";                           // ====================
input             typeGainLoss         iGainType                  =  Robo;                                  // Ganho por Robô ou Conta Total
input             double               iGainPosition              =  0;                                     // Ganho máximo por posição   
input             double               iGainDay                   =  0;                                     // Ganho máximo por dia
input             double               iGainWeek                  =  0;                                     // Ganho máximo por semana
input             double               iGainMonth                 =  0;                                     // Ganho máximo por mês    

input             string               iCicloConfig               =  "= Ciclo =";                           // ====================
input             bool                 iCicloUse                  =  false;                                 // Usar Controle de Ciclo
input             datetime             iCicloDataInicial          =  "2024.01.01";                          // Data Inicial do Ciclo
input             double               iCicloLoss                 =  -1200;                                 // Perda Máxima do Ciclo
input             double               iCicloGain                 =  1000;                                  // Ganho Máximo do Ciclo

input             string               iIndicador1Config          =  "= Indicador 1 =";                     // ====================
input             bool                 iIndicador1Usar            =  false;                                 // Usar Indicador 1
input             string               iIndicador1Symbol          =  "";                                    // Indicador 1 - Symbol
input             typeNormalReverso    iIndicador1NormalReverso   =  Normal;                                // Indicador 1 - Normal ou Reverso
input             ENUM_TIMEFRAMES      iIndicador1TimeFrame       =  PERIOD_CURRENT;                        // Indicador 1 - Time frame
input             bool                 iIndicador1RenkoUsar       =  false;                                 // Indicador 1 - Usar no modo Renko
input             int                  iIndicador1RenkoSize       =  20;                                    // Indicador 1 - Renko Size
input             int                  iIndicador1Media           =  9;                                     // Indicador 1 - Média do Indicador
input             int                  iIndicador1MacdSinal       =  9;                                     // Indicador 1 - MACD Sinal
input             int                  iIndicador1MacdCurta       =  12;                                    // Indicador 1 - MACD Curta
input             int                  iIndicador1MacdLonga       =  26;                                    // Indicador 1 - MACD Longa

input             string               iIndicador2Config          =  "= Indicador 2 =";                     // ====================
input             bool                 iIndicador2Usar            =  false;                                 // Usar Indicador 2
input             string               iIndicador2Symbol          =  "";                                    // Indicador 2 - Symbol
input             typeNormalReverso    iIndicador2NormalReverso   =  Normal;                                // Indicador 2 - Normal ou Reverso
input             ENUM_TIMEFRAMES      iIndicador2TimeFrame       =  PERIOD_CURRENT;                        // Indicador 2 - Time frame
input             bool                 iIndicador2RenkoUsar       =  false;                                 // Indicador 2 - Usar no modo Renko
input             int                  iIndicador2RenkoSize       =  20;                                    // Indicador 2 - Renko Size
input             int                  iIndicador2Media           =  9;                                     // Indicador 2 - Média do Indicador
input             int                  iIndicador2MacdSinal       =  9;                                     // Indicador 2 - MACD Sinal
input             int                  iIndicador2MacdCurta       =  12;                                    // Indicador 2 - MACD Curta
input             int                  iIndicador2MacdLonga       =  26;                                    // Indicador 2 - MACD Longa

input             string               iIndicador3Config          =  "= Indicador 3 =";                     // ====================
input             bool                 iIndicador3Usar            =  false;                                 // Usar Indicador 3
input             string               iIndicador3Symbol          =  "";                                    // Indicador 3 - Symbol
input             typeNormalReverso    iIndicador3NormalReverso   =  Normal;                                // Indicador 3 - Normal ou Reverso
input             ENUM_TIMEFRAMES      iIndicador3TimeFrame       =  PERIOD_CURRENT;                        // Indicador 3 - Time frame
input             bool                 iIndicador3RenkoUsar       =  false;                                 // Indicador 3 - Usar no modo Renko
input             int                  iIndicador3RenkoSize       =  20;                                    // Indicador 3 - Renko Size
input             int                  iIndicador3Media           =  9;                                     // Indicador 3 - Média do Indicador
input             int                  iIndicador3MacdSinal       =  9;                                     // Indicador 3 - MACD Sinal
input             int                  iIndicador3MacdCurta       =  12;                                    // Indicador 3 - MACD Curta
input             int                  iIndicador3MacdLonga       =  26;                                    // Indicador 3 - MACD Longa

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
input             color                iGUICorLinePrecoMedio      =  clrYellow;                             // Cor da Linha do Preço Médio
input             ENUM_LINE_STYLE      iGUIStyleLinePrecoMedio    =  STYLE_DASH;                            // Estilo da Linha do Preço Médio



 
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
   objetoController.gIsNewBar = objetoController.ReturnIsNewBar();
   if (iRenkoUse)
   {
      RenkoOffline.Refresh();
      ChartRedraw(0);
   }
   
   if (objetoController.gIsNewBar)
   {
      for (int i = 0; i < objetoController.listIndicador.Size(); i++)
      {
         if (objetoController.listIndicador[i].mUse)
            if (objetoController.listIndicador[i].mRenkoUsar)
            {
               objetoController.listIndicador[i].RenkoOffline.Refresh();
               ChartRedraw(0);
            }
      }
   }
   
   
   Comment(objetoController.gInfo);
   
   objetoController.gProximaEntradaAcima = -1;
   objetoController.gProximaEntradaAbaixo = -1;
   objetoController.RefreshIndicadores();
   objetoController.RefreshResultOpen(false);
   objetoController.RefreshDay();
   objetoController.RefreshGUI();
   objetoController.CheckPosicaoInicial(-1);
   objetoController.CheckNovasPosicoes();
  // objetoController.CheckInverter(false);
   objetoController.CheckLossGain();
   objetoController.CheckCiclo();
   objetoController.CheckCloseLimit();
   objetoController.CheckCloseTime();
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
   
   objetoController.objetoTimeTrade.mUse        =  iTimeTradeUse;
   objetoController.objetoTimeTrade.mStart      =  iTimeTradeStart;
   objetoController.objetoTimeTrade.mEnd        =  iTimeTradeEnd;
   objetoController.objetoTimeTrade.mUseClose   =  iTimeTradeCloseUse;
   objetoController.objetoTimeTrade.mClose      =  iTimeTradeClose;
   
   objetoController.mSleepUse                =  iSleepUse;
   objetoController.mSleepLoss               =  iSleepLoss;
   objetoController.mSleepGain               =  iSleepGain;
   
   objetoController.mTradeAutomaticoManual   =  iTradeAutomaticoManual;
   objetoController.mTradeNormalReverso      =  iTradeNormalReverso;
   objetoController.mTradeCloseNoOpen        =  iTradeCloseNoOpen;
   objetoController.mTradeMagicNumber        =  iTradeMagicNumber;
   objetoController.mTradeMagicNumberLimit   =  iTakeProfitLimitMagic;
   objetoController.mTradeComentario         =  iTradeComentario;
   objetoController.mTradeVolume             =  iTradeVolume;
   objetoController.mTradeVolumeMaximo       =  iTradeVolumeMaximo;
   objetoController.mTradeDistancia          =  iTradeDistancia;
   objetoController.mTradeDistanciaTendencia =  iTradeDistanciaTendencia;
   
   objetoController.mStopTypePreco           =  iStopTypePreco;
   objetoController.mStop                    =  iStop;
   
   objetoController.mTakeProfitTypePreco     =  iTakeProfitTypePreco;
   objetoController.mTakeProfit              =  iTakeProfit;
   objetoController.mTakeProfitType          =  iTakeProfitType;
   
   objetoController.mBreakEvenUse            =  iBreakEvenUse;
   objetoController.mBreakEvenTypePreco      =  iBreakEvenTypePreco;
   objetoController.mBreakEvenTrigger        =  iBreakEvenTrigger;
   objetoController.mBreakEvenStop           =  iBreakEvenStop;
   
   objetoController.mTrailingStopUse         =  iTrailingStopUse;
   objetoController.mTrailingStopTypePreco   =  iTrailingStopTypePreco;
   objetoController.mTrailingStopTrigger     =  iTrailingStopTrigger;
   objetoController.mTrailingStopStop        =  iTrailingStopStop;
   objetoController.mTrailingStopAtualizacao =  iTrainlingStopAtualizacao;
   
   objetoController.mLossPosition            =  iLossPosition;
   objetoController.mLossType                =  iLossType;
   objetoController.mLossDay                 =  iLossDay;
   objetoController.mLossWeek                =  iLossWeek;
   objetoController.mLossMonth               =  iLossMonth;
   
   objetoController.mGainPosition            =  iGainPosition;
   objetoController.mGainType                =  iGainType;
   objetoController.mGainDay                 =  iGainDay;
   objetoController.mGainWeek                =  iGainWeek;
   objetoController.mGainMonth               =  iGainMonth;
   
   objetoController.mCicloUse                =  iCicloUse;
   objetoController.mCicloDataInicial        =  iCicloDataInicial;
   objetoController.mCicloLoss               =  iCicloLoss;
   objetoController.mCicloGain               =  iCicloGain;
   
   objetoController.gOperacaoAberta          =  -1;
   objetoController.objetoTrade.SetExpertMagicNumber(iTradeMagicNumber);
   objetoController.objetoTradeLimit.SetExpertMagicNumber(iTakeProfitLimitMagic);
   
   
   objetoController.listIndicador[0].mUse          =  iIndicador1Usar;
   objetoController.listIndicador[0].mSymbol       =  iIndicador1Symbol;
   objetoController.listIndicador[0].mTimeFrame    =  iIndicador1TimeFrame;
   objetoController.listIndicador[0].mRenkoUsar    =  iIndicador1RenkoUsar;
   objetoController.listIndicador[0].mRenkoSize    =  iIndicador1RenkoSize;
   objetoController.listIndicador[0].mMedia        =  iIndicador1Media;
   objetoController.listIndicador[0].mMacdSinal    =  iIndicador1MacdSinal;
   objetoController.listIndicador[0].mMacdCurta    =  iIndicador1MacdCurta;
   objetoController.listIndicador[0].mMacdLonga    =  iIndicador1MacdLonga;
   
   objetoController.listIndicador[1].mUse          =  iIndicador2Usar;
   objetoController.listIndicador[1].mSymbol       =  iIndicador2Symbol;
   objetoController.listIndicador[1].mTimeFrame    =  iIndicador2TimeFrame;
   objetoController.listIndicador[1].mRenkoUsar    =  iIndicador2RenkoUsar;
   objetoController.listIndicador[1].mRenkoSize    =  iIndicador2RenkoSize;
   objetoController.listIndicador[1].mMedia        =  iIndicador2Media;
   objetoController.listIndicador[1].mMacdSinal    =  iIndicador2MacdSinal;
   objetoController.listIndicador[1].mMacdCurta    =  iIndicador2MacdCurta;
   objetoController.listIndicador[1].mMacdLonga    =  iIndicador2MacdLonga;
   
   objetoController.listIndicador[2].mUse          =  iIndicador3Usar;
   objetoController.listIndicador[2].mSymbol       =  iIndicador3Symbol;
   objetoController.listIndicador[2].mTimeFrame    =  iIndicador3TimeFrame;
   objetoController.listIndicador[2].mRenkoUsar    =  iIndicador3RenkoUsar;
   objetoController.listIndicador[2].mRenkoSize    =  iIndicador3RenkoSize;
   objetoController.listIndicador[2].mMedia        =  iIndicador3Media;
   objetoController.listIndicador[2].mMacdSinal    =  iIndicador3MacdSinal;
   objetoController.listIndicador[2].mMacdCurta    =  iIndicador3MacdCurta;
   objetoController.listIndicador[2].mMacdLonga    =  iIndicador3MacdLonga;
   
   
   for (int i = 0; i<objetoController.listIndicador.Size(); i++)
   {
      objetoController.listIndicador[i].Inicializar();
   }
   
   objetoController.mTradeVolumeDiferenteUse       =  iTradeVolumeDiferenteUse;
   if (objetoController.mTradeVolumeDiferenteUse)
   {
      ExtrairDouble(iTradeVolumeDiferente, objetoController.mTradeVolumeDiferente);
      if (objetoController.mTradeVolumeDiferente.Size() > 0)
      {
         for (int i = 0; i < objetoController.mTradeVolumeDiferente.Size(); i++)
            PrintFormat("Volume: "+DoubleToString(objetoController.mTradeVolumeDiferente[i],2));
      }
   
   }
   
   objetoController.mTradeDistanciaDiferenteUse    =  iTradeDistanciaDiferenteUse;
   if (objetoController.mTradeDistanciaDiferenteUse)
   {
      ExtrairDouble(iTradeDistanciaDiferente, objetoController.mTradeDistanciaDiferente);
      if (objetoController.mTradeDistanciaDiferente.Size() > 0)
      {
         for (int i = 0; i < objetoController.mTradeDistanciaDiferente.Size(); i++)
            PrintFormat("Distância: "+DoubleToString(objetoController.mTradeDistanciaDiferente[i],2));
      }
   
   }
   
   objetoController.mTradeTakeDiferenteUse         =  iTradeTakeDiferenteUse;
   if (objetoController.mTradeTakeDiferenteUse)
   {
      ExtrairDouble(iTradeTakeDiferente, objetoController.mTradeTakeDiferente);
      if (objetoController.mTradeTakeDiferente.Size() > 0)
      {
         for (int i = 0; i < objetoController.mTradeTakeDiferente.Size(); i++)
            PrintFormat("Take: "+DoubleToString(objetoController.mTradeTakeDiferente[i],2));
      }
   }
   
   
   
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
   objetoController.objetoGUI.mCorLinePrecoMedio   =  iGUICorLinePrecoMedio;
   objetoController.objetoGUI.mLinePrecoMedio      =  iGUIStyleLinePrecoMedio;
   
   
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
//| Extrair Volumes                                                  |
//+------------------------------------------------------------------+
void ExtrairDouble(string ativos, double &nomesAtivos[])
{
   string nomeAtivo = "";
   ArrayResize(nomesAtivos, 0);

   // Loop através da string de ativos
   for(int i = 0; i < StringLen(ativos); i++)
   {
      // Verificar se o caractere não é uma vírgula
      if(ativos[i] != '/')
      {
         // Adicionar o caractere ao nome do ativo
         nomeAtivo += ativos.Substr(i,1);
      }
      else
      {
         // Adicionar o nome do ativo ao array
         ArrayResize(nomesAtivos, ArraySize(nomesAtivos) + 1);
         nomesAtivos[ArraySize(nomesAtivos) - 1] = StringToDouble(nomeAtivo);

         // Limpar o nome do ativo para o próximo
         nomeAtivo = "";
      }
   }

   // Adicionar o último nome do ativo, já que a string pode não terminar com vírgula
   ArrayResize(nomesAtivos, ArraySize(nomesAtivos) + 1);
   nomesAtivos[ArraySize(nomesAtivos) - 1] = StringToDouble(nomeAtivo);
}
//+------------------------------------------------------------------+
