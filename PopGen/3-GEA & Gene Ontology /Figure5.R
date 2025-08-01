### Figure 5 #####

setwd ("/Users/carolesmadja/WORK/DOCS/PUBLICATIONS/2025_Rhabdo_popgenRADseq/VERSION_2/Figures/versions-modifiables")


# With dot size proportional to 'Gene number'

library(ggplot2)
library(readxl)
library(dplyr)
library(forcats)
library(ggtext)

# Load data
data <- read_excel("data-enrichment-aridity-associated.xlsx")

# Filter and process
significant <- data %>%
  filter(`Adjusted p-value` < 0.05) %>%
  mutate(
    logp = -log10(`Adjusted p-value`),
    Pathway = case_when(
      `Physiological pathway of interest` == "Neurotransmission" ~ "Neurotransmission",
      `Physiological pathway of interest` == "Transcription regulation" ~ "Transcription regulation",
      is.na(`Physiological pathway of interest`) ~ "Other",
      TRUE ~ `Physiological pathway of interest`
    ),
    GO_short = `GO term description` %>%
      gsub("regulation of ", "reg. ", .) %>%
      gsub("process", "proc.", .) %>%
      strtrim(., 60)
  ) %>%
  group_by(Pathway) %>%
  mutate(GO_short = fct_reorder(GO_short, logp)) %>%
  ungroup()

# Custom colours
custom_colours <- c(
  "Neurotransmission" = "#1f78b4",         # Blue
  "Transcription regulation" = "#ff7f00",  # Orange
  "Other" = "grey80"
)

# Create a coloured label variable for facet strips
significant <- significant %>%
  mutate(
    Pathway_col = case_when(
      Pathway == "Neurotransmission" ~ "<span style='color:#1f78b4'><b>Neurotransmission</b></span>",
      Pathway == "Transcription regulation" ~ "<span style='color:#ff7f00'><b>Transcription regulation</b></span>",
      TRUE ~ "<span style='color:grey40'><b>Other</b></span>"
    )
  )

# Plot
ggplot(significant, aes(x = logp, y = GO_short, colour = Pathway)) +
  geom_segment(aes(x = 0, xend = logp, yend = GO_short), size = 0.5) +
  geom_point(aes(size = `Gene number`)) +
  scale_color_manual(values = custom_colours) +
  scale_size(range = c(2, 8)) +  # Adjust size range if needed
  theme_minimal(base_size = 11) +
  labs(
    x = expression(-log[10](adjusted~Pvalue)),
    y = NULL,
    colour = "Physiological pathway",
    size = "Gene number"
  ) +
  facet_wrap(~ Pathway_col, scales = "free_y", ncol = 1, strip.position = "top") +
  theme(
    strip.text = ggtext::element_markdown(size = 14, face = "plain"),
    legend.position = "right",
    axis.text.y = element_text(size = 11)
  )+
  guides(colour = "none")
 

# Save the plot as a PDF
ggsave(
  filename = "Figure5_gene_number_scaled.pdf",
  width = 8, height = 10, units = "in", device = cairo_pdf
)



