# Задание r2z2:
# Вариант Z4 (Критерий согласия хи-квадрат)
# α = 0.05
# H0: X ∼ N(μ,σ2)

data2 <- read.csv('https://kms.kpfu.ru/sites/default/files/unmanaged/forstud/Курсовая%20работа%20по%20ТВМС/813/7/r2z2.csv')

# построим графики
hist(data2$X,
     xlab = "Переменная X", # изменить подпись оси OX
     ylab = "Плотность вероятности", # изменить подпись оси OY
     main = "Гистограмма, совмещенная с кривой плотности\n теоретические и эмпирические распределения", # изменить название гистограммы
     col = "plum", # поменять цвет гистограммы
     ylim = c(0, 0.7),
     freq = F # плотность
     )
curve(dnorm(x, # рассчитываем значения функции плотности нормального распределения
            mean = mean(data2$X), # с выборочным средним
            sd = sd(data2$X) ), # и выборочным стандартным отклонением
      add = T # дорисовываем кривую на предыдущем графике
      )

# количество значений в выборке
n <- (nrow(data2))

# создадим вектор Х из выборки
X <- vector(length = n, mode = 'numeric')
for (i in 1:n) X[i] <-  data2[i, 1]

# Выбираем интервалы
k <- ceiling(1 + log2(n)) # число интервалов

FuncInterval <- function(a,b) {
  seq(from=min(a), to = max(a), by = (max(a)-min(a))/b)
}
x.q <- FuncInterval(X, k) #  границы групп

# Вычисляем фактические частоты
x.hist <- hist(X, breaks = x.q, plot = F)
h <-  x.hist$counts

# Вычисляем теоретические вероятности для каждого интервала
x.q[1]<-(-Inf);x.q[k+1]<-(+Inf) #«раздвигаем» границы до бесконечности
x.p.theor<- pnorm(x.q,mean=mean(X),sd=sd(X))
x.p.theor<-(x.p.theor[2:(k+1)]- x.p.theor[1:k])
p <- round(x.p.theor,2)


t <- 0  # критическое значение
for(i in 1:k){
  v <- h[i]/ n # практические частоты
  t <- t + (( v - n*p[i]) ^2 )/ n * p[i]
}
# n*p - тоертические частоты

С <- qchisq(0.95, k - 1 )
p_v <- 1 - pchisq( t, k - 1 )




# Сравниваем фактические и теоретические частоты
res <- chisq.test(x.hist$counts, x.p.theor)
res$p.value
res
# Поскольку для проверки нулевой гипотезы H0 о нормальности распределения генеральной совокупности в нашем случае используется правосторонний критерий,
# а уровень значимости (p-value) равен 0.913 (91.3%), то нужно допустить разрешить вероятность ошибки, равную 91.3%,
# чтобы считать выборку не принадлежащей нормальному распределению.
# Следовательно, гипотеза о нормальности принимается
























# проверка
f1 <- fitdist(data2$X,"norm", method='mme')
print(f1)
plot(f1)
# Критерий хи-квадрат Пирсона
pearson.test(data2$X)
??pearson.test
# Критерий Лиллифорса
lillie.test(data2$X)
# Критерии Крамера-фон Мизеса и Андерсона-Дарлинга
cvm.test(data2$X)
ad.test(data2$X)
# Критерий Шапиро-Франсиа
sf.test(data2$X)