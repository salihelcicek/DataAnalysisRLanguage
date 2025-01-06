# Gerekli paketleri yükle
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("readxl")) install.packages("readxl")
library(ggplot2)
library(readxl)

# Excel dosyasını yükle
# Dosyanın yolunu güncelle (örneğin: "survey.xlsx")
file_path <- "survey (2) (1).xlsx"
data <- read_excel(file_path)

# Sütun isimlerini düzenle (Türkçe karakterler veya boşlukları kaldır)
colnames(data) <- c("Experience", "Role", "Use_AI_Tools", "Coding_Assistants",
                    "Knowledge_Loss", "Code_Modification", "Problem_Solving",
                    "Impact_Juniors", "Focus_Seniors", "Collaboration_Teamwork")

# Çubuk grafiği oluştur
ggplot(data, aes(x = Experience, fill = Knowledge_Loss)) +
  geom_bar(position = "dodge") +
  labs(title = "Impact of AI Tools on Knowledge Loss by Experience Level",
       x = "Years of Experience",
       y = "Count",
       fill = "Knowledge Loss") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))





