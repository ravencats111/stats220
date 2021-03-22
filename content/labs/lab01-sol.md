---
output: 
  md_document:
    preserve_yaml: true
    variant: gfm
layout: page
title: Lab 01 Solution
---

This lab exercise is **due 23:59 Monday 15 March (NZDT)**.

-   You should submit an R file (i.e. file extension `.R`) containing R
    code that assigns values to **the appropriate symbols**.
-   Your R file will be executed in order and checked against the values
    that have been assigned to the symbols using an **automatic**
    grading system. Marks will be fully deducted for **non-identical**
    results.
-   Intermediate steps to achieve the final results will NOT be checked.
-   Each question is worth 0.2 points.
-   You should submit your R file on Canvas.
-   Late assignments are NOT accepted unless prior arrangement for
    medical/compassionate reasons.

### Question 1

Generate the sequence of values from 200 to 400, incremented by 2.
*Hint: check out the `seq()` help page with `?seq`.*

``` r
x <- seq(200, 400, by = 2)
x
```

    #>   [1] 200 202 204 206 208 210 212 214 216 218 220 222 224 226 228 230
    #>  [17] 232 234 236 238 240 242 244 246 248 250 252 254 256 258 260 262
    #>  [33] 264 266 268 270 272 274 276 278 280 282 284 286 288 290 292 294
    #>  [49] 296 298 300 302 304 306 308 310 312 314 316 318 320 322 324 326
    #>  [65] 328 330 332 334 336 338 340 342 344 346 348 350 352 354 356 358
    #>  [81] 360 362 364 366 368 370 372 374 376 378 380 382 384 386 388 390
    #>  [97] 392 394 396 398 400

### Question 2

Obtain remainders when `x` is divided by 3. *Hint: what is R’s modulus
operator?*

``` r
remainder <- x %% 3
remainder
```

    #>   [1] 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1
    #>  [33] 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2
    #>  [65] 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0 2 1 0
    #>  [97] 2 1 0 2 1

### Question 3

Subset `x` given that the remainders are equal to zero.

``` r
x2 <- x[remainder == 0]
x2
```

    #>  [1] 204 210 216 222 228 234 240 246 252 258 264 270 276 282 288 294
    #> [17] 300 306 312 318 324 330 336 342 348 354 360 366 372 378 384 390
    #> [33] 396

### Question 4

Find the number of elements of `x2`.

``` r
n_x2 <- length(x2)
n_x2
```

    #> [1] 33

### Question 5

Calculate the 95% range of `x2` given by 2 standard deviations of the
mean. (DO NOT round your results!)

``` r
sd_x2 <- 2 * sd(x2)
mean_x2 <- mean(x)
rng_x <- c(mean_x2 - sd_x2, mean_x2 + sd_x2)
rng_x
```

    #> [1] 183.9655 416.0345
