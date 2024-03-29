//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Label.mqh>
#include <Controls\ComboBox.mqh>
#include <Controls\Picture.mqh>
#include <Controls\CheckBox.mqh>
//+------------------------------------------------------------------+
//| Class GUI                                                        |
//| Description: GUI Class                                           |
//+------------------------------------------------------------------+
class CGUI
{
   public:
      CGUI();
     ~CGUI();
      
      // Objetos
      CAppDialog           oguiLion;
      // Objetos - Form Principal
      CEdit                oLabelSymbol1;
      CEdit                oLabelSymbol2;
      CEdit                oLabelMagic1;
      CEdit                oLabelMagic2;
      CEdit                oLabelSpread1;
      CEdit                oLabelSpread2;
      CEdit                oLabelVolumeAberto1;
      CEdit                oLabelVolumeAberto2;
      CEdit                oLabelResultadoAberto1;
      CEdit                oLabelResultadoAberto2;
      CEdit                oLabelResultadoDiario1;
      CEdit                oLabelResultadoDiario2;
      CEdit                oLabelResultadoSemanal1;
      CEdit                oLabelResultadoSemanal2;
      CEdit                oLabelResultadoMensal1;
      CEdit                oLabelResultadoMensal2;
      CEdit                oLabelResultadoCiclo1;
      CEdit                oLabelResultadoCiclo2;
      CButton              oBtnComprar;
      CButton              oBtnVender;
      CButton              oBtnZerar;
      CButton              oBtnCancelar;
      CButton              oBtnInverter;
      CButton              oBtnSeparador;
      CEdit                oLabelData;
      // Propriedades
      string               mName;
      int                  mX1;
      int                  mX2;
      int                  mY1;
      int                  mY2;
      int                  mFontSize;
      ENUM_LINE_STYLE      mLinePosicao;
      color                mCorPosicaoCompra;
      color                mCorPosicaoVenda;
      color                mCorStop;
      color                mCorTP;
      ENUM_LINE_STYLE      mLineOrdem;
      color                mCorOrdem;
      color                mCorBox;
      color                mCorBoxText;
      color                mCorLinePrecoMedio;
      ENUM_LINE_STYLE      mLinePrecoMedio;
      
