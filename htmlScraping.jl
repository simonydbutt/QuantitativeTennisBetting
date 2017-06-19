function individual(array)
  h = Real[]
  for a = 2:size(array,1)-1
    if array[a] != array[a+1]
      push!(h, array[a])
    end end
  return h
end

function dataSep(Array)
  h = Real[]
  for a = 1:(size(Array,1)-1)
    if abs(Array[a] - Array[a+1])>1000
      push!(h,Array[a])
    end end
  push!(h, Array[end])
  return h
end

function betExtract(string)
  b = 1
  h = Real[]
  for a=b:length(string)
    sub_string = string[a:length(string)]
    x = search(sub_string,'d')[1]
    if x != 0 && sub_string[x:x+3] == "data" && sub_string[x+5:x+8] == "name"
    push!(h,x+a-1)
    end
    b = x+1
  end
  dataNames = individual(h)
  return dataSep(dataNames)
end

function NameFix(x)
  a = search(x,' ')
  Part1 = x[a+1:end]
  Part2 = x[1]
  return "$Part1 $Part2."
end

function playerNames()
  cd("C:\\Users\\Simons\\AppData\\Local\\Julia-0.4.0-dev\\Sports Betting Hedge Fund\\Web Scraping")
  string = open(readall, "html.txt")
  Data = betExtract(string)
  Data = [Data[1], Data[2]]
  h = Real[]
  for Player = Data
  characters1 = Player
   html = string[characters1:end]
  char1 = search(html,'=')+1
  characters2 = characters1+char1
  html = string[characters2:end]
  char2 = search(html,'>') - 3
  player = string[characters1+char1:characters2+char2]
  h = [h; player]
  end
  return h
end

function playerNamesGlobal(Data)
  Data = [Data[1], Data[2]]
  h = Real[]
  for Player = Data
  characters1 = Player
   html = string[characters1:end]
  char1 = search(html,'=')+1
  characters2 = characters1+char1
  html = string[characters2:end]
  char2 = search(html,'>') - 3
  player = string[characters1+char1:characters2+char2]
  h = [h; player]
  end
  return h
end



function scrapeLines()
  cd("C:\\Users\\Simons\\AppData\\Local\\Julia-0.4.0-dev\\Sports Betting Hedge Fund\\Web Scraping")
  string = open(readall, "html.txt")
  Chars = betExtract(string)
  Players = playerNames()
  player1 = Players[1]; player2 = Players[2]
  html1 = string[Chars[1]:Chars[2]]
  html2 = string[Chars[2]:(2*Chars[2]-Chars[1])]
  h = Real[]
  for a=1:length(html1)
    if int(html1[a]) == 46 &&  48 <= int(html1[a-1]) <= 57
        if 48 <= int(html1[a+1]) <= 57
          if 48 <= int(html1[a+2]) <= 57
              h = [h; html1[a-1:a+2]]
          else
              h = [h; html1[a-1:a+1]]
          end end
  else
    if 46 <= int(html1[a]) <= 57
      if int(html1[a-1]) ==  62 && int(html1[a+1]) == 60
          h = [h; html1[a]]
    end end end end
  g = Real[]
  for a=1:length(html2)
    if int(html2[a]) == 46 &&  48 <= int(html2[a-1]) <= 57
        if 48 <= int(html2[a+1]) <= 57
          if 48 <= int(html2[a+2]) <= 57
              g = [g; html2[a-1:a+2]]
          else
              g = [g; html2[a-1:a+1]]
          end end
  else
    if 46 <= int(html2[a]) <= 57
      if int(html2[a-1]) ==  62 && int(html2[a+1]) == 60
          g = [g; html2[a]]
    end end end end
  h = [NameFix(player1); h[1:end-1]]
  g = [NameFix(player2); g]
  a = [h g]
  writecsv("Bet Line.csv",a)
  return a
end



