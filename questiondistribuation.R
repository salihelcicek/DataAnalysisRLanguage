# Gerekli kütüphaneleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("kableExtra")) install.packages("kableExtra")
library(readxl)
library(dplyr)
library(kableExtra)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu düzenleyin
data <- read_excel(file_path)

# Soru başlıklarını seç
question_headers <- colnames(data)

# Soruları "Q1", "Q2", vb. ile numaralandırarak bir tablo oluştur
questions_table <- data.frame(
  Question_Number = paste0("Q", seq_along(question_headers)),
  Question_Text = question_headers
)

# Tabloyu görselleştir
questions_table %>%
  kbl(col.names = c("Question Number", "Question Text"), align = "c") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = F) %>%
  add_header_above(c("Survey Questions Table" = 2))
