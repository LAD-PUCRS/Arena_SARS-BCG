# Configurando o diretório de trabalho 
setwd("/root/imunocovid/posProcessamento_R")
library(pvclust)

#leitura do arquivo gerado no transpose - especifique quais colunas precisa ler para evitar quaisquer erros
temp_data <- read.csv("final.csv", header=TRUE, row.names = 1)

#Definindo colunas que serão avaliadas pelo pvclust
dataset_hca <- temp_data[colnames(temp_data) %in% c(
	"G1_Rmean", "G1_RstdDev", "G1_Gmean", "G1_GstdDev", "G1_Bmean", "G1_BstdDev",
	"G2_Rmean", "G2_RstdDev", "G2_Gmean", "G2_GstdDev", "G2_Bmean", "G2_BstdDev",
	"G3_Rmean", "G3_RstdDev", "G3_Gmean", "G3_GstdDev", "G3_Bmean", "G3_BstdDev",
	"G4_Rmean", "G4_RstdDev", "G4_Gmean", "G4_GstdDev", "G4_Bmean", "G4_BstdDev",
	"G5_Rmean", "G5_RstdDev", "G5_Gmean", "G5_GstdDev", "G5_Bmean", "G5_BstdDev",
	"G6_Rmean", "G6_RstdDev", "G6_Gmean", "G6_GstdDev", "G6_Bmean", "G6_BstdDev",
	"G7_Rmean", "G7_RstdDev", "G7_Gmean", "G7_GstdDev", "G7_Bmean", "G7_BstdDev",
	"G8_Rmean", "G8_RstdDev", "G8_Gmean", "G8_GstdDev", "G8_Bmean", "G8_BstdDev",
	"G9_Rmean", "G9_RstdDev", "G9_Gmean", "G9_GstdDev", "G9_Bmean", "G9_BstdDev",
	"G10_Rmean", "G10_RstdDev", "G10_Gmean", "G10_GstdDev", "G10_Bmean", "G10_BstdDev",
	"G11_Rmean", "G11_RstdDev", "G11_Gmean", "G11_GstdDev", "G11_Bmean", "G11_BstdDev",
	"G12_Rmean", "G12_RstdDev", "G12_Gmean", "G12_GstdDev", "G12_Bmean", "G12_BstdDev",
	"G13_Rmean", "G13_RstdDev", "G13_Gmean", "G13_GstdDev", "G13_Bmean", "G13_BstdDev",
	"G14_Rmean", "G14_RstdDev", "G14_Gmean", "G14_GstdDev", "G14_Bmean", "G14_BstdDev",
	"G15_Rmean", "G15_RstdDev", "G15_Gmean", "G15_GstdDev", "G15_Bmean", "G15_BstdDev",
	"G16_Rmean", "G16_RstdDev", "G16_Gmean", "G16_GstdDev", "G16_Bmean", "G16_BstdDev",
	"G17_Rmean", "G17_RstdDev", "G17_Gmean", "G17_GstdDev", "G17_Bmean", "G17_BstdDev",
	"G18_Rmean", "G18_RstdDev", "G18_Gmean", "G18_GstdDev", "G18_Bmean", "G18_BstdDev",
	"G19_Rmean", "G19_RstdDev", "G19_Gmean", "G19_GstdDev", "G19_Bmean", "G19_BstdDev",
	"G20_Rmean", "G20_RstdDev", "G20_Gmean", "G20_GstdDev", "G20_Bmean", "G20_BstdDev",
	"G21_Rmean", "G21_RstdDev", "G21_Gmean", "G21_GstdDev", "G21_Bmean", "G21_BstdDev",
	"G22_Rmean", "G22_RstdDev", "G22_Gmean", "G22_GstdDev", "G22_Bmean", "G22_BstdDev",
	"G23_Rmean", "G23_RstdDev", "G23_Gmean", "G23_GstdDev", "G23_Bmean", "G23_BstdDev",
	"G24_Rmean", "G24_RstdDev", "G24_Gmean", "G24_GstdDev", "G24_Bmean", "G24_BstdDev",
	"G25_Rmean", "G25_RstdDev", "G25_Gmean", "G25_GstdDev", "G25_Bmean", "G25_BstdDev",
	"G26_Rmean", "G26_RstdDev", "G26_Gmean", "G26_GstdDev", "G26_Bmean", "G26_BstdDev",
	"G27_Rmean", "G27_RstdDev", "G27_Gmean", "G27_GstdDev", "G27_Bmean", "G27_BstdDev",
	"G28_Rmean", "G28_RstdDev", "G28_Gmean", "G28_GstdDev", "G28_Bmean", "G28_BstdDev",
	"G29_Rmean", "G29_RstdDev", "G29_Gmean", "G29_GstdDev", "G29_Bmean", "G29_BstdDev",
	"G30_Rmean", "G30_RstdDev", "G30_Gmean", "G30_GstdDev", "G30_Bmean", "G30_BstdDev",
	"G31_Rmean", "G31_RstdDev", "G31_Gmean", "G31_GstdDev", "G31_Bmean", "G31_BstdDev",
	"G32_Rmean", "G32_RstdDev", "G32_Gmean", "G32_GstdDev", "G32_Bmean", "G32_BstdDev",
	"G33_Rmean", "G33_RstdDev", "G33_Gmean", "G33_GstdDev", "G33_Bmean", "G33_BstdDev",
	"G34_Rmean", "G34_RstdDev", "G34_Gmean", "G34_GstdDev", "G34_Bmean", "G34_BstdDev",
	"G35_Rmean", "G35_RstdDev", "G35_Gmean", "G35_GstdDev", "G35_Bmean", "G35_BstdDev",
	"G36_Rmean", "G36_RstdDev", "G36_Gmean", "G36_GstdDev", "G36_Bmean", "G36_BstdDev",
	"G37_Rmean", "G37_RstdDev", "G37_Gmean", "G37_GstdDev", "G37_Bmean", "G37_BstdDev",
	"G38_Rmean", "G38_RstdDev", "G38_Gmean", "G38_GstdDev", "G38_Bmean", "G38_BstdDev",
	"G39_Rmean", "G39_RstdDev", "G39_Gmean", "G39_GstdDev", "G39_Bmean", "G39_BstdDev",
	"G40_Rmean", "G40_RstdDev", "G40_Gmean", "G40_GstdDev", "G40_Bmean", "G40_BstdDev",
	"G41_Rmean", "G41_RstdDev", "G41_Gmean", "G41_GstdDev", "G41_Bmean", "G41_BstdDev",
	"G42_Rmean", "G42_RstdDev", "G42_Gmean", "G42_GstdDev", "G42_Bmean", "G42_BstdDev",
	"G43_Rmean", "G43_RstdDev", "G43_Gmean", "G43_GstdDev", "G43_Bmean", "G43_BstdDev",
	"G44_Rmean", "G44_RstdDev", "G44_Gmean", "G44_GstdDev", "G44_Bmean", "G44_BstdDev",
	"G45_Rmean", "G45_RstdDev", "G45_Gmean", "G45_GstdDev", "G45_Bmean", "G45_BstdDev",
	"G46_Rmean", "G46_RstdDev", "G46_Gmean", "G46_GstdDev", "G46_Bmean", "G46_BstdDev"
)]

##se estiver interessado em agrupar "Rmin", "Rmax", ... os grupos comentam a próxima linha com apenas um #,
##e altere "dataset_hca_tranposed" por "dataset_hca" na função pvclust
dataset_hca_transposed <- t(dataset_hca)
  
##clustering - use seus próprios parâmetros
hca <- pvclust(dataset_hca_transposed, method.hclust="average",
       method.dist="correlation", use.cor="pairwise.complete.obs",
       nboot=1000, parallel=TRUE, r=seq(.5,1.4,by=.1),
       store=FALSE, weight=FALSE, iseed=NULL, quiet=FALSE)
  
##ploting 
plot <- plot(hca, print.pv=TRUE, print.num=TRUE, float=0.01,
            col.pv=c(si=4, au=2, bp=3, edge=8), cex.pv=0.8, font.pv=NULL,
            col=NULL, cex=NULL, font=NULL, lty=NULL, lwd=NULL, main=NULL,
            sub=NULL, xlab=NULL)
  
pvrect(hca,alpha=0.95)
