module Compositions

compositions = Dict(
    "96%CO2" => "REFPROP::CarbonDioxide[0.969696970]&Hydrogen[0.010101010]&Nitrogen[0.010101010]&Argon[0.009090909]&CarbonMonoxide[0.001010101]",
    "100%CO2" => "CarbonDioxide[1.0]"
)

export compositions

end