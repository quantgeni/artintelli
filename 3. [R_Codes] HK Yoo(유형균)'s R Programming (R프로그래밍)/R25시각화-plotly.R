## 다양한 시각화 도구

# R 에서 제공하는 기본적인 시각화 도구는 
# 디자인 관점에서 볼 때 다소 빈약하고 
# 일일이 코드를 작성해서 그래프를 그린다는 것이 불편할 수 있음
# 또한, 다양한 소스로 부터 그래프를 작성하는 것이 쉬운것이 아님

# 분석 작업의 비효율을 줄이고, 
# 업무 능력을 높여주는 다양한 시각화 도구가 존재
# => 엑셀, 태블로(tableau), plotly(클라우드)

# plotly : plot.ly/r


install.packages("plotly")
library(plotly)


# 오프라인으로 그래프 작성

p <- plot_ly(iris, x=~Sepal.Length, y=~Sepal.Width)
p <- plot_ly(data=iris, x=~Sepal.Length, y=~Sepal.Width,
             color=~Species, colors='Set2')

p


p <- plot_ly(mtcars, y=~mpg, type='box', color=~cyl)

p


 
