-- Fast, startswith matcher.
-- Will match goog to /Goog/le Chrome.

local function startswith_match(needle, haystack)
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

        else
            return nil
        end

    end

    if needle_idx > #needle then
        return match_indexes
    end

    return nil
end


return {
    match = startswith_match,
    score = import('utils/matchers/fuzzy').score
}

