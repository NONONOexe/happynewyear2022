# install.packages("tidyverse")
# install.packages("emojifont")
# install.packages("sysfonts")
library(tidyverse)
library(emojifont)
library(sysfonts)

data <- tibble::tribble(
  ~eto     , ~animal  , ~stroke, ~kanji,
  "ne"     , "mouse"  ,       3, "子"  ,
  "ushi"   , "ox"     ,       4, "丑"  ,
  "tora"   , "tiger"  ,      11, "寅"  ,
  "u"      , "rabbit" ,       5, "卯"  ,
  "tatsu"  , "dragon" ,       7, "辰"  ,
  "mi"     , "snake"  ,       3, "巳"  ,
  "uma"    , "horse"  ,       4, "午"  ,
  "hitsuji", "sheep"  ,       5, "未"  ,
  "saru"   , "monkey" ,       5, "申"  ,
  "tori"   , "rooster",       7, "酉"  ,
  "inu"    , "dog"    ,       6, "戌"  ,
  "i"      , "boar"   ,       6, "亥"
)

sysfonts::font_add_google("Lobster"      , "lobster"     )
sysfonts::font_add_google("Itim"         , "itim"        )
sysfonts::font_add_google("Noto Serif JP", "notoserifcjk")
sysfonts::font_add_google("Noto Sans JP" , "notosanscjk" )

p <- data %>%
# data %>%
  ggplot2::ggplot(mapping = ggplot2::aes(x = factor(eto, levels = eto),
                                         y = stroke)) +
  ggplot2::geom_segment(mapping = ggplot2::aes(xend = eto, yend = 0),
                        colour  = "gray",
                        size    = 2,
                        lineend = "butt") +
  ggplot2::geom_text(mapping = ggplot2::aes(label = kanji,
                                            y     = stroke),
                     family  = "notoserifcjk",
                     colour  = "gray40",
                     size    = 8,
                     nudge_y = 3) +
  ggplot2::geom_text(mapping = ggplot2::aes(label = emojifont::emoji(animal),
                                            y     = stroke),
                     family  = "EmojiOne",
                     size    = 8,
                     nudge_y = 1.75) +
  ggplot2::geom_point(mapping = ggplot2::aes(colour = stroke),
                      size    = 5) +
  ggplot2::scale_colour_viridis_c(option = "viridis") +
  ggplot2::labs(title    = "Happy New Year 2022: Year of the Tiger",
                subtitle = "Which of the Eto is the Hardest to Write?",
                caption  = "本年もどうぞ宜しくお願い致します\nhttps://github.com/NONONOexe/happynewyear2022") +
  ggplot2::xlab(label = "Eto: Japanese Zodiac (Animal)") +
  ggplot2::ylab(label = "Number of Strokes") +
  ggplot2::scale_x_discrete(labels = stringr::str_c(data$eto, "\n", data$animal)) +
  ggplot2::scale_y_continuous(breaks = 1:12, limits = c(0, 15)) +
  ggplot2::theme_bw() +
  ggplot2::theme(text               = ggplot2::element_text(family = "itim"),
                 legend.position    = "none",
                 axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = 10)),
                 panel.grid.major.x = ggplot2::element_blank(),
                 panel.grid.major.y = ggplot2::element_line(linetype = "dashed"),
                 panel.grid.minor.y = ggplot2::element_blank(),
                 plot.title         = ggplot2::element_text(family = "lobster"),
                 plot.subtitle      = ggplot2::element_text(family = "lobster"),
                 plot.caption       = ggplot2::element_text(family     = "notosanscjk",
                                                            size       = 7,
                                                            hjust      = 1,
                                                            lineheight = 1.2))

ggplot2::ggsave(filename = "happy-new-year-2022.pdf",
                plot     = p,
                device   = cairo_pdf,
                path     = "plot",
                width    = 148,
                height   = 100,
                units    = "mm")

shell("magick -density 1000 plot/happy-new-year-2022.pdf plot/happy-new-year-2022.png")
