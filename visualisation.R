fruits <- c("Strawberries", "Bananas", "Mangoes")
nombre <- c(sample(1:2, 1), sample(7:10, 1), 2)
couleur_barres <- c("red", "yellow", "#c48207")

barplot(nombre,
        names = fruits,
        col = couleur_barres,
        main = "Monkey Fruit Consumption",
        xlab = "Fruit",
        ylab = "Number of fruits",
        ylim = c(0, 10),
)


