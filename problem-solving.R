

# Gerekli paketleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
library(readxl)
library(ggplot2)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu güncelle
data <- read_excel(file_path)

# Sütun isimlerini düzenle
colnames(data) <- c("Experience", "Role", "Use_AI_Tools", "Coding_Assistants",
                    "Knowledge_Loss", "Code_Modification", "Problem_Solving",
                    "Impact_Juniors", "Focus_Seniors", "Collaboration_Teamwork")

# Problem-Solving kategorilerini sıralı hale getir ve eksik seviyeleri ekle
data$Problem_Solving <- factor(data$Problem_Solving, 
                               levels = c("Strongly agree", "Agree", "Neutral", 
                                          "Disagree", "Strongly disagree"),
                               ordered = TRUE)


# Stacked bar chart oluştur
ggplot(data, aes(x = Role, fill = Problem_Solving)) +
  geom_bar(position = "stack", width = 0.7) +  # Bar genişliğini ayarla
  scale_fill_manual(values = c("#4B0082", "#8A2BE2", "#6495ED", "#FFA07A", "#DC143C")) + # coolwarm renk paleti
  labs(title = "Impact of AI Tools on Problem-Solving Skills by Role",
       x = "Role", y = "Count", fill = "Problem-Solving Improvement") +
  theme_minimal(base_size = 14) +  # Genel yazı boyutunu artır
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1, size = 12),  # X ekseni yazı boyutunu ayarla
    axis.text.y = element_text(size = 12),  # Y ekseni yazı boyutunu ayarla
    axis.title = element_text(size = 14),  # Eksen başlıklarını büyüt
    legend.text = element_text(size = 12),  # Lejant yazı boyutunu ayarla
    legend.title = element_text(size = 14),  # Lejant başlık yazı boyutunu büyüt
    plot.title = element_text(size = 16, hjust = 0.5, face = "bold")  # Başlığı ortala ve büyüt
  )
