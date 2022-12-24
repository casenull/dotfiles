-- Add ./after to the package path
package.path = os.getenv("HOME") .. "/.config/nvim/after/?.lua;" .. package.path

require("casenull")
