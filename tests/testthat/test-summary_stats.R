library(gapminder)

test_that("The output is a list; the first item of the output is a data.frame, the second item of the output is a ggplot, and neither item is empty", {
  expect_true(is.list(summary_stats_column(gapminder, lifeExp)))
  expect_true(!is.null(summary_stats_column(gapminder, lifeExp)[[1]]))
  expect_true(!is.null(summary_stats_column(gapminder, lifeExp)[[2]]))
  expect_s3_class(summary_stats_column(gapminder, lifeExp)[[1]], "data.frame")
  expect_s3_class(summary_stats_column(gapminder, lifeExp)[[2]], "ggplot")
})

test_that("Error occurs for incorrect column arguments (a non-numeric column and a NA column)", {
  expect_error(summary_stats_column(gapminder, country))
  expect_error(summary_stats_column(gapminder, NA))
})

test_that("The first input is a dataframe", {
  expect_true(is.data.frame(gapminder))
})
