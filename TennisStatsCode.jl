## Returns an individual players stats ##
function PlayerOdds(data,x)
  b=0
  for a::Int=1:size(data,1)
    if data[a,1] == x
      b = data[a,1:end]; break
    end end
  if b == 0
    b = "No Stats Available"
  end
  return b
end

## Calculates a betting lines using Dominance Ratio and court varience ##
function DRodds(p1,p2)
  a1=p1[15];  a2=p2[15]
  b1=p1[33];  b2=p2[33]
  c = a1*b1-a2*b2
  if c>0
    d=1
    e=(a1*b1)/(a2*b2)
  else
    d=0
    e=(a2*b2)/(a1*b1)
  end
  return [d e]
end

## Calculates the odds between a player matchup ##
function Odds(data,p1,p2)
  x=PlayerOdds(data,p1)
  y=PlayerOdds(data,p2)
  if summary(x) == "1x45 Array{Any,2}" && summary(y) == "1x45 Array{Any,2}"
  d=DRodds(x,y)
  if d[1] == 1
    c=p1; e=p2
  else
    c=p2; e=p1
  end
  return [c d[2]
              e 1/d[2]]
  else
    return "No Betting Line Available"
  end
end

## Calculates the number of viable matches ##
function NoMatches(BettingOdds,data)
  n=0
  h=Real[]
  for b=1:size(BettingOdds,1)
    for c=1:size(data,1)
      for d=1:size(data,1)
      ptotal1 = data[c,1]
      ptotal2 = data[d,1]
      p1 = BettingOdds[b,1]
      p2 = BettingOdds[b,2]
      if p1 == ptotal1
          if p2 == ptotal2
            push!(h,b)
     end end
    end  end  end
  return h
end

## Calculates which bets are viable and EV ##
function Viable(BettingOdds,Data)
 VMatches=Real[0 0 0]
  for h=NoMatches(BettingOdds,Data)
    Match = BettingOdds[h,1:end]
    p1 = Match[1]
    p2 = Match[2]
    BLine = Odds(Data,p1,p2)
    if p1 == BLine[1,1]
      WinLine = Match[5] - (1+1/BLine[1,2])
      LossLine = Match[6] - (1+1/BLine[2,2])
    else
      WinLine = Match[5] - (1+1/BLine[2,2])
      LossLine = Match[6] - (1+1/BLine[1,2])
    end
    if WinLine > 0 && LossLine <= 0
      a = p1;   EV = WinLine/Match[5]
      VMatches=[VMatches
                          h a EV]
    elseif LossLine > 0 && WinLine <= 0
      a = p2;   EV = LossLine/Match[5]
      VMatches=[VMatches
                          h a EV]
    end end
  return VMatches[2:end,1:end]
end

## Kelly Betting ##
function Kelly(BettingOdds,Data,BR)
  h=Real[]
    for a = 1:size(Viable(BettingOdds,Data),1)
    EV =  Viable(BettingOdds,Data,)[a,3]
      if EV <=1
        n= BR*0.02*EV
      else
        n=0
      end
    push!(h,n)
    end
  return h
end

## Simulation (bankroll: 1000, Bet: Kelly) ##
function Simul(BettingOdds,Data)
  MatchStats = Viable(BettingOdds,Data)
  n=1000
  h=Real[]
  g=Real[]
  BS = Kelly(BettingOdds,Data,n)
  for a = 1:size(MatchStats,1)
    b= BettingOdds[MatchStats[a],1:end]
    if MatchStats[a,2] == b[1]
      c = b[5]*BS[a]
      n+=c
      push!(h,c)
    else
      n-=BS[a]
    end end
  x=size(h,1)/size(MatchStats,1)
  return n,size(h,1),h
end
