using Modia       # reexports exported symbols from
# DifferentialEquations, Unitful, SignalTables
usePlotPackage("PyPlot")

# Define model
SimpleModel = Model(
    T=0.4,
    x=Var(init=0.2),
    equations=:[T * der(x) + x = 1],
)

# Transform to ODE form
simpleModel = @instantiateModel(SimpleModel)

function trysimulate()
    try
        simulate!(simpleModel, stopTime=1.2)
    catch
    end
end

trysimulate()

# Simulate with default integrator Sundials.CVODE_BDF

# # Simulate with a specific integrator (Tsit5) and use a unit for stopTime
# simulate!(simpleModel, Tsit5(), stopTime = 1.2u"s")

# Produce a line plot
@usingModiaPlot   # Use plot package defined with
# ENV["SignalTablesPlotPackage"] = "XXX" or with 
# usePlotPackage("XXX")
plot(simpleModel, ("x", "der(x)"))