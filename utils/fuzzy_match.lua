local function fuzzy_match(needle, haystack)
    local needle_idx = 1

    needle = needle:lower()
    haystack = haystack:lower()
    local needle_char = needle:sub(needle_idx, needle_idx)
    local last_needle_char
    local match_indexes = {}

    for i = 1, #haystack do
        local haystack_char = haystack:sub(i, i)
        if haystack_char == last_needle_char then
            match_indexes[#match_indexes] = i

        elseif haystack_char == needle_char then
            table.insert(match_indexes, i)
            needle_idx = needle_idx + 1
            if needle_idx > #needle then
                break
            end
            last_needle_char = needle_char
            needle_char = needle:sub(needle_idx, needle_idx)
        end
    end

    if needle_idx > #needle then
        return match_indexes
    end

    return nil
end

local function fuzzy_score(needle, haystack, match_indexes)
    local match_difs = 0
    for i = 1, #match_indexes - 1 do
        match_difs = match_difs + match_indexes[i + 1] - match_indexes[i]
    end

    return match_difs
end

return {
    match = fuzzy_match,
    score = fuzzy_score
}

