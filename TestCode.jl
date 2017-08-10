# Need to debug
## Calculates using Dominance Ratio, Break Point Dom Ratio and court varience ##
function DRodds(p1,p2)
  function BreakDom(x)
    ReturnBreak = x[44]*x[45]
    ServiceBreak = x[40]*x[41]
    return (ReturnBreak/(1-ServiceBreak))
  end
  c1 = BreakDom[p1]
  c2 = BreakDom[p2]
  a1=p1[15];  a2=p2[15]
  b1=p1[33];  b2=p2[33]
  d = a1*b1*c1-a2*b2*c2
  if d > 0
    e=1
    f = (a1*b1*c1)/(a2*b2*c2)
  else
    e = 0
    f = (a2*b2*c2)/(a1*b1*c1)
  end
  return [e f]
end
