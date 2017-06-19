                                                            ## Visualisation Code ##
#########################################################################################
using PyPlot

function Visual(Year,Open,Line,BR)
  Data = Simulate(Year,Open,Line,BR)
  Result = Data[1]
  x = 1:size(Data[2],1)
  y = Data[2]
  plot(x,y,color = "red")
  title(Result)
end

function OpenVisual(Open, Line, BR)
 function Resize(x,Size)
  while size(x,1) != Size
    push!(x,x[end])
  end
  return x
 end
  Data2013 = Simulate(2013,Open,Line,BR)[2]
  Data2014 = Simulate(2014,Open,Line,BR)[2]
  Size = maximum([size(Data2013,1),size(Data2014,1)])
  CData2013 = Resize(Data2013,Size)
  CData2014 = Resize(Data2014,Size)
  plot([1:Size],CData2013,color = "red")
  plot([1:Size],CData2014, color = "green")
  title("2013: Red; 2014: Green")
end

function YearVisual(Year,Line,BR)
 function Resize(x,Size)
  while size(x,1) != Size
    push!(x,x[end])
  end
  return x
 end
  aus = Simulate(Year,"AUS",Line,BR)[2]
  french = Simulate(Year,"French",Line,BR)[2]
  uk = Simulate(Year,"UK",Line,BR)[2]
  us = Simulate(Year,"US",Line,BR)[2]
  Size = maximum([size(aus,1),size(french,1),size(uk,1),size(us,1)])
  AUS = Resize(aus,Size)
  French = Resize(french,Size)
  UK = Resize(uk,Size)
  US = Resize(us,Size)
  plot([1:Size],AUS,color = "red")
  plot([1:Size],French, color = "green")
  plot([1:Size],UK,color = "yellow")
  plot([1:Size],US, color = "purple")
  title("AUS: Red, FR: Green, UK: Yellow, US: Purple")
end

# AUS: Red, FR: Green, UK: black, US: Purple;   2013: Dotted , 2014: Dashed , 2015: Line
  function FullVisual(Line,BR)
   function Resize(x,Size)
    while size(x,1) != Size
      push!(x,x[end])
    end
    return x
   end
  aus3 = Simulate(2013,"AUS",Line,BR)[2]
  french3 = Simulate(2013,"French",Line,BR)[2]
  uk3 = Simulate(2013,"UK",Line,BR)[2]
  us3 = Simulate(2013,"US",Line,BR)[2]
  aus4 = Simulate(2014,"AUS",Line,BR)[2]
  french4 = Simulate(2014,"French",Line,BR)[2]
  uk4 = Simulate(2014,"UK",Line,BR)[2]
  us4 = Simulate(2014,"US",Line,BR)[2]
  aus5 = Simulate(2015,"AUS",Line,BR)[2]
  Size = maximum([size(aus3,1),size(french3,1),size(uk3,1),size(us3,1),size(aus4,1),size(french4,1),size(uk4,1),size(us4,1),size(aus5,1)])
  AUS3 = Resize(aus3,Size)
  French3 = Resize(french3,Size)
  UK3 = Resize(uk3,Size)
  US3 = Resize(us3,Size)
  AUS4 = Resize(aus4,Size)
  French4 = Resize(french4,Size)
  UK4 = Resize(uk4,Size)
  US4 = Resize(us4,Size)
  AUS5 = Resize(aus5,Size)
  plot([1:Size],AUS3,color = "red",linestyle = ":")
  plot([1:Size],French3, color = "green",linestyle = ":")
  plot([1:Size],UK3,color = "black",linestyle = ":")
  plot([1:Size],US3, color = "purple",linestyle = ":")
  plot([1:Size],AUS4,color = "red",linestyle = "--")
  plot([1:Size],French4, color = "green",linestyle = "--")
  plot([1:Size],UK4,color = "black",linestyle = "--")
  plot([1:Size],US4, color = "purple",linestyle = "--")
  plot([1:Size],AUS5,color = "red",linestyle = "-")
  title("Grand Slam Simulations 2013 - 2015")
  xlabel("Number of Matches")
  ylabel("Bankroll")
end

