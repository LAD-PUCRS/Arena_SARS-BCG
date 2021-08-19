# Configurando o diretório de trabalho 
setwd("/root/imunocovid/posProcessamento_R")
library(pvclust)

## Seleção de HLAs
#file_list <- list.files(path="/root/imunocovid/posProcessamento_R/CSV_Examples")
#dataset <- data.frame()

#for(i in 1:length(file_list)){
  ##leitura do arquivo - especifique quais colunas precisa ler para evitar quaisquer erros
#  temp_data <- read.csv(file_list[i], header=TRUE, row.names = 1)
temp_data <- read.csv("final.csv", header=TRUE, row.names = 1)

##removendo colunas Xarea (sem variância)
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
	"G46_Rmean", "G46_RstdDev", "G46_Gmean", "G46_GstdDev", "G46_Bmean", "G46_BstdDev",
	"G47_Rmean", "G47_RstdDev", "G47_Gmean", "G47_GstdDev", "G47_Bmean", "G47_BstdDev",
	"G48_Rmean", "G48_RstdDev", "G48_Gmean", "G48_GstdDev", "G48_Bmean", "G48_BstdDev",
	"G49_Rmean", "G49_RstdDev", "G49_Gmean", "G49_GstdDev", "G49_Bmean", "G49_BstdDev",
	"G50_Rmean", "G50_RstdDev", "G50_Gmean", "G50_GstdDev", "G50_Bmean", "G50_BstdDev",
	"G51_Rmean", "G51_RstdDev", "G51_Gmean", "G51_GstdDev", "G51_Bmean", "G51_BstdDev",
	"G52_Rmean", "G52_RstdDev", "G52_Gmean", "G52_GstdDev", "G52_Bmean", "G52_BstdDev",
	"G53_Rmean", "G53_RstdDev", "G53_Gmean", "G53_GstdDev", "G53_Bmean", "G53_BstdDev",
	"G54_Rmean", "G54_RstdDev", "G54_Gmean", "G54_GstdDev", "G54_Bmean", "G54_BstdDev",
	"G55_Rmean", "G55_RstdDev", "G55_Gmean", "G55_GstdDev", "G55_Bmean", "G55_BstdDev",
	"G56_Rmean", "G56_RstdDev", "G56_Gmean", "G56_GstdDev", "G56_Bmean", "G56_BstdDev",
	"G57_Rmean", "G57_RstdDev", "G57_Gmean", "G57_GstdDev", "G57_Bmean", "G57_BstdDev",
	"G58_Rmean", "G58_RstdDev", "G58_Gmean", "G58_GstdDev", "G58_Bmean", "G58_BstdDev",
	"G59_Rmean", "G59_RstdDev", "G59_Gmean", "G59_GstdDev", "G59_Bmean", "G59_BstdDev",
	"G60_Rmean", "G60_RstdDev", "G60_Gmean", "G60_GstdDev", "G60_Bmean", "G60_BstdDev",
	"G61_Rmean", "G61_RstdDev", "G61_Gmean", "G61_GstdDev", "G61_Bmean", "G61_BstdDev",
	"G62_Rmean", "G62_RstdDev", "G62_Gmean", "G62_GstdDev", "G62_Bmean", "G62_BstdDev",
	"G63_Rmean", "G63_RstdDev", "G63_Gmean", "G63_GstdDev", "G63_Bmean", "G63_BstdDev",
	"G64_Rmean", "G64_RstdDev", "G64_Gmean", "G64_GstdDev", "G64_Bmean", "G64_BstdDev",
	"G65_Rmean", "G65_RstdDev", "G65_Gmean", "G65_GstdDev", "G65_Bmean", "G65_BstdDev",
	"G66_Rmean", "G66_RstdDev", "G66_Gmean", "G66_GstdDev", "G66_Bmean", "G66_BstdDev",
	"G67_Rmean", "G67_RstdDev", "G67_Gmean", "G67_GstdDev", "G67_Bmean", "G67_BstdDev",
	"G68_Rmean", "G68_RstdDev", "G68_Gmean", "G68_GstdDev", "G68_Bmean", "G68_BstdDev",
	"G69_Rmean", "G69_RstdDev", "G69_Gmean", "G69_GstdDev", "G69_Bmean", "G69_BstdDev",
	"G70_Rmean", "G70_RstdDev", "G70_Gmean", "G70_GstdDev", "G70_Bmean", "G70_BstdDev",
	"G71_Rmean", "G71_RstdDev", "G71_Gmean", "G71_GstdDev", "G71_Bmean", "G71_BstdDev",
	"G72_Rmean", "G72_RstdDev", "G72_Gmean", "G72_GstdDev", "G72_Bmean", "G72_BstdDev",
	"G73_Rmean", "G73_RstdDev", "G73_Gmean", "G73_GstdDev", "G73_Bmean", "G73_BstdDev",
	"G74_Rmean", "G74_RstdDev", "G74_Gmean", "G74_GstdDev", "G74_Bmean", "G74_BstdDev",
	"G75_Rmean", "G75_RstdDev", "G75_Gmean", "G75_GstdDev", "G75_Bmean", "G75_BstdDev",
	"G76_Rmean", "G76_RstdDev", "G76_Gmean", "G76_GstdDev", "G76_Bmean", "G76_BstdDev",
	"G77_Rmean", "G77_RstdDev", "G77_Gmean", "G77_GstdDev", "G77_Bmean", "G77_BstdDev",
	"G78_Rmean", "G78_RstdDev", "G78_Gmean", "G78_GstdDev", "G78_Bmean", "G78_BstdDev",
	"G79_Rmean", "G79_RstdDev", "G79_Gmean", "G79_GstdDev", "G79_Bmean", "G79_BstdDev",
	"G80_Rmean", "G80_RstdDev", "G80_Gmean", "G80_GstdDev", "G80_Bmean", "G80_BstdDev",
	"G81_Rmean", "G81_RstdDev", "G81_Gmean", "G81_GstdDev", "G81_Bmean", "G81_BstdDev",
	"G82_Rmean", "G82_RstdDev", "G82_Gmean", "G82_GstdDev", "G82_Bmean", "G82_BstdDev",
	"G83_Rmean", "G83_RstdDev", "G83_Gmean", "G83_GstdDev", "G83_Bmean", "G83_BstdDev",
	"G84_Rmean", "G84_RstdDev", "G84_Gmean", "G84_GstdDev", "G84_Bmean", "G84_BstdDev",
	"G85_Rmean", "G85_RstdDev", "G85_Gmean", "G85_GstdDev", "G85_Bmean", "G85_BstdDev",
	"G86_Rmean", "G86_RstdDev", "G86_Gmean", "G86_GstdDev", "G86_Bmean", "G86_BstdDev",
	"G87_Rmean", "G87_RstdDev", "G87_Gmean", "G87_GstdDev", "G87_Bmean", "G87_BstdDev",
	"G88_Rmean", "G88_RstdDev", "G88_Gmean", "G88_GstdDev", "G88_Bmean", "G88_BstdDev",
	"G89_Rmean", "G89_RstdDev", "G89_Gmean", "G89_GstdDev", "G89_Bmean", "G89_BstdDev",
	"G90_Rmean", "G90_RstdDev", "G90_Gmean", "G90_GstdDev", "G90_Bmean", "G90_BstdDev",
	"G91_Rmean", "G91_RstdDev", "G91_Gmean", "G91_GstdDev", "G91_Bmean", "G91_BstdDev",
	"G92_Rmean", "G92_RstdDev", "G92_Gmean", "G92_GstdDev", "G92_Bmean", "G92_BstdDev",
	"G93_Rmean", "G93_RstdDev", "G93_Gmean", "G93_GstdDev", "G93_Bmean", "G93_BstdDev",
	"G94_Rmean", "G94_RstdDev", "G94_Gmean", "G94_GstdDev", "G94_Bmean", "G94_BstdDev",
	"G95_Rmean", "G95_RstdDev", "G95_Gmean", "G95_GstdDev", "G95_Bmean", "G95_BstdDev",
	"G96_Rmean", "G96_RstdDev", "G96_Gmean", "G96_GstdDev", "G96_Bmean", "G96_BstdDev",
	"G97_Rmean", "G97_RstdDev", "G97_Gmean", "G97_GstdDev", "G97_Bmean", "G97_BstdDev",
	"G98_Rmean", "G98_RstdDev", "G98_Gmean", "G98_GstdDev", "G98_Bmean", "G98_BstdDev",
	"G99_Rmean", "G99_RstdDev", "G99_Gmean", "G99_GstdDev", "G99_Bmean", "G99_BstdDev",
	"G100_Rmean", "G100_RstdDev", "G100_Gmean", "G100_GstdDev", "G100_Bmean", "G100_BstdDev"
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
#}
