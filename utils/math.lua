-- Math functions

function clamp(v, lower, upper)
    return math.max(lower, math.min(upper, v))
end


return {clamp= clamp}