function FullVisualSimulate(Line,BR)
    function Resize(x,Size)
      while size(x,1) != Size
        push!(x,x[end])
      end
      return x
     end
  AUS13A = Simulate(2013,"AUS","Avg",BR)
  French13A = Simulate(2013,"French","Avg",AUS13A[1])
  UK13A = Simulate(2013,"UK","Avg",French13A[1])
  US13A = Simulate(2013,"US","Avg",UK13A[1])
  AUS14A = Simulate(2014,"AUS","Avg",US13A[1])
  French14A = Simulate(2014,"French","Avg",AUS14A[1])
  UK14A = Simulate(2014,"UK","Avg",French14A[1])
  US14A = Simulate(2014,"US","Avg",UK14A[1])
  AUS15A = Simulate(2015,"AUS","Avg",US14A[1])
  AUS13M = Simulate(2013,"AUS","Max",BR)
  French13M = Simulate(2013,"French","Max",AUS13M[1])
  UK13M = Simulate(2013,"UK","Max",French13M[1])
  US13M = Simulate(2013,"US","Max",UK13M[1])
  AUS14M = Simulate(2014,"AUS","Max",US13M[1])
  French14M = Simulate(2014,"French","Max",AUS14M[1])
  UK14M = Simulate(2014,"UK","Max",French14M[1])
  US14M = Simulate(2014,"US","Max",UK14M[1])
  AUS15M = Simulate(2015,"AUS","Max",US14M[1])
  TotalA = [AUS13A[2];French13A[2];UK13A[2];US13A[2];AUS14A[2];French14A[2];UK14A[2];US14A[2];AUS15A[2]]
  TotalM = [AUS13M[2];French13M[2];UK13M[2];US13M[2];AUS14M[2];French14M[2];UK14M[2];US14M[2];AUS15M[2]]
  Size = maximum([size(TotalA,1),size(TotalM,1)])
  TotalA1 = Resize(TotalA,Size)
  TotalM1 = Resize(TotalM,Size)
  plot(1:Size, TotalA1, color = "red")
  plot(1:Size, TotalM1, color = "black")
  xlabel("Number of Matches")
  ylabel("Bankroll")
  title("Avg Line: Red; Max Line: Black")
end

function YearCompoundSimulation(Year,BR,Line)
  AUS14 = Simulate(Year,"AUS",Line,BR)
  IndianWells14 = Simulate(Year,"Indianwells",Line,AUS14[1])
  Miami14 = Simulate(Year,"Miami",Line,IndianWells14[1])
  MonteCarlo14 = Simulate(Year,"MonteCarlo",Line,Miami14[1])
  Madrid14 = Simulate(Year,"Madrid",Line,MonteCarlo14[1])
  Rome14 = Simulate(Year,"Rome",Line,Madrid14[1])
  French14 = Simulate(Year,"French",Line,Rome14[1])
  UK14 = Simulate(Year,"UK",Line,French14[1])
  Cincinnati14 = Simulate(Year,"Cincinnati",Line,UK14[1])
  US14 = Simulate(Year,"US",Line,Cincinnati14[1])
  Shanghai14 = Simulate(Year,"Shanghai",Line,US14[1])
  Paris14 = Simulate(Year,"Paris",Line,Shanghai14[1])
  Masters14 = Simulate(Year,"Masters",Line,Paris14[1])
  Total = [AUS14[2]; IndianWells14[2]; Miami14[2]; MonteCarlo14[2]; Madrid14[2]; Rome14[2]; French14[2]; UK14[2]; Cincinnati14[2]; US14[2]; Shanghai14[2]; Paris14[2]; Masters14[2]]
  plot(1:size(Total,1), Total)
  xlabel("Number of Matches")
  ylabel("Bankroll")
  title(Masters14[1])
  end

function BothYearCompound(BR)
  function YearCompound(Year,BR,Line)
    AUS14 = Simulate(Year,"AUS",Line,BR)
    IndianWells14 = Simulate(Year,"Indianwells",Line,AUS14[1])
    Miami14 = Simulate(Year,"Miami",Line,IndianWells14[1])
    MonteCarlo14 = Simulate(Year,"MonteCarlo",Line,Miami14[1])
    Madrid14 = Simulate(Year,"Madrid",Line,MonteCarlo14[1])
    Rome14 = Simulate(Year,"Rome",Line,Madrid14[1])
    French14 = Simulate(Year,"French",Line,Rome14[1])
    UK14 = Simulate(Year,"UK",Line,French14[1])
    Cincinnati14 = Simulate(Year,"Cincinnati",Line,UK14[1])
    US14 = Simulate(Year,"US",Line,Cincinnati14[1])
    Shanghai14 = Simulate(Year,"Shanghai",Line,US14[1])
    Paris14 = Simulate(Year,"Paris",Line,Shanghai14[1])
    Masters14 = Simulate(Year,"Masters",Line,Paris14[1])
    Total = [AUS14[2]; IndianWells14[2]; Miami14[2]; MonteCarlo14[2]; Madrid14[2]; Rome14[2]; French14[2]; UK14[2]; Cincinnati14[2]; US14[2]; Shanghai14[2]; Paris14[2]; Masters14[2]]
    return Total
  end
  function Resize(x,Size)
    while size(x,1) != Size
      push!(x,x[end])
    end
    return x
  end
  A2013 = YearCompound(2013,BR,"Avg")
  A2014 = YearCompound(2014,BR,"Avg")
  M2013 = YearCompound(2013,BR,"Max")
  M2014 = YearCompound(2014,BR,"Max")
  Size = maximum([size(A2013,1); size(A2014,1); size(M2013,1); size(M2014,1)])
  A2013 = Resize(A2013, Size)
  A2014 = Resize(A2014, Size)
  M2013 = Resize(M2013, Size)
  M2014 = Resize(M2014, Size)
  plot(1:Size, A2013, color = "red",linestyle = "--")
  plot(1:Size, A2014, color = "black",linestyle = "--")
  plot(1:Size, M2013, color = "red")
  plot(1:Size, M2014, color = "black")
  xlabel("Number of Matches")
  ylabel("%")
  title("Compound Annual Growth Rate")
end

