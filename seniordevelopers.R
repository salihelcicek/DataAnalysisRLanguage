# Gerekli kütüphaneleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
library(readxl)
library(ggplot2)
library(dplyr)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu kontrol edin
data <- read_excel(file_path)

# Sütun isimlerini anlamlı şekilde yeniden adlandır
colnames(data) <- c(
  "Experience", 
  "Role", 
  "Use_AI_Tools", 
  "Coding_Assistants", 
  "Knowledge_Loss", 
  "Code_Modification", 
  "Problem_Solving", 
  "Impact_Juniors", 
  "Focus_Seniors", 
  "Collaboration_Teamwork"
)

# Focus_Seniors sütununu sayısal değerlere dönüştürmek için Likert ölçeği oluştur
likert_scale <- c("Strongly Disagree" = 1, "Disagree" = 2, "Neutral" = 3, "Agree" = 4, "Strongly Agree" = 5)
data$Focus_Seniors_Score <- likert_scale[data$Focus_Seniors]

# Her bir rol için ortalama skor hesapla
lollipop_data <- data %>%
  group_by(Role) %>%
  summarise(Average_Score = mean(Focus_Seniors_Score, na.rm = TRUE)) %>%
  arrange(Average_Score)

# Lollipop chart oluştur
ggplot(lollipop_data, aes(x = Average_Score, y = reorder(Role, Average_Score))) +
  geom_segment(aes(x = 0, xend = Average_Score, y = Role, yend = Role), color = "gray") +
  geom_point(size = 5, color = "steelblue") +
  labs(title = "AI Tools Helping Senior Developers Focus on High-Level Tasks",
       x = "Average Score",
       y = "Role") +
  scale_x_continuous(breaks = 1:5, labels = names(likert_scale)) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
        plot.title = element_text(hjust = 0.5, face = "bold"))
