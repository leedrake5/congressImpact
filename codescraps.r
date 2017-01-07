
#####Old Clean Table from Global
allzips$latitude <- jitter(allzips$latitude)
allzips$longitude <- jitter(allzips$longitude)
allzips$college <- allzips$college * 100
allzips$unemployment <- allzips$Unemp..Rate * 100
allzips$pubcov <- as.numeric(allzips$Percent.Public.Coverage..Estimate..COVERAGE.ALONE...Public.health.insurance.alone)
allzips$medicare <- as.numeric(allzips$Percent.Public.Coverage..Margin.of.Error..COVERAGE.ALONE...Public.health.insurance.alone...Medicare.coverage.alone)
allzips$va <- as.numeric(allzips$Percent.Public.Coverage..Margin.of.Error..COVERAGE.ALONE...Public.health.insurance.alone...VA.health.care.coverage.alone)
allzips$medicaidexpansion <- as.numeric(allzips$Percent.Public.Coverage..Margin.of.Error..PUBLIC.HEALTH.INSURANCE.ALONE.OR.IN.COMBINATION...Below.138.percent.of.the.poverty.threshold)
allzips$zipcode <- formatC(allzips$zipcode, width=5, format="d", flag="0")
#row.names(allzips) <- allzips$zipcode

cleantable <- allzips %>%
select(
City = city.x,
State = state.x,
Zipcode = zipcode,
Rank = rank,
Score = centile,
Superzip = superzip,
Population = adultpop,
College = college,
unemployment = Unemp..Rate,
Income = income,
Lat = latitude,
Long = longitude
)





#####Old Data Exlorer from Superzip
observe({
    cities <- if (is.null(input$states)) character(0) else {
      filter(cleantable, State %in% input$states) %>%
        `$`('City') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$cities[input$cities %in% cities])
    updateSelectInput(session, "cities", choices = cities,
      selected = stillSelected)
  })

  observe({
    zipcodes <- if (is.null(input$states)) character(0) else {
      cleantable %>%
        filter(State %in% input$states,
          is.null(input$cities) | City %in% input$cities) %>%
        `$`('Zipcode') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$zipcodes[input$zipcodes %in% zipcodes])
    updateSelectInput(session, "zipcodes", choices = zipcodes,
      selected = stillSelected)
  })

  observe({
    if (is.null(input$goto))
      return()
    isolate({
      map <- leafletProxy("map")
      map %>% clearPopups()
      dist <- 0.5
      zip <- input$goto$zip
      lat <- input$goto$lat
      lng <- input$goto$lng
      showZipcodePopup(zip, lat, lng)
      map %>% fitBounds(lng - dist, lat - dist, lng + dist, lat + dist)
    })
  })

  output$ziptable <- DT::renderDataTable({
    df <- cleantable %>%
      filter(
        Score >= input$minScore,
        Score <= input$maxScore,
        is.null(input$states) | State %in% input$states,
        is.null(input$cities) | City %in% input$cities,
        is.null(input$zipcodes) | Zipcode %in% input$zipcodes
      ) %>%
      mutate(Action = paste('<a class="go-map" href="" data-lat="', Lat, '" data-long="', Long, '" data-zip="', Zipcode, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
    action <- DT::dataTableAjax(session, df)

    DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
  })
