library(ggplot2)
library(glue)

rna_data <- readRDS("output/normalized_data/human_rna.rds")
activity_data <- readRDS("output/normalized_data/human_activity.rds")

gex_vec <- as.numeric(rna_data["MYL6B", , drop = TRUE])
act_vec <- as.numeric(activity_data["MYL6B", , drop = TRUE])

df <- data.frame(
  gex = gex_vec,
  act = act_vec
)


p <- ggplot(df, aes(x=gex, y=act))+geom_point(size=4, color="black")+geom_smooth(method="lm", se=FALSE, color="red", linetype="dashed",linewidth=2)+theme_minimal() +
  labs(x = NULL, y = NULL) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank()
)

ggsave(file=glue("plots/MYL6B.svg"),p, width = 6, height = 4)