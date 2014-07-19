local function contain_match(needle, haystack)
    local needle_idx = 1
    local needle_char = needle[needle_idx]
    local match_indexes = {}

    for i = 1, #haystack do
        local haystack_char = haystack[i]

        if haystack_char == needle_char then
            match_indexes[needle_idx] = i

            needle_idx = needle_idx + 1

            if needle_idx > #needle then
                break
            end

            needle_char = needle[needle_idx]

        elseif needle_idx > 1 then

            needle_idx = 1
            needle_char = needle[needle_idx]
        end
    end

    if needle_idx > #needle then
        return match_indexes
    end

    return nil
end


return {
    match = contain_match,
    score = import('utils/matchers/fuzzy').score
}

