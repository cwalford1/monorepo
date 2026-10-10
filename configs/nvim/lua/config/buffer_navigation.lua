--- Share buffer shortcut letters between bufferline labels and navigation mappings.
local alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
local buffer_letters = {}
local letter_buffers = {}

local function buffer_label(buf)
	-- Release letters belonging to closed or unlisted buffers.
	for id, letter in pairs(buffer_letters) do
		if not vim.api.nvim_buf_is_valid(id) or not vim.bo[id].buflisted then
			buffer_letters[id] = nil
			letter_buffers[letter] = nil
		end
	end

	local letter = buffer_letters[buf.bufnr]
	if not letter then
		local initial = buf.name:sub(1, 1)
		local candidates = initial .. alphabet
		for candidate in candidates:gmatch(".") do
			if alphabet:find(candidate, 1, true) and not letter_buffers[candidate] then
				letter = candidate
				buffer_letters[buf.bufnr] = letter
				letter_buffers[letter] = buf.bufnr
				break
			end
		end
	end
	return letter and string.format("%s (%s)", buf.name, letter) or buf.name
end

return {
	alphabet = alphabet,
	label = buffer_label,
	go_to = function(letter)
		local id = letter_buffers[letter]
		if id and vim.api.nvim_buf_is_valid(id) and vim.bo[id].buflisted then
			vim.api.nvim_set_current_buf(id)
		end
	end,
}
