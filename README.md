
#Congressional Impact

I'm worried about the upcoming 4 years, and have been wondering what I can do to help. After reflecting for a while, it occurred to me that it is hard to know how to prioritize our efforts. What we need is a way to estimate our impact on a given issue important to us. But that is tough. As a test run, I tried building an interactive app that will score the potential impacts of legislation (like healthcare reform) and identify the congressmen/congresswomen most likely to have constituents affected by these changes.

The early version of the model allows for a geographic display of things like college education, unemployment level, incomes, etc. You can click on a city to get info on which congressfolk are there, alongside ways to contact them.

I am thinking of ways to create algorithms that will automatically create priority lists for highest-impact voter contacts. But for now I am open to ideas - and help. Right now biggest needs are:

1) Demographic & economic data by zipcode, 
2) Ideas for how to integrate variables, and
3) How to make it look pretty & be useable

Thanks for reading this far, and if you have time take a look and let me know your thoughts.


You can find the original version here: http://shiny.rstudio.com/gallery/superzip-example.html

You can run this demo with:
```
if (!require(devtools))
  install.packages("devtools")
devtools::install_github("rstudio/leaflet")
shiny::runGitHub("leedrake5/congressImpact")
```

Data originally compiled for _Coming Apart: The State of White America, 1960–2010_ by Charles Murray (Crown Forum, 2012). This app was inspired by the Washington Post's interactive feature _[Washington: A world apart](http://www.washingtonpost.com/sf/local/2013/11/09/washington-a-world-apart/)_. It has been augmented with unemployment data and congressional data from the sunshine project
