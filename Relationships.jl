#Relationship DataFrames:
include("/home/violet/Desktop/Amelie/Morral_Code/Tier3.jl")

#Single Points
relationships_singlepoints = DataFrame(name = [], sname = [], equation = [], range_r = [], range_t = [], inversion = [])

function relate(singles)
for i in 1:8
	a = colourtableTier3.name[i]
	b = colourtableTier3.sname[i]
	df = DataFrame(name = [a], sname = [b], equation = ["r = cos(t)"], range_r = ["0, 1"], range_t = ["0, 2*pi"], inversion = ["no"])
	c = append!(relationships_singlepoints, df)
end
return c
end

invrelationships_singlepoints = DataFrame(name = [], sname = [], equation = [], range_r = [], range_t = [], inversion = [])


function invrelate(singles)
for i in 1:8
	a = colourtableTier3.name[i]
	b = colourtableTier3.sname[i]
	df = DataFrame(name = [a], sname = [b], equation = ["r = sin(t)"], range_r = ["0, 1"], range_t = ["0, 2*pi"], inversion = ["yes"])
	c = append!(invrelationships_singlepoints, df)
end
return invrelationships_singlepoints
end

#Paired Points
function relate(colourtableTier3)

a = Tier3_Buildtable(colourtableTier3)
b = String.(a.pair_sname)
p = String.(a.low_or_high)
rr = Vector{String}(undef, 64)
eq = Vector{String}(undef,64)
c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	for i in 1:64
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:64
	q1 = b[j]
	q2 = SubString(q1,1,1)
	q3 = SubString(q1,2,2)
		if q2 == "B" && q3 == "B"
			eq[j] = "r = cos(t)"	
		elseif q2 == "B" || q3 == "W"
			eq[j] = "r^2 = cos(t)"
		elseif q2 == "W" || q3 == "B"
			eq[j] = "r^2 = cos(t)"
		elseif q2 == "W" && q3 == "W"
			eq[j] = "r = cos(t)"
		elseif q2 == q3
			eq[j] = "a = cos(t)"
		else eq[j] = "a^2 = cos(2*t)"
		end
	end	
	
	for k in 1:64
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = ["0, 2*pi"], inversion = ["no"])
	c = append!(c, df)
	end 
	return c
end

#Paired points - inversion
function invrelate(colourtableTier3)

a = Tier3_invBuildtable(colourtableTier3)
b = String.(a.pair_sname)
p = String.(a.low_or_high)
rr = Vector{String}(undef, 512)
rt = "0, 2*pi"
eq = Vector{String}(undef,512)
c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	for i in 1:64
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:64
	q1 = b[j]
	q2 = SubString(q1,1,1)
	q3 = SubString(q1,2,2)
		if q2 == "B" && q3 == "B"
			eq[j] = "r = cos(t)"	
		elseif q2 == "B" || q3 == "W"
			eq[j] = "r^2 = cos(t)"
		elseif q2 == "W" || q3 == "B"
			eq[j] = "r^2 = cos(t)"
		elseif q2 == "W" && q3 == "W"
			eq[j] = "r = cos(t)"
		elseif q2 == q3
			eq[j] = "a = cos(t)"
		else eq[j] = "a^2 = cos(2*t)"
		end
	end	
	
	for k in 1:64
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = ["0, 2*pi"], inversion = ["no"])
	c = append!(c, df)
	end 
	return c
end

#------------------------------------------------

function relatesPairs(X)

a = Tier3_Buildtable(colourtableTier3)

a = filter(:pair_sname => ==(X), a)

b = String.(a.pair_sname[1])
p = String.(a.low_or_high[1])