      // Métodos
      // Initialize  
      void                 InicializarGUI();
      // Destroy
      void                 DestroyGUI(int vReason);
      // Create
      void                 CreateLine(string vNome, double vPreco, color vColor, ENUM_LINE_STYLE vStyle);
      void                 CreateBoxInput(string vNome,double vPreco,color vColor,color vColorText,string text);
      // Delete
      void                 DeleteLines();
      void                 DeleteLinesInput();
      void                 DeleteLinesPrecoMedio();
};
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGUI::CGUI(void)
{

}
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CGUI::~CGUI(void)
{
   
}
//+------------------------------------------------------------------+
//| Inicializar GUI                                                  |
//+------------------------------------------------------------------+
void CGUI::InicializarGUI()
{
   oguiLion.Create(0,mName, 0, mX1, mY1, mX2, mY2);
   
   oguiLion.m_background.ColorBackground(C'15,18,37');
   oguiLion.m_client_area.ColorBackground(C'15,18,37');
   oguiLion.m_caption.ColorBackground(C'15,18,37');
   oguiLion.m_caption.Color(clrWhite);
   oguiLion.m_caption.ColorBorder(C'15,18,37');
   
   oLabelSymbol1.Create(0,"oLabelSymbol1",0,10,10,140,30);
   oLabelSymbol1.ColorBackground(C'15,18,37');
   oLabelSymbol1.ColorBorder(C'15,18,37');
   oLabelSymbol1.Color(clrWhite);
   oLabelSymbol1.ReadOnly(true);
   oLabelSymbol1.FontSize(mFontSize);
   oLabelSymbol1.Text("Ativo:");
   oguiLion.Add(oLabelSymbol1);
   
   oLabelSymbol2.Create(0,"oLabelSymbol2",0,150,10,280,30);
   oLabelSymbol2.ColorBackground(C'15,18,37');
   oLabelSymbol2.ColorBorder(C'15,18,37');
   oLabelSymbol2.Color(clrWhite);
   oLabelSymbol2.ReadOnly(true);
   oLabelSymbol2.FontSize(mFontSize);
   oLabelSymbol2.Text(Symbol());
   oLabelSymbol2.TextAlign(ALIGN_RIGHT);
   oguiLion.Add(oLabelSymbol2);
   
   oLabelMagic1.Create(0,"oLabelMagic1",0,10,35,140,55);
   oLabelMagic1.ColorBackground(C'15,18,37');
   oLabelMagic1.ColorBorder(C'15,18,37');
   oLabelMagic1.Color(clrWhite);
   oLabelMagic1.ReadOnly(true);
   oLabelMagic1.FontSize(mFontSize);
   oLabelMagic1.Text("Magic:");
   oguiLion.Add(oLabelMagic1);
   
   oLabelMagic2.Create(0,"oLabelMagic2",0,150,35,280,55);
   oLabelMagic2.ColorBackground(C'15,18,37');
   oLabelMagic2.ColorBorder(C'15,18,37');
   oLabelMagic2.Color(clrWhite);
   oLabelMagic2.ReadOnly(true);
   oLabelMagic2.FontSize(mFontSize);
   oLabelMagic2.Text("-");
   oLabelMagic2.TextAlign(ALIGN_RIGHT);
   oguiLion.Add(oLabelMagic2);
   
   oLabelSpread1.Create(0,"oLabelSpread1",0,10,60,140,80);
   oLabelSpread1.ColorBackground(C'15,18,37');
   oLabelSpread1.ColorBorder(C'15,18,37');
   oLabelSpread1.Color(clrWhite);
   oLabelSpread1.ReadOnly(true);
   oLabelSpread1.FontSize(mFontSize);
   oLabelSpread1.Text("Spread:");
   oguiLion.Add(oLabelSpread1);
   
   oLabelSpread2.Create(0,"oLabelSpread2",0,150,60,280,80);
   oLabelSpread2.ColorBackground(C'15,18,37');
   oLabelSpread2.ColorBorder(C'15,18,37');
   oLabelSpread2.Color(clrWhite);
   oLabelSpread2.ReadOnly(true);
   oLabelSpread2.Text("-");
   oLabelSpread2.TextAlign(ALIGN_RIGHT);
   oLabelSpread2.FontSize(mFontSize);
   oguiLion.Add(oLabelSpread2);
   
   oLabelVolumeAberto1.Create(0,"oLabelVolumeAberto1",0,10,85,140,105);
   oLabelVolumeAberto1.ColorBackground(C'15,18,37');
   oLabelVolumeAberto1.ColorBorder(C'15,18,37');
   oLabelVolumeAberto1.Color(clrWhite);
   oLabelVolumeAberto1.ReadOnly(true);
   oLabelVolumeAberto1.Text("Volume Aberto:");
   oLabelVolumeAberto1.FontSize(mFontSize);
   oguiLion.Add(oLabelVolumeAberto1);
   
   oLabelVolumeAberto2.Create(0,"oLabelVolumeAberto2",0,150,85,280,105);
   oLabelVolumeAberto2.ColorBackground(C'15,18,37');
   oLabelVolumeAberto2.ColorBorder(C'15,18,37');
   oLabelVolumeAberto2.Color(clrWhite);
   oLabelVolumeAberto2.ReadOnly(true);
   oLabelVolumeAberto2.Text("0.00");
   oLabelVolumeAberto2.TextAlign(ALIGN_RIGHT);
   oLabelVolumeAberto2.FontSize(mFontSize);
   oguiLion.Add(oLabelVolumeAberto2);
   
   oLabelResultadoAberto1.Create(0,"oLabelResultadoAberto1",0,10,110,140,130);
   oLabelResultadoAberto1.ColorBackground(C'15,18,37');
   oLabelResultadoAberto1.ColorBorder(C'15,18,37');
   oLabelResultadoAberto1.Color(clrWhite);
   oLabelResultadoAberto1.ReadOnly(true);
   oLabelResultadoAberto1.Text("Resultado Aberto:");
   oLabelResultadoAberto1.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoAberto1);
   
   oLabelResultadoAberto2.Create(0,"oLabelResultadoAberto2",0,150,110,280,130);
   oLabelResultadoAberto2.ColorBackground(C'15,18,37');
   oLabelResultadoAberto2.ColorBorder(C'15,18,37');
   oLabelResultadoAberto2.Color(clrWhite);
   oLabelResultadoAberto2.ReadOnly(true);
   oLabelResultadoAberto2.Text("0.00");
   oLabelResultadoAberto2.TextAlign(ALIGN_RIGHT);
   oLabelResultadoAberto2.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoAberto2);
   
   oLabelResultadoDiario1.Create(0,"oLabelResultadoDiario1",0,10,135,140,155);
   oLabelResultadoDiario1.ColorBackground(C'15,18,37');
   oLabelResultadoDiario1.ColorBorder(C'15,18,37');
   oLabelResultadoDiario1.Color(clrWhite);
   oLabelResultadoDiario1.ReadOnly(true);
   oLabelResultadoDiario1.Text("Resultado Diário:");
   oLabelResultadoDiario1.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoDiario1);
   
   oLabelResultadoDiario2.Create(0,"oLabelResultadoDiario2",0,150,135,280,155);
   oLabelResultadoDiario2.ColorBackground(C'15,18,37');
   oLabelResultadoDiario2.ColorBorder(C'15,18,37');
   oLabelResultadoDiario2.Color(clrWhite);
   oLabelResultadoDiario2.ReadOnly(true);
   oLabelResultadoDiario2.Text("0.00");
   oLabelResultadoDiario2.TextAlign(ALIGN_RIGHT);
   oLabelResultadoDiario2.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoDiario2);
   
   oLabelResultadoSemanal1.Create(0,"oLabelResultadoSemanal1",0,10,160,140,180);
   oLabelResultadoSemanal1.ColorBackground(C'15,18,37');
   oLabelResultadoSemanal1.ColorBorder(C'15,18,37');
   oLabelResultadoSemanal1.Color(clrWhite);
   oLabelResultadoSemanal1.ReadOnly(true);
   oLabelResultadoSemanal1.Text("Resultado Semanal:");
   oLabelResultadoSemanal1.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoSemanal1);
   
   oLabelResultadoSemanal2.Create(0,"oLabelResultadoSemanal2",0,150,160,280,180);
   oLabelResultadoSemanal2.ColorBackground(C'15,18,37');
   oLabelResultadoSemanal2.ColorBorder(C'15,18,37');
   oLabelResultadoSemanal2.Color(clrWhite);
   oLabelResultadoSemanal2.ReadOnly(true);
   oLabelResultadoSemanal2.Text("0.00");
   oLabelResultadoSemanal2.TextAlign(ALIGN_RIGHT);
   oLabelResultadoSemanal2.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoSemanal2);
   
   oLabelResultadoMensal1.Create(0,"oLabelResultadoMensal1",0,10,185,140,205);
   oLabelResultadoMensal1.ColorBackground(C'15,18,37');
   oLabelResultadoMensal1.ColorBorder(C'15,18,37');
   oLabelResultadoMensal1.Color(clrWhite);
   oLabelResultadoMensal1.ReadOnly(true);
   oLabelResultadoMensal1.Text("Resultado Mensal:");
   oLabelResultadoMensal1.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoMensal1);
   
   oLabelResultadoMensal2.Create(0,"oLabelResultadoMensal2",0,150,185,280,205);
   oLabelResultadoMensal2.ColorBackground(C'15,18,37');
   oLabelResultadoMensal2.ColorBorder(C'15,18,37');
   oLabelResultadoMensal2.Color(clrWhite);
   oLabelResultadoMensal2.ReadOnly(true);
   oLabelResultadoMensal2.Text("0.00");
   oLabelResultadoMensal2.TextAlign(ALIGN_RIGHT);
   oLabelResultadoMensal2.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoMensal2);
   
   oLabelResultadoCiclo1.Create(0,"oLabelResultadoCiclo1",0,10,210,140,230);
   oLabelResultadoCiclo1.ColorBackground(C'15,18,37');
   oLabelResultadoCiclo1.ColorBorder(C'15,18,37');
   oLabelResultadoCiclo1.Color(clrWhite);
   oLabelResultadoCiclo1.ReadOnly(true);
   oLabelResultadoCiclo1.Text("Resultado Ciclo:");
   oLabelResultadoCiclo1.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoCiclo1);
   
   oLabelResultadoCiclo2.Create(0,"oLabelResultadoCiclo2",0,150,210,280,230);
   oLabelResultadoCiclo2.ColorBackground(C'15,18,37');
   oLabelResultadoCiclo2.ColorBorder(C'15,18,37');
   oLabelResultadoCiclo2.Color(clrWhite);
   oLabelResultadoCiclo2.ReadOnly(true);
   oLabelResultadoCiclo2.Text("0.00");
   oLabelResultadoCiclo2.TextAlign(ALIGN_RIGHT);
   oLabelResultadoCiclo2.FontSize(mFontSize);
   oguiLion.Add(oLabelResultadoCiclo2);
   
   oBtnVender.Create(0,"oBtnVender",0,10,280,140,310);
   oBtnVender.ColorBackground(clrRed);
   oBtnVender.Color(clrWhite);
   oBtnVender.FontSize(mFontSize);
   oBtnVender.Text("Vender");
   oBtnVender.FontSize(mFontSize);
   oguiLion.Add(oBtnVender);
   
   oBtnComprar.Create(0,"oBtnComprar",0,150,280,280,310);
   oBtnComprar.ColorBackground(clrBlue);
   oBtnComprar.Color(clrWhite);
   oBtnComprar.FontSize(mFontSize);
   oBtnComprar.Text("Comprar");
   oBtnComprar.FontSize(mFontSize);
   oguiLion.Add(oBtnComprar);
   
   oBtnZerar.Create(0,"oBtnZerar",0,10,320,280,350);
   oBtnZerar.ColorBackground(clrGray);
   oBtnZerar.Color(clrWhite);
   oBtnZerar.FontSize(mFontSize);
   oBtnZerar.Text("Zerar Ordens");
   oBtnZerar.FontSize(mFontSize);
   oguiLion.Add(oBtnZerar);
   
   oBtnCancelar.Create(0,"oBtnCancelar",0,10,360,280,390);
   oBtnCancelar.ColorBackground(clrGray);
   oBtnCancelar.Color(clrWhite);
   oBtnCancelar.FontSize(mFontSize);
   oBtnCancelar.Text("Cancelar Ordens");
   oBtnCancelar.FontSize(mFontSize);
   oguiLion.Add(oBtnCancelar);
   
   oBtnInverter.Create(0,"oBtnInverter",0,10,400,280,430);
   oBtnInverter.ColorBackground(clrGray);
   oBtnInverter.Color(clrWhite);
   oBtnInverter.FontSize(mFontSize);
   oBtnInverter.Text("Inverter");
   oBtnInverter.FontSize(mFontSize);
   oguiLion.Add(oBtnInverter);
   
   oBtnSeparador.Create(0,"oBtnSeparador",0,10,439,280,440);
   oBtnSeparador.ColorBackground(clrWhite);
   oBtnSeparador.ColorBorder(clrWhite);
   oBtnSeparador.FontSize(mFontSize);
   oguiLion.Add(oBtnSeparador);
   
   oLabelData.Create(0,"oLabelData",0,10,445,280,465);
   oLabelData.ColorBackground(C'15,18,37');
   oLabelData.ColorBorder(C'15,18,37');
   oLabelData.Color(clrWhite);
   oLabelData.ReadOnly(true);
   oLabelData.FontSize(mFontSize);
   oLabelData.Text("01/01/2024 - 09:00:00 - 05:00");
   oguiLion.Add(oLabelData);
   
}
//+------------------------------------------------------------------+
//| Destroy GUI                                                      |
//+------------------------------------------------------------------+
void CGUI::DestroyGUI(int vReason)
{
   oguiLion.Destroy(vReason);
}
//+------------------------------------------------------------------+
//| Create Line                                                      |
//+------------------------------------------------------------------+
void CGUI::CreateLine(string vNome,double vPreco,color vColor,ENUM_LINE_STYLE vStyle)
{
   if (!ObjectCreate(0,vNome,OBJ_HLINE,0,0,vPreco))
      PrintFormat("Erro ao criar linha "+vNome);
   else
   {
      ObjectSetInteger(0,vNome,OBJPROP_COLOR,vColor);
      ObjectSetInteger(0,vNome,OBJPROP_STYLE,vStyle);
      ObjectSetDouble(0,vNome,OBJPROP_PRICE,vPreco);
      ObjectSetInteger(0,vNome,OBJPROP_BACK, true);
      ObjectSetInteger(0,vNome,OBJPROP_ZORDER,-1);
      ChartRedraw(0);
   }
}
//+------------------------------------------------------------------+
//| Create Box Input Price                                           |
//+------------------------------------------------------------------+
void CGUI::CreateBoxInput(string vNome,double vPreco,color vColor,color vColorText,string text)
{
   if (!ObjectCreate(0,vNome,OBJ_BUTTON,0,TimeCurrent(),vPreco))
      PrintFormat("Erro ao criar box de preço de entrada");
   else
   {
      int add = 0;
         
      int x,y;
      ChartTimePriceToXY(0,0,TimeCurrent(),vPreco,x,y);
      
      ObjectSetInteger(0,vNome,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,vNome,OBJPROP_XSIZE,160);
      ObjectSetInteger(0,vNome,OBJPROP_YSIZE,16);
      ObjectSetString(0,vNome,OBJPROP_TEXT,text);
      ObjectSetInteger(0,vNome,OBJPROP_FONTSIZE,mFontSize);
      ObjectSetInteger(0,vNome,OBJPROP_BGCOLOR,vColor);
      ObjectSetInteger(0,vNome,OBJPROP_COLOR,vColorText);
      ObjectSetInteger(0,vNome,OBJPROP_BORDER_COLOR,vColor);
      ObjectSetInteger(0,vNome,OBJPROP_FONTSIZE,8);
      ObjectSetInteger(0,vNome,OBJPROP_YDISTANCE,y-8);
         ObjectSetInteger(0,vNome,OBJPROP_XDISTANCE,160);
      
      ChartRedraw(0);
   }
}
//+------------------------------------------------------------------+
//| Delete Lines                                                     |
//+------------------------------------------------------------------+
void CGUI::DeleteLines(void)
{
   ObjectsDeleteAll(0,"order",0,-1);
   ObjectsDeleteAll(0,"position",0,-1);
}
//+------------------------------------------------------------------+
//| Delete Lines                                                     |
//+------------------------------------------------------------------+
void CGUI::DeleteLinesInput(void)
{
   ObjectsDeleteAll(0,"input",0,-1);
}
//+------------------------------------------------------------------+
//| Delete Lines Preco Medio                                         |
//+------------------------------------------------------------------+
void CGUI::DeleteLinesPrecoMedio(void)
{
   ObjectsDeleteAll(0,"precoMedio",0,-1);
}