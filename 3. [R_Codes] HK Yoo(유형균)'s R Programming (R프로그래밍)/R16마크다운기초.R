# R16 마크다운 기초


---
title: "R 마크다운 기초"
output: html_document
---
  
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# R 마크다운 라이브러리 불러오기
```{r}
library(rmarkdown)
library(knitr)
```


# LaTex로 수식 작성하기 : $문자$, $$문자$$
$a + b$
  
$$ a + b = x $$
  
$$ x \ne y, x = y $$

$$ x \gt y, x \lt y, x \ge y, x \le y $$
  
  
$$ x^n, x^{n}, x_{n}, x_n, X_{i,j}, X^2_{i,j} $$
  
$$ \sqrt{b^2 - 4ac}, \frac{4z^3}{16} $$
  
$$ s^2, \overline{x}, \hat{p} $$
  
$$ \mu, \sigma, \sigma^2, \rho $$
  
  
$$ x_{1} + x_{2} + \cdots + x_{n} $$
  
  
$$ x{1}, x_{2}, \cdots, x_{n} $$
  
$$ \begin{array}
{rrr}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{array} $$
  
  
$$ \left[
\begin{array}
{rrr}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{array}
\right] $$
  
  
$$ \mathbb{R} $$
  
$$ \mathbb{Z} $$
  
  
# LaTex로 그리스문자 작성하기

$$ \alpha, A $$ 
  
$$ \beta, B $$

$$ \gamma \Gamma $$
  
$$ \delta \Delta $$

$$ \epsilon \varepsilon E $$
  
$$ \zeta Z $$
  
$$ \eta H $$
  
  
  
  
  
  