c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	if p == "low"
		rr = "0,1"
	elseif p == "high"
		rr = "-1,0"
	end
		
	if occursin("W", X)
		q1 = replace(X, "W" => "")
		l = length(q1)
		l1 = string(length(q1), base = 10)
		eq = "r = b^2*x^2+c^2*z^2, a = cos(n*t) for n = "
		eq = eq*l1
		
			if l > 0
			rt = "0 < t < pi/n for n = "
			rt = rt*l1
			
			elseif length(q1) == 0
			eq = "a = cos(n*t) for n = "
			eq = eq*l1
			rt = "0 < t < 2*pi/n for n = "
			rt = rt*l1	
			end	
	
	else 
		l = length(X)
		l1 = string(length(X), base = 10)
		eq = "a = cos(n*t) for n = "
		eq = eq*l1
		rt = "0 < t < 2*pi/n for n = "
		rt = rt*l1
	end

	df = DataFrame(sname = [b], equation = [eq], range_r = [rr], range_t = [rt], inversion = ["no"])
	c = append!(c, df)
	return c
end


#------------------------------------------------

#Trios
function relateTrios(colourtableTier3)

a = BuildtableTrio(colourtableTier3)
b = String.(a.trio_sname)
p = String.(a.low_or_high)
rr = Vector{String}(undef, 512)
rt = Vector{String}(undef, 512)
eq = Vector{String}(undef,512)

c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	
	for i in 1:512
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:512
	q1 = b[j]
	q2 = SubString(q1,1,1)
	q3 = SubString(q1,2,2)
	q4 = SubString(q1,3,3)
		if occursin("BBB", q1)
			eq[j] = "r = cos(t)"	
			rt[j] = "(0, 2*pi)"
		elseif q2 == "B" && q4 == "B"
			eq[j] = "r^2 = cos(2*t)"
			rt[j] = "(0, pi)"
		elseif occursin("BB", q1)
			eq[j] = "r^2 = cos(2*t)"
			rt[j] = "(0, pi)"
		elseif q2 == "B" && q4 == "W"
			eq[j] = "[colour] a = cos(t), [B,W] r = b^2*x^2+c^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [B] +ve z-axis, [W] -ve z-axis)" 
		elseif q2 == "W" && q4 == "B"
			eq[j] = "[colour] a = cos(t), [W,B] r = b^2*x^2+c^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [W] +ve z-axis, [B] -ve z-axis)"  
		elseif occursin("B", q1)
			eq[j] = "[colour] a^2 = cos(2*t), [B] r = b^2*x^2+c^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [B] +ve z-axis)"
		elseif occursin("WWW", q1)
			eq[j] = "r = cos(t)"
			rt[j] = "(0, 2*pi)"
		elseif q2 == "W" && q4 == "W"
			eq[j] = "r^2 = cos(2*t)"
			rt[j] = "(0, pi)"
		elseif occursin("WW", q1)
			eq[j] = "r^2 = cos(2*t)"
			rt[j] = "(0, pi)"
		elseif occursin("W", q1)
			eq[j] = "[colour] a^2 = cos(2*t); a < r, [W] r = a^2*x^2+b^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [W] +ve z-axis)"	
		elseif q2 == q3 && q3 == q4
			eq[j] = "a = cos(t)"
			rt[j] = "(0,2*pi)"
		elseif q2 == q3 || q3 == q4 || q2 == q4
			eq[j] = "a^2 = cos(2*t); a < r"
			rt[j] = "(0,pi)"
		else eq[j] = "a = cos(3*t)"
			rt[j] = "(0 < t < pi; a < r)" 
		end	
	end
	
	for k in 1:512
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = [rt[k]], inversion = ["no"])
	c = append!(c, df)
	end
	return c
end

#Trio points - inversion
function invrelateTrios(colourtableTier3)

a = invBuildtableTrio(colourtableTier3)
b = String.(a.trio_sname)
p = String.(a.low_or_high)
rr = Vector{String}(undef, 512)
rt = Vector{String}(undef, 512)
eq = Vector{String}(undef,512)

