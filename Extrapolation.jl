function DomRatios(x,year)
  Player = PlayerOdds(x)
    if year == 2012; DR_No = DataSort("2012 Dom Ratio Points")
     elseif year == 2013; DR_No = DataSort("2013 Dom Ratio Points")
     else
     if  year == 2014; DR_No = DataSort("2014 Dom Ratio Points")
     elseif year == 2011; DR_No = DataSort("2011 Dom Ratio Points")
     else
     if year == 2010; DR_No = DataSort("2010 Dom Ratio Points")
      end end end
  DR = Player[DR_No]
  return DR
end

function ExtrapDomRatio1(x,year)
  h = Real[]
  g = Real[]
  Data = DataFix()
  DR = DomRatios(x,year)
  for a = 2:size(Data,1)
   DRa = Data[a,DataSort("2011 Dom Ratio Points")]
    if DRa != DR && (DR+0.1)>DRa>(DR-0.1)
      if Data[a,DataSort("2011 Games Total")] > 100 && Data[a,DataSort("2012 Games Total")] >100
      DR_New = Data[a,DataSort("2012 Dom Ratio Points")]
      Diff = abs(DRa - DR)
        push!(h,DR_New)
        push!(g,Diff)
      end end
     DRb = Data[a,DataSort("2012 Dom Ratio Points")]
    if DRb != DR && (DR+0.1)>DRb>(DR-0.1)
      if Data[a,DataSort("2012 Games Total")] > 100 && Data[a,DataSort("2013 Games Total")] >100
      DR_New = Data[a,DataSort("2013 Dom Ratio Points")]
      Diff = abs(DRb - DR)
        push!(h,DR_New)
        push!(g,Diff)
      end end
   DRc = Data[a,DataSort("2013 Dom Ratio Points")]
    if DRc != DR && (DR+0.1)>DRc>(DR-0.1)
      if Data[a,DataSort("2013 Games Total")] > 100 && Data[a,DataSort("2014 Games Total")] >100
      DR_New = Data[a,DataSort("2014 Dom Ratio Points")]
      Diff = abs(DRc - DR)
        push!(h,DR_New)
        push!(g,Diff)
      end end
       DRd = Data[a,DataSort("2010 Dom Ratio Points")]
    if DRd != DR && (DR+0.1)>DRd>(DR-0.1)
      if Data[a,DataSort("2010 Games Total")] > 100 && Data[a,DataSort("2011 Games Total")] >100
      DR_New = Data[a,DataSort("2011 Dom Ratio Points")]
      Diff = abs(DRd - DR)
        push!(h,DR_New)
        push!(g,Diff)
      end end
  end
  return h,g
end

function ExtrapDomRatio2(x,year)
  Data = ExtrapDomRatio1(x,year)
  DRs = Data[1]
  if size(DRs,1) == 0
  DR = DomRatios(x,year)
  else
  h=Real[]
  a = Data[2]
  b = (1./a)
  Weighting = b/sum(b)
  for c = 1:size(DRs,1)
    d = DRs[c]*Weighting[c]
    push!(h,d)
  end
  function Rounding4(x)
  x = (floor(x*10000))/10000
  return x
  end
    DR = Rounding4(sum(h))
  end
  return DR
  end

function ExtrapTest(year)
  Data = DataFix()
  h = Real[]
  g = Real[]
  for Player = Data[2:end,1]
    a = DomRatios(Player,year)
    b = DomRatios(Player,(year+1))
    c = abs(b-a)
    d = ExtrapDomRatio2(Player,year)
    e = abs(b-d)
    push!(h,c)
    push!(g,e)
  end
  s = sum(h)/size(h,1)
  t = sum(g)/size(g,1)
  println("Last Year Diff: ",s)
  println("Extrap Diff: ",t)
end

function ExtrapDR(year)
  Data = DataFix()
  h = Real[]
  for a = 2:size(Data,1)
    Player = Data[a,1]
    d = ExtrapDomRatio2(Player,year)
    push!(h,d-)
  end
  Dom = [Data[2:end,1] h]
end

function DomRatioFunction()
  Data = DataFix()
  cd("C:\\Users\\Simons\\AppData\\Local\\Julia-0.4.0-dev\\Sports Betting Hedge Fund\\Player Data")
  Players = Data[2:end,1]
  Dom = [Players]
  for year = [2010;2011;2012;2013;2014]
   h = Real[]
    for a = 2:size(Data,1)
    Player = Data[a,1]
    d = ExtrapDomRatio2(Player,year)
    push!(h,d)
  end
    Dom = [Dom h]
  end
  writecsv("DomExtrap.csv",Dom)
  return Dom
end
