library(tidyverse)
library(readxl)
SALDO_FINAL_MAIOR_QUE_ZERO_27_02 <- read_excel("SALDO_FINAL_MAIOR_QUE_ZERO_27_02.xlsx")


# Fazendo planilha apenas com razão social, raiz CNPJ e total dos débitos em aberto por raiz.
sald_fin <- SALDO_FINAL_MAIOR_QUE_ZERO_27_02 %>% select(c(9, 1, 6, 7, 58)) %>% 
  group_by(no_razao, raiz) %>% summarise( Total_por_raiz = sum(c_sal_final)) %>%
  arrange(desc(Total_por_raiz))

write.csv2(sald_fin, "sald_fin.csv")


# Fazendo planilha com razão social, raiz CNPJ, tipo de tributo (ICMS ou FECP).
sald_discr <- SALDO_FINAL_MAIOR_QUE_ZERO_27_02 %>% select(c(9, 1, 4, 7, 6, 54, 55)) %>% 
  gather("ICMS X FECP", "Débitos em aberto", -c(1:5)) %>% 
  unite_(col ='Mês-Ano', c("me_referencia", "an_referencia"), sep = "-", remove = TRUE) 

write.csv2(sald_discr, "sald_discr.csv")