c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	
	for i in 1:512
	q1 = b[i]
	
		if p[i] == "high"
			rr[i] = "0,1"
		elseif p[i] == "low"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:512
	q1 = b[j]
	q2 = SubString(q1,1,1)
	q3 = SubString(q1,2,2)
	q4 = SubString(q1,3,3)
		if occursin("BBB", q1)
			eq[j] = "r = sin(t)"	
			rt[j] = "(0, 2*pi)"
		elseif q2 == "B" && q4 == "B"
			eq[j] = "r^2 = sin(2*t)"
			rt[j] = "(0, pi)"
		elseif occursin("BB", q1)
			eq[j] = "r^2 = sin(2*t)"
			rt[j] = "(0, pi)"
		elseif q2 == "B" && q4 == "W"
			eq[j] = "[colour] a = sin(t), [B,W] r = b^2*x^2+c^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [B] +ve z-axis, [W] -ve z-axis)" 
		elseif q2 == "W" && q4 == "B"
			eq[j] = "[colour] a = sin(t), [W,B] r = b^2*x^2+c^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [W] +ve z-axis, [B] -ve z-axis)"  
		elseif occursin("B", q1)
			eq[j] = "[colour] a^2 = sin(2*t), [B] r = b^2*x^2+c^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [B] +ve z-axis)"
		elseif occursin("WWW", q1)
			eq[j] = "r = sin(t)"
			rt[j] = "(0, 2*pi)"
		elseif q2 == "W" && q4 == "W"
			eq[j] = "r^2 = sin(2*t)"
			rt[j] = "(0, pi)"
		elseif occursin("WW", q1)
			eq[j] = "r^2 = sin(2*t)"
			rt[j] = "(0, pi)"
		elseif occursin("W", q1)
			eq[j] = "[colour] a^2 = sin(2*t); a < r, [W] r = a^2*x^2+b^2*z^2"
			rt[j] = "([colour] 0,2*pi; a < r, [W] +ve z-axis)"	
		elseif q2 == q3 && q3 == q4
			eq[j] = "a = sin(t)"
			rt[j] = "(0,2*pi)"
		elseif q2 == q3 || q3 == q4 || q2 == q4
			eq[j] = "a^2 = sin(2*t); a < r"
			rt[j] = "(0,pi)"
		else eq[j] = "a = sin(3*t)"
			rt[j] = "(0 < t < pi; a < r)" 
		end	
	end
	
	for k in 1:512
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = [rt[k]], inversion = ["yes"])
	c = append!(c, df)
	end
	return c
end


#---------------------------


function relatesTrios(X)

a = BuildtableTrio(colourtableTier3)
a = filter(:trio_sname => ==(X), a)
b = String.(a.trio_sname[1])
p = String.(a.low_or_high[1])

c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	if p == "low"
		rr = "0,1"
	elseif p == "high"
		rr = "-1,0"
	end
		
	if occursin("W", X)
		q1 = replace(X, "W" => "")
		l = length(q1)
		l1 = string(length(q1), base = 10)
		eq = "r = b^2*x^2+c^2*z^2, a = cos(n*t) for n = "
		eq = eq*l1
		
			if l > 0
			rt = "0 < t < pi/n for n = "
			rt = rt*l1
			
			elseif length(q1) == 0
			eq = "a = cos(n*t) for n = "
			eq = eq*l1
			rt = "0 < t < 2*pi/n for n = "
			rt = rt*l1	
			end	
	
	else 
		l = length(X)
		l1 = string(length(X), base = 10)
		eq = "a = cos(n*t) for n = "
		eq = eq*l1
		rt = "0 < t < 2*pi/n for n = "
		rt = rt*l1
	end

	df = DataFrame(sname = [b], equation = [eq], range_r = [rr], range_t = [rt], inversion = ["no"])
	c = append!(c, df)
	return c
end

#---------------------

#Quads#
function relateQuads(colourtableTier3)

