# Generate completions.json

open(joinpath(dirname(@__FILE__), "completions.json"), "w") do io
  println(io, "{")
  for (word, char) in Base.REPLCompletions.latex_symbols
    println(io, "  \"$(word[2:end])\": \"$char\",")
  end
  for (word, char) in Base.REPLCompletions.emoji_symbols
    println(io, "  \"$(word[2:end])\": \"$char\",")
  end
  skip(io, -2)
  println(io)
  println(io, "}")
end
