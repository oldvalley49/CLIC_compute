library(ggplot2)

mouse <- read.csv("output/scores/mouse_scores.csv")
human <- read.csv("output/scores/human_scores.csv")

p <- ggplot(mouse, aes(x = pearson_correlation)) +
  geom_density(fill = "steelblue") +
  theme_minimal()


ggsave("plots/mouse_score_density.svg", plot = p, width = 12, height = 6)


mouse$source <- "mouse"
human$source <- "human"

combined <- rbind(human, mouse)
p <- ggplot(combined, aes(x=source, y = pearson_correlation, fill=source)) +
        geom_violin() +
        theme(
           panel.background = element_rect(fill = "transparent", color = NA)
        )+ 
        labs(title = "Distribution of CLIC scores across species", x="", y="CLIC score")
ggsave("/dcs07/hongkai/data/tomo/CLIC_score/plots/score_vln.jpeg")

p <- ggplot(mouse, aes(x = pearson_correlation, fill=source)) +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA)
  ) +
  labs(
    title = "Distribution of CLIC scores across species",
    x = "CLIC score",
    y = "Density"
  )

p <- ggplot(combined, aes(x = pearson_correlation)) +
  geom_histogram(position = "identity", alpha = 0.5, bins = 30)

ggsave("plots/mouse_score_density.jpeg", plot = p, width = 12, height = 6)