a = BuildtableQuad3(colourtableTier3)
b = String.(a.quad_sname)
b1 = a.quad_sname
p = String.(a.low_or_high)
l = length(b)
rr = Vector{String}(undef, l)
rt = Vector{String}(undef, l)
eq = Vector{String}(undef, l)
df1 = relate(colourtableTier3)
df2 = relateTrios(colourtableTier3)
c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	
	for i in 1:l
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:l
	q1 = b[j]
		if occursin("B", q1)
			q1 = replace(q1, "B" => "")
				if length(q1) == 3
				r1 = relatesTrios(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 2
				r1 = relatesPairs(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 1
				eq[j] = "r^2 = cos(2*t)"
				rt[j] = "0 < t < pi"
				else eq[j] = "r = cos(t)"
					rt[j] = "0 < t < 2*pi" 
				end
		elseif occursin("W", q1)
			q1 = replace(q1, "W" => "")
			l1 = string(length(q1), base = 10)
			eq[j] = "r = b^2*x^2+c^2*z^2, a = cos(n*t) for n = "
			eq[j] = eq[j]*l1
				if length(q1) > 0
				rt[j] = "0 < t < pi/n for n = "
				rt[j] = rt[j]*l1
				
				elseif length(q1) == 0
				eq[j] = "a = cos(n*t) for n = "
				eq[j] = eq[j]*l1
				rt[j] = "0 < t < 2*pi/n for n = "
				rt[j] = rt[j]*l1	
				end	
		else 
			l1 = string(length(q1), base = 10)
			if occursin("O", q1) || occursin("G", q1) || occursin("P", q1)
				eq[j] = "a = cos(n*t) for n = 6"
				rt[j] = "0 < t < 2*pi/n for n = 6"
			else 	eq[j] = "a = cos(n*t) for n = 3"
				rt[j] = "0 < t < 2*pi/n for n = 3"
			end
		end
	end	
		for k in 1:l
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = [rt[k]], inversion = ["no"])
	c = append!(c, df)
		end

	return c
end
	
	
	






#Quints
function relateQuints(colourtableTier3)

a = BuildtableQuint3(colourtableTier3)
b = String.(a.quint_sname)
b1 = a.quint_sname
p = String.(a.low_or_high)
l = length(b)
rr = Vector{String}(undef, l)
rt = Vector{String}(undef, l)
eq = Vector{String}(undef, l)
df1 = relate(colourtableTier3)
df2 = relateQuads(colourtableTier3)
c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	
	for i in 1:l
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:l
	q1 = b[j]
		if occursin("B", q1)
			q1 = replace(q1, "B" => "")
				if length(q1) == 4
				r1 = relatesQuads(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 3
				r1 = relatesTrios(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 2
				r1 = relatesPairs(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 1
				eq[j] = "r^2 = cos(2*t)"
				rt[j] = "0 < t < pi"
				else eq[j] = "r = cos(t)"
					rt[j] = "0 < t < 2*pi" 
				end
		elseif occursin("W", q1)
			q1 = replace(q1, "W" => "")
			l1 = string(length(q1), base = 10)
			eq[j] = "r = b^2*x^2+c^2*z^2, a = cos(n*t) for n = "
			eq[j] = eq[j]*l1
				if length(q1) > 0
				rt[j] = "0 < t < pi/n for n = "
				rt[j] = rt[j]*l1
				
				elseif length(q1) == 0
				eq[j] = "a = cos(n*t) for n = "
				eq[j] = eq[j]*l1
				rt[j] = "0 < t < 2*pi/n for n = "
				rt[j] = rt[j]*l1	
				end	
		else 
			l1 = string(length(q1), base = 10)
			if occursin("O", q1) || occursin("G", q1) || occursin("P", q1)
				eq[j] = "a = cos(n*t) for n = 6"
				rt[j] = "0 < t < 2*pi/n for n = 6"
			else 	eq[j] = "a = cos(n*t) for n = 3"
				rt[j] = "0 < t < 2*pi/n for n = 3"
			end
		end
	end	
		for k in 1:l
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = [rt[k]], inversion = ["no"])
	c = append!(c, df)
		end

	return c
end



#Sixts
function relateSixts(colourtableTier3)

a = BuildtableSixts3(colourtableTier3)
b = String.(a.sixt_sname)
b1 = a.sixt_sname
p = String.(a.low_or_high)
l = length(b)
rr = Vector{String}(undef, l)
rt = Vector{String}(undef, l)
eq = Vector{String}(undef, l)
df1 = relate(colourtableTier3)
df2 = relateQuints(colourtableTier3)
c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	
	for i in 1:l
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:l
	q1 = b[j]
		if occursin("B", q1)
			q1 = replace(q1, "B" => "")
				if length(q1) == 5
				r1 = relatesQuints(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 4
				r1 = relatesQuads(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 3
				r1 = relatesTrios(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 2
				r1 = relatesPairs(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 1
				eq[j] = "r^2 = cos(2*t)"
				rt[j] = "0 < t < pi"
				else eq[j] = "r = cos(t)"
					rt[j] = "0 < t < 2*pi" 
				end
		elseif occursin("W", q1)
			q1 = replace(q1, "W" => "")
			l1 = string(length(q1), base = 10)
			eq[j] = "r = b^2*x^2+c^2*z^2, a = cos(n*t) for n = "
			eq[j] = eq[j]*l1
				if length(q1) > 0
				rt[j] = "0 < t < pi/n for n = "
				rt[j] = rt[j]*l1
				
				elseif length(q1) == 0
				eq[j] = "a = cos(n*t) for n = "
				eq[j] = eq[j]*l1
				rt[j] = "0 < t < 2*pi/n for n = "
				rt[j] = rt[j]*l1	
				end	
		else 
			l1 = string(length(q1), base = 10)
			if occursin("O", q1) || occursin("G", q1) || occursin("P", q1)
				eq[j] = "a = cos(n*t) for n = 6"
				rt[j] = "0 < t < 2*pi/n for n = 6"
			else 	eq[j] = "a = cos(n*t) for n = 3"
				rt[j] = "0 < t < 2*pi/n for n = 3"
			end
		end
	end	
		for k in 1:l
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = [rt[k]], inversion = ["no"])
	c = append!(c, df)
		end

	return c
end








#Septs

function relateSixts(colourtableTier3)

a = BuildtableSixts3(colourtableTier3)
b = String.(a.sixt_sname)
b1 = a.sixt_sname
p = String.(a.low_or_high)
l = length(b)
rr = Vector{String}(undef, l)
rt = Vector{String}(undef, l)
eq = Vector{String}(undef, l)
df1 = relate(colourtableTier3)
df2 = relateQuints(colourtableTier3)
c = DataFrame(sname = [], equation = [], range_r = [], range_t = [], inversion = [])
	
	for i in 1:l
	q1 = b[i]
	
		if p[i] == "low"
			rr[i] = "0,1"
		elseif p[i] == "high"
			rr[i] = "-1,0"
		end
	end
	
	for j in 1:l
	q1 = b[j]
		if occursin("B", q1)
			q1 = replace(q1, "B" => "")
				if length(q1) == 6
				r1 = relatesSixts(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 5
				r1 = relatesQuints(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 4
				r1 = relatesQuads(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 3
				r1 = relatesTrios(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 2
				r1 = relatesPairs(q1)
				eq[j] = r1.equation[1]
				rt[j] = r1.range_t[1]
				elseif length(q1) == 1
				eq[j] = "r^2 = cos(2*t)"
				rt[j] = "0 < t < pi"
				else eq[j] = "r = cos(t)"
					rt[j] = "0 < t < 2*pi" 
				end
		elseif occursin("W", q1)
			q1 = replace(q1, "W" => "")
			l1 = string(length(q1), base = 10)
			eq[j] = "r = b^2*x^2+c^2*z^2, a = cos(n*t) for n = "
			eq[j] = eq[j]*l1
				if length(q1) > 0
				rt[j] = "0 < t < pi/n for n = "
				rt[j] = rt[j]*l1
				
				elseif length(q1) == 0
				eq[j] = "a = cos(n*t) for n = "
				eq[j] = eq[j]*l1
				rt[j] = "0 < t < 2*pi/n for n = "
				rt[j] = rt[j]*l1	
				end	
		else 
			l1 = string(length(q1), base = 10)
			if occursin("O", q1) || occursin("G", q1) || occursin("P", q1)
				eq[j] = "a = cos(n*t) for n = 6"
				rt[j] = "0 < t < 2*pi/n for n = 6"
			else 	eq[j] = "a = cos(n*t) for n = 3"
				rt[j] = "0 < t < 2*pi/n for n = 3"
			end
		end
	end	
		for k in 1:l
	df = DataFrame(sname = [b[k]], equation = [eq[k]], range_r = [rr[k]], range_t = [rt[k]], inversion = ["no"])
	c = append!(c, df)
		end

	return c
